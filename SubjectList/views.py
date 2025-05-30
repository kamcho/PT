import base64
import logging
import os
import random
import uuid
from django.db import transaction

# from ElasticEmail.model.email_content import EmailContent
# from ElasticEmail.model.body_part import BodyPart
# from ElasticEmail.model.body_content_type import BodyContentType
# import ElasticEmail
# from ElasticEmail.api import emails_api
# from ElasticEmail.model.email_message_data import EmailMessageData
# from ElasticEmail.model.email_recipient import EmailRecipient
from django.db.models import Q

from django.conf import settings
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.db import DatabaseError, IntegrityError
from django.db.models import Count
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect
from django.utils import timezone
from openai import OpenAI
import openai

from Exams.models import ClassTest, ClassTestStudentTest, StudentTest, TopicalQuizes
from Guardian.models import MyKids
from SubjectList.models import AIFiles, Completion, Prompt, RateLimiter, Subject, Subtopic, Progress, TopicExamNotifications, Topic, TopicalExamResults, Course, \
     AccountInquiries
# from Teacher.models import ClassTestNotifications
from Teacher.models import MyClass
from Users.models import AcademicProfile, PersonalProfile, StudentProfile, Students
from django.views.generic import TemplateView

logger = logging.getLogger('django')
class IsAdmin(UserPassesTestMixin):
    def test_func(self):
        if self.request.user.is_authenticated:
            return self.request.user.role == 'Supervisor'
        else:
            return False
class CreateCourse(IsAdmin,TemplateView):
    template_name = 'SubjectList/create_course.html'

    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        courses = Course.objects.all()
        context['courses'] = courses
        return context
    
    def post(self, args, **kwargs):
        if self.request.method == 'POST':
            name = self.request.POST.get('subject')
            discipline = self.request.POST.get('type')
            try:
                course = Course.objects.create(name=name, discipline=discipline)
            except IntegrityError:
                messages.error(self.request, 'Course Already Exists !!')

            return redirect(self.request.get_full_path())
        
class ManageCourse(IsAdmin,TemplateView):
    template_name = 'SubjectList/manage_course.html'

    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        course_id = self.kwargs['id']
        course = Course.objects.get(id=course_id)
        subjects = Subject.objects.filter(course__id=course_id)
        context['subjects'] = subjects
        context['course'] = course
        return context
    
    def post(self, args, **kwargs):
        if self.request.method == 'POST':
            course = self.get_context_data().get('course')
            if 'purge' in self.request.POST:
                option = self.request.POST.get('option')
                if option == 'delete':
                    purge = course.delete()
                    messages.success(self.request, f'Successfully deleted {course} from system !!')
                else:
                    messages.warning(self.request, f'Wrong entry. {course} was not deleted!')
                    return redirect(self.request.get_full_path)

                return redirect('create-course')
            else:
                name = self.request.POST.get('set_name')
                grade = self.request.POST.get('set_grade')
                
                topics_count = self.request.POST.get('set_count')
                try:
                    subject = Subject.objects.create(name=name, topics=topics_count, grade=grade, course=course)
                    
                except:
                    messages.error(self.request, 'Error when creating this object. Please complete the form!')



                return redirect(self.request.get_full_path())
            
class ManageSubject(IsAdmin,TemplateView):
    template_name = 'SubjectList/manage_subject.html'

    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        subject = self.kwargs['id']
        subject = Subject.objects.get(id=subject)
        topics = Topic.objects.filter(subject__id=subject.id).order_by('order')
        context['topics'] = topics
        context['subject'] = subject

        return context
    
    def post(self, args, **kwargs):
        if self.request.method == 'POST':
            subject = self.get_context_data().get('subject')
            name = self.request.POST.get('set_name')
            order = self.request.POST.get('set_order')
            subtopics = self.request.POST.get('set_subtopics')
            test_size = self.request.POST.get('set_size')
            time = self.request.POST.get('set_time')
            if 'delete' in self.request.POST:
                command = self.request.POST.get('option')
                if command == 'delete':
                    delete = subject.delete()

                    messages.success(self.request, f'Successfully deleted {subject.name} grade {subject.grade} from system')
                else:
                    messages.error(self.request, 'Wrong command. Try again !')

                return redirect('create-course')
            else:
                try:
                    topic = Topic.objects.create(subject=subject, name=name, order=order, time=time,
                                              topics_count=subtopics, test_size=test_size)
                except:
                    messages.error(self.request, 'Error while creating topic. Fill the form completely')
                

                return redirect(self.request.get_full_path())

class ManageTopic(IsAdmin,TemplateView):
    template_name = 'SubjectList/manage_topic.html'

    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        topic = self.kwargs['id']
        topic = Topic.objects.get(id=topic)
        subtopics = Subtopic.objects.filter(topic__id=topic.id)
        context['subtopics'] = subtopics
        context['topic'] = topic

        return context
    
    def post(self, args, **kwargs):
        if self.request.method == 'POST':
            if 'delete' in self.request.POST:
                command = self.request.POST.get('option')
                if command == 'delete':

                    topic = self.kwargs['id']
                    topic = self.get_context_data().get('topic')
                    delete = topic.delete()
                    messages.success(self.request, f'You have successfully deleted { topic } from the system')

                    return redirect('create-course')
                else:
                    messages.error(self.request, 'Invalid command! Object was not deleted')
                    return redirect(self.request.get_full_path())
            else:
                name = self.request.POST.get('set_name')
                order = self.request.POST.get('set_order')
                topic_id = self.get_context_data().get('topic')
                subject = topic_id.subject
                subtopic = Subtopic.objects.create(name=name, order=order, subject=subject, topic=topic_id)

                return redirect(self.request.get_full_path())

class ManageSubTopic(IsAdmin,TemplateView):
    template_name = 'SubjectList/manage_subtopic.html'

    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        subtopic = self.kwargs['id']
        
        subtopics = Subtopic.objects.get(id=subtopic)

        context['subtopic'] = subtopics

        return context
    
    def post(self, args, **kwargs):
        if self.request.method == 'POST':
            subtopic = self.get_context_data().get('subtopic')
            if 'delete' in self.request.POST:
                command = self.request.POST.get('option')
                if command == 'delete':
                    delete = subtopic.delete()
                    messages.success(self.request, f'Successfuly deleted { subtopic.name } from system')
                    return redirect('create-course')
                else:
                    messages.error(self.request, 'Invalid command The object was not deleted !')
                    return redirect(self.request.get_full_path())
            
            else:
                pdf = self.request.FILES.get('set_pdf')
                video = self.request.FILES.get('set_video')
                order = self.request.POST.get('set_order')
                subtopic.file1 = pdf
                subtopic.file2 = video
                subtopic.order = order
                subtopic.save()

                messages.success(self.request, f'Successfuly updated {subtopic.name}')

                return redirect(self.request.get_full_path())



class IsStudent(UserPassesTestMixin):
    def test_func(self):
        if self.request.user.is_authenticated:

            return self.request.user.role == 'Student'
        else:
            return False
class IsMyParent(UserPassesTestMixin):
    def test_func(self):
        if self.request.user.is_authenticated:
            adm_no = self.kwargs['adm_no']
            return MyKids.objects.filter(kids__adm_no=adm_no).exists()
        else:
            return False
def send_mail(user, subject, body):
    """

    :param user: a users email
    :param subject: e-mail subject
    :param body: email-body
    :return: none
    """
    
    configuration = ElasticEmail.Configuration()
    configuration.api_key[
        'apikey'] = settings.APIKEY

    with ElasticEmail.ApiClient(configuration) as api_client:
        api_instance = emails_api.EmailsApi(api_client)
        email_message_data = EmailMessageData(
            recipients=[
                EmailRecipient(
                    email=f'{user}',
                    fields={
                        "name": "User",
                    },
                ),
            ],
            content=EmailContent(
                body=[
                    BodyPart(
                        content_type=BodyContentType("HTML"),
                        content=f"{body}",
                        charset="utf-8",
                    ),

                ],
                _from="njokevin9@gmail.com",
                reply_to="myemail@gmail.com",
                subject=f"{subject}",
            ),
        )

        try:
            api_response = api_instance.emails_post(email_message_data)

        except ElasticEmail.ApiException as e:
            pass



class Tests(LoginRequiredMixin, IsStudent, TemplateView):
    template_name = 'SubjectList/tests.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        excluded1= StudentTest.objects.filter(user=user).values('uuid')
        test1 = TopicExamNotifications.objects.filter(user=user).exclude(uuid__in=excluded1)
        academic_profile = AcademicProfile.objects.get(user=user)
        current_class = StudentList.objects.filter(students=user).values_list('id')

        # If no current_class is found raise ValueError
        if current_class:
            excluded = ClassTestStudentTest.objects.filter(user=user).values('test')
            if excluded:
            
                assignments = ClassTest.objects.filter(class_id__id__in=current_class).exclude(uuid__in=excluded)
            else:
                assignments = ClassTest.objects.filter(class_id__id__in=current_class)
        else:
            # messages.error(self.request, 'You have not set your grade. Contact @support')
            assignments = []
        if not test1 and not assignments:
            messages.info(self.request, 'You do not have any undone tests.')

        context['tests'] = list(test1) + list(assignments)


        # Fetch assignments for the current class
        return context
    

class Learning(LoginRequiredMixin, IsMyParent, TemplateView):
    """
    View to display subjects by grade for learning.
    """
    template_name = 'SubjectList/select_subject.html'

    def get_context_data(self, **kwargs):
        """
        Retrieve and display subjects by grade.

        This method fetches subjects from the database based on the provided grade,
        and displays them in the template.

        Args:
            (str): The grade for which subjects should be displayed.

        Returns:
            dict: A dictionary containing context data for the template.
        """
        context = super().get_context_data(**kwargs)
        grade = self.kwargs['grade']
        adm = self.kwargs['adm_no']

        try:
            context['student'] = Students.objects.get(adm_no=adm)           # Display subjects by Grade
            subjects = Subject.objects.filter(grade=grade, status='1')
            print(subjects)
            if not subjects:
                messages.warning(self.request, 'We could not find Subjects matching your query!!')
                raise Subject.DoesNotExist
            context['subjects'] = subjects
        except Subject.DoesNotExist as e:
            # Handle database operational error

            context['subjects'] = None  # Set subjects to None to indicate error
            error_message = f"Grade {grade} subjects are not available at this time.\
            Don't be alarmed we are fixing this issue."  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'Subject',
                }
            )

        except Exception as e:
            # Handle other unexpected exceptions
            # messages.error(self.request, f'An error occurred. Please contact @support for assistance. {str(e)}')
            context['subjects'] = None  # Set subjects to None to indicate error
            error_message = f"Grade {grade} subjects are not available"  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'Subject',
                }
            )

        return context

    


class Read(LoginRequiredMixin, TemplateView):
    """
    View to read subtopics by name and topic.
    """
    template_name = 'SubjectList/read.html'

    def get_context_data(self, **kwargs):
        """
        Retrieve and display a subtopic for reading.

        This method fetches a subtopic from the database based on the provided name and topic,
        and displays it in the template.

        Args:
            (str): The name of the subtopic.
            (str): The name of the topic.

        Returns:
            dict: A dictionary containing context data for the template.
        """
        context = super().get_context_data(**kwargs)
        name = self.kwargs.get('subtopic')
        topic = self.kwargs.get('topic')
        media = self.kwargs.get('media')

        try:
            # Get subtopic to be displayed
            context['subject'] = Subtopic.objects.get(name=name, topic__name=topic)
            context['media'] = media
        except Subtopic.MultipleObjectsReturned as e:
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'Subtopic',
                }
            )
            # Handle the case where multiple objects were returned
            context['subject'] = Subtopic.objects.filter(name=name, topic__name=topic).first()
        except Subtopic.DoesNotExist as e:
            # Handle the case where no objects were returned
            messages.error(self.request, "An error occurred!. Please do not edit the url!!."
                                         " If the issue persists contact @support")
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'Subtopic',
                }
            )
            context['subject'] = None
        except Exception as e:
            # Handle any DB error by redirecting to the home page
            messages.error(self.request, "An error occurred!. We are fixing it.")
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'Subtopic',
                }
            )
            return redirect('student-home')

        return context


class SubtopicInfo(LoginRequiredMixin, TemplateView):
    template_name = 'SubjectList/subtopic_info.html'

    def get_context_data(self, **kwargs):
        """
        choose preferred media type for reading for reading.
        Args:
            (str): The name of the subtopic.
            (str): The name of the topic.

        Returns:
            dict: A dictionary containing context data for the template.
        """
        context = super().get_context_data(**kwargs)
        # 1. Kenyan Male English Names
        
            
        





        try:
            adm_no = self.kwargs['adm_no']
            context['student'] = Students.objects.get(adm_no=adm_no)
            if 'index' in self.request.session:
                del self.request.session['index']
            subtopic = self.kwargs.get('subtopic')
            subtopic = Subtopic.objects.get(id=subtopic)
            context['subtopic'] = subtopic
            quizes = TopicalQuizes.objects.filter(subtopic=subtopic).order_by('?')
            if quizes.count():
                if quizes.count() >= 10:
                    context['size'] = 10
                    if subtopic.subject.name == 'Mathematics':
                        context['time'] = 30
                    else:
                        context['time'] = 25
                else:
                    context['size'] = quizes.count()
                    if subtopic.subject.name == 'Mathematics':
                        context['time'] = round(quizes.count() * 3)
                    else:
                        context['time'] = round(quizes.count() * 2.5)
                

            
        except:
            messages.error(self.request, 'An error occured. DO NOT EDIT URL!!!')

        return context
    
    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            user = self.get_context_data().get('student')
            if 'index' in self.request.session:
                del self.request.session['index']
            duration = self.get_context_data().get('time')
            test_size = self.get_context_data().get('size')
            subtopic = self.get_context_data().get('subtopic')

            try:

                test = StudentTest.objects.create(
                    user=user,
                    subject=subtopic.subject,
                    # uuid=test_uuid,
                    topic=subtopic.topic,
                    test_size=test_size,
                    duration=duration
                )

                # Retrieve and add a set of quizzes to the test
                quizzes = TopicalQuizes.objects.filter(subtopic=subtopic).order_by('?')[:test_size]
                test.quiz.add(*quizzes)
                
                self.request.session['test_mode'] = 'test_mode'
                
                
                subject = subtopic.subject
                topic = subtopic.topic
                # Redirect to the 'tests' view with appropriate arguments
                about = f'{user.studentprofile.get_names().title()} {subject}: {topic} test quiz is ready.'
                message = f'The quiz for {topic}  is now ready. This test is designed to test your understanding in this topic and all its subtopics. Once started, the quiz will finish in 15 minutes. ' \
                          'Good luck.'

                # Check if user's progress already exists for the subtopic
                my_progress = Progress.objects.filter(user=user, topic=topic)
                is_progress = my_progress.filter(subtopic=subtopic)

                if my_progress:
                    if is_progress:
                        messages.success(request, 'Your progress has been successfully saved.')
                    else:
                        try:
                            # Create a new progress record
                            messages.success(request, 'Your progress has been successfully saved')
                            progress = Progress.objects.get(user=user, topic=topic, subject=subject)

                            progress.subtopic.add(subtopic)
                            progress.save()
                        except Exception as e:
                            # Handle IntegrityError (duplicate progress)
                            messages.error(request, "Oops! That didn't work. Please try again. "
                                                    "If the problem persists, please contact the admin!")
                            error_message = str(e)  # Get the error message as a string
                            error_type = type(e).__name__

                            logger.critical(
                                error_message,
                                exc_info=True,  # Include exception info in the log message
                                extra={
                                    'app_name': __name__,
                                    'url': self.request.get_full_path(),
                                    'school': settings.SCHOOL_ID,
                                    'error_type': error_type,
                                    'user': self.request.user,
                                    'level': 'Critical',
                                    'model': 'Progress',
                                }
                            )
                            return redirect(request.get_full_path())

                        # Check if all subtopics are completed
                        total_topics = topic.topics_count
                        all_subtopics = my_progress.values('subtopic').distinct().count()
                        if all_subtopics == int(total_topics):
                            try:
                                # Create a notification for completed topic. this notification will be used to create
                                # Topical Tests.
                                notification = TopicExamNotifications.objects.create(user=user, about=about,
                                                                                     notification_type='topical-quiz',
                                                                                     subject=subject, message=message,
                                                                                     topic=topic,
                                                                                     date=timezone.now())
                                messages.success(self.request, f'You have completed {topic}, Take the topical assesment test from the Exam panel.')

                                # Compose email body
                                body = f"Dear {user.studentprofile.get_names()}, We are thrilled to congratulate you on " \
                                       f"successfully completing the {topic} in {subject}! Your dedication and hard work " \
                                       f"are truly commendable, and we applaud your commitment to your studies. To " \
                                       f"further enhance your understanding and mastery of the topic, " \
                                       f"we have prepared a tailored test exclusively for you. This test is designed to " \
                                       f"challenge your knowledge and reinforce your grasp of the concepts covered in {topic}" \
                                       f"and identify areas for further improvement. Your results will provide valuable " \
                                       f"insights into your progress and guide your learning journey." \
                                       f"If you have any questions or encounter any issues," \
                                       f"please feel free to reach out to our support team, and" \
                                       f"we will be more than happy to assist you. Keep up the great work, and we look" \
                                       f"forward to your continued success in your studies! \n"

                                # Send email
                                # send_mail(user=user.email, subject=about, body=body)
                            except Exception as e:
                                # Handle IntegrityError during notification creation
                                messages.error(request, 'Sorry, we could not complete your request. If the problem '
                                                        'persists, please contact the @support')
                                error_message = str(e)  # Get the error message as a string
                                error_type = type(e).__name__

                                logger.critical(
                                    error_message,
                                    exc_info=True,  # Include exception info in the log message
                                    extra={
                                        'app_name': __name__,
                                        'url': self.request.get_full_path(),
                                        'school': settings.SCHOOL_ID,
                                        'error_type': error_type,
                                        'user': self.request.user,
                                        'level': 'Critical',
                                        'model': 'TopicExamNotifications',
                                    }
                                )
                                return redirect(request.get_full_path())
                else:
                    try:
                        # Create a new progress record
                        messages.success(request, 'Your progress has been successfully saved')
                        progress = Progress.objects.create(user=user, subject=subject)
                        progress.topic.add(topic)
                        progress.subtopic.add(subtopic)
                        progress.save()
                    except Exception as e:
                        # Handle IntegrityError (duplicate progress)
                        messages.error(request, "Oops! That didn't work. Please try again. "
                                                "If the problem persists, please contact the admin!")
                        error_message = str(e)  # Get the error message as a string
                        error_type = type(e).__name__

                        logger.critical(
                            error_message,
                            exc_info=True,  # Include exception info in the log message
                            extra={
                                'app_name': __name__,
                                'url': self.request.get_full_path(),
                                'school': settings.SCHOOL_ID,
                                'error_type': error_type,
                                'user': self.request.user,
                                'level': 'Critical',
                                'model': 'Progress',
                            }
                        )
                        return redirect(request.get_full_path())

                    # Check if all subtopics are completed
                    total_topics = topic.topics_count
                    all_subtopics = my_progress.values('subtopic').distinct().count()
                    if all_subtopics == int(total_topics):
                        try:
                            # Create a notification for completed topic. this notification will be used to create
                            # Topical Tests.
                            notification = TopicExamNotifications.objects.create(user=user, about=about,
                                                                                 notification_type='topical-quiz',
                                                                                 subject=subject, message=message,
                                                                                 topic=topic,
                                                                                 date=timezone.now())

                            # Compose email body
                            body = f"Dear {user.personalprofile.f_name}, We are thrilled to congratulate you on " \
                                   f"successfully completing the {topic} in {subject}! Your dedication and hard work " \
                                   f"are truly commendable, and we applaud your commitment to your studies. To " \
                                   f"further enhance your understanding and mastery of the topic, " \
                                   f"we have prepared a tailored test exclusively for you. This test is designed to " \
                                   f"challenge your knowledge and reinforce your grasp of the concepts covered in {topic}" \
                                   f"and identify areas for further improvement. Your results will provide valuable " \
                                   f"insights into your progress and guide your learning journey." \
                                   f"If you have any questions or encounter any issues," \
                                   f"please feel free to reach out to our support team, and" \
                                   f"we will be more than happy to assist you. Keep up the great work, and we look" \
                                   f"forward to your continued success in your studies! \n"

                            # Send email
                            send_mail(user=user.email, subject=about, body=body)
                        except Exception as e:
                            # Handle IntegrityError during notification creation
                            messages.error(request, 'Sorry, we could not complete your request. If the problem '
                                                    'persists, please contact the @support')
                            error_message = str(e)  # Get the error message as a string
                            error_type = type(e).__name__

                            logger.critical(
                                error_message,
                                exc_info=True,  # Include exception info in the log message
                                extra={
                                    'app_name': __name__,
                                    'url': self.request.get_full_path(),
                                    'school': settings.SCHOOL_ID,
                                    'error_type': error_type,
                                    'user': self.request.user,
                                    'level': 'Critical',
                                    'model': 'TopicExamNotifications',
                                }
                            )
                
                return redirect('tests', user.adm_no,'Topical', test.uuid)
            except:
                messages.error(self.request, 'An error occured. @contact support')
                return redirect(self.request.get_full_path())



class MediaSelect(LoginRequiredMixin, TemplateView):
    template_name = 'SubjectList/media.html'

    def get_context_data(self, **kwargs):
        """
        choose preferred media type for reading for reading.

   
        Args:
            (str): The name of the subtopic.
            (str): The name of the topic.

        Returns:
            dict: A dictionary containing context data for the template.
        """
        context = super().get_context_data(**kwargs)
        subtopic = self.kwargs.get('subtopic')
        topic = self.kwargs.get('topic')
        context['topic'] = topic
        context['subtopic'] = subtopic
        role = self.request.user.role
        if role == 'Student':
            context['base_html'] = 'Users/base.html'
        elif role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        else:
            context['base_html'] = 'Guardian/baseg.html'

        return context


class Finish(LoginRequiredMixin, IsStudent, TemplateView):
    """
    Save user's learning progress.
    """
    template_name = 'SubjectList/finish.html'

    def get_context_data(self, **kwargs):
        """
        Retrieve and display a subtopic for finishing.

        This method fetches a subtopic from the database based on the provided name and topic,
        and displays it in the template.

        Args:
            subtopic (str): The name of the subtopic.
            topic (str): The primary key (topic name) of the topic.

        Returns:
            dict: A dictionary containing context data for the template.
        """
        context = super().get_context_data(**kwargs)
        try:
            # Get subtopic based on URL parameters
            subtopic = Subtopic.objects.get(name=self.kwargs['subtopic'], topic__name=self.kwargs['topic'])
            context['subtopic'] = subtopic
        except (Subtopic.DoesNotExist, Subtopic.MultipleObjectsReturned) as e:
            # Handle the case where no matching subtopic was found
            messages.error(self.request, 'We could not find results matching your query. Please do not edit the URL!!')
            context['subtopic'] = None
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'Subtopic',
                }
            )

        return context

    def post(self, request, **kwargs):
        """
        Handle the POST request to save learning progress.

        Args:
            request: The HTTP request object.
            **kwargs: Additional keyword arguments from the URL.

        Returns:
            HttpResponseRedirect: Redirects to the appropriate view.
        """
        if request.method == 'POST':
            user = request.user
            try:
                # Get the subtopic based on the context data
                topic = self.kwargs['topic']
                subtopic = Subtopic.objects.get(name=self.kwargs['subtopic'], topic__name=topic)
                topic = subtopic.topic
                subject = subtopic.subject
                topic_uuid = str(subtopic.topic.id).split("'")[0]
                subtopic_uuid = str(subtopic.id).split("'")[0]

                print(subtopic)

                # Create notification message
                about = f'{subject}: {topic} test quiz is ready.'
                message = f'The quiz for {topic}  is now ready. This test is designed to test your understanding in this topic and all its subtopics. Once started, the quiz will finish in 15 minutes. ' \
                          'Good luck.'

                # Check if user's progress already exists for the subtopic
                my_progress = Progress.objects.filter(user=user, topic=topic)
                is_progress = my_progress.filter(subtopic=subtopic)

                if my_progress:
                    if is_progress:
                        messages.success(request, 'Your progress has been successfully saved.')
                    else:
                        try:
                            # Create a new progress record
                            messages.success(request, 'Your progress has been successfully saved')
                            progress = Progress.objects.get(user=user, topic=topic, subject=subject)

                            progress.subtopic.add(subtopic)
                            progress.save()
                        except Exception as e:
                            # Handle IntegrityError (duplicate progress)
                            messages.error(request, "Oops! That didn't work. Please try again. "
                                                    "If the problem persists, please contact the admin!")
                            error_message = str(e)  # Get the error message as a string
                            error_type = type(e).__name__

                            logger.critical(
                                error_message,
                                exc_info=True,  # Include exception info in the log message
                                extra={
                                    'app_name': __name__,
                                    'url': self.request.get_full_path(),
                                    'school': settings.SCHOOL_ID,
                                    'error_type': error_type,
                                    'user': self.request.user,
                                    'level': 'Critical',
                                    'model': 'Progress',
                                }
                            )
                            return redirect(request.get_full_path())

                        # Check if all subtopics are completed
                        total_topics = topic.topics_count
                        all_subtopics = my_progress.values('subtopic').distinct().count()
                        if all_subtopics == int(total_topics):
                            try:
                                # Create a notification for completed topic. this notification will be used to create
                                # Topical Tests.
                                notification = TopicExamNotifications.objects.create(user=user, about=about,
                                                                                     notification_type='topical-quiz',
                                                                                     subject=subject, message=message,
                                                                                     topic=topic,
                                                                                     date=timezone.now())
                                messages.success(self.request, f'You have completed {topic}, Take the topical assesment test from the Exam panel.')

                                # Compose email body
                                body = f"Dear {user.personalprofile.f_name}, We are thrilled to congratulate you on " \
                                       f"successfully completing the {topic} in {subject}! Your dedication and hard work " \
                                       f"are truly commendable, and we applaud your commitment to your studies. To " \
                                       f"further enhance your understanding and mastery of the topic, " \
                                       f"we have prepared a tailored test exclusively for you. This test is designed to " \
                                       f"challenge your knowledge and reinforce your grasp of the concepts covered in {topic}" \
                                       f"and identify areas for further improvement. Your results will provide valuable " \
                                       f"insights into your progress and guide your learning journey." \
                                       f"If you have any questions or encounter any issues," \
                                       f"please feel free to reach out to our support team, and" \
                                       f"we will be more than happy to assist you. Keep up the great work, and we look" \
                                       f"forward to your continued success in your studies! \n"

                                # Send email
                                send_mail(user=user.email, subject=about, body=body)
                            except Exception as e:
                                # Handle IntegrityError during notification creation
                                messages.error(request, 'Sorry, we could not complete your request. If the problem '
                                                        'persists, please contact the @support')
                                error_message = str(e)  # Get the error message as a string
                                error_type = type(e).__name__

                                logger.critical(
                                    error_message,
                                    exc_info=True,  # Include exception info in the log message
                                    extra={
                                        'app_name': __name__,
                                        'url': self.request.get_full_path(),
                                        'school': settings.SCHOOL_ID,
                                        'error_type': error_type,
                                        'user': self.request.user,
                                        'level': 'Critical',
                                        'model': 'TopicExamNotifications',
                                    }
                                )
                                return redirect(request.get_full_path())
                else:
                    try:
                        # Create a new progress record
                        messages.success(request, 'Your progress has been successfully saved')
                        progress = Progress.objects.create(user=user, subject=subject)
                        progress.topic.add(topic)
                        progress.subtopic.add(subtopic)
                        progress.save()
                    except Exception as e:
                        # Handle IntegrityError (duplicate progress)
                        messages.error(request, "Oops! That didn't work. Please try again. "
                                                "If the problem persists, please contact the admin!")
                        error_message = str(e)  # Get the error message as a string
                        error_type = type(e).__name__

                        logger.critical(
                            error_message,
                            exc_info=True,  # Include exception info in the log message
                            extra={
                                'app_name': __name__,
                                'url': self.request.get_full_path(),
                                'school': settings.SCHOOL_ID,
                                'error_type': error_type,
                                'user': self.request.user,
                                'level': 'Critical',
                                'model': 'Progress',
                            }
                        )
                        return redirect(request.get_full_path())

                    # Check if all subtopics are completed
                    total_topics = topic.topics_count
                    all_subtopics = my_progress.values('subtopic').distinct().count()
                    if all_subtopics == int(total_topics):
                        try:
                            # Create a notification for completed topic. this notification will be used to create
                            # Topical Tests.
                            notification = TopicExamNotifications.objects.create(user=user, about=about,
                                                                                 notification_type='topical-quiz',
                                                                                 subject=subject, message=message,
                                                                                 topic=topic,
                                                                                 date=timezone.now())

                            # Compose email body
                            body = f"Dear {user.personalprofile.f_name}, We are thrilled to congratulate you on " \
                                   f"successfully completing the {topic} in {subject}! Your dedication and hard work " \
                                   f"are truly commendable, and we applaud your commitment to your studies. To " \
                                   f"further enhance your understanding and mastery of the topic, " \
                                   f"we have prepared a tailored test exclusively for you. This test is designed to " \
                                   f"challenge your knowledge and reinforce your grasp of the concepts covered in {topic}" \
                                   f"and identify areas for further improvement. Your results will provide valuable " \
                                   f"insights into your progress and guide your learning journey." \
                                   f"If you have any questions or encounter any issues," \
                                   f"please feel free to reach out to our support team, and" \
                                   f"we will be more than happy to assist you. Keep up the great work, and we look" \
                                   f"forward to your continued success in your studies! \n"

                            # Send email
                            send_mail(user=user.email, subject=about, body=body)
                        except Exception as e:
                            # Handle IntegrityError during notification creation
                            messages.error(request, 'Sorry, we could not complete your request. If the problem '
                                                    'persists, please contact the @support')
                            error_message = str(e)  # Get the error message as a string
                            error_type = type(e).__name__

                            logger.critical(
                                error_message,
                                exc_info=True,  # Include exception info in the log message
                                extra={
                                    'app_name': __name__,
                                    'url': self.request.get_full_path(),
                                    'school': settings.SCHOOL_ID,
                                    'error_type': error_type,
                                    'user': self.request.user,
                                    'level': 'Critical',
                                    'model': 'TopicExamNotifications',
                                }
                            )
                            return redirect(request.get_full_path())

            except DatabaseError as e:
                # Handle DatabaseError
                messages.error(request, "Oops! That didn't work. Please try again. "
                                        "If the problem persists, please contact the admin!")
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'Database',
                    }
                )
                return redirect(request.get_full_path())

        return redirect('student-home')


class Syllabus(LoginRequiredMixin, TemplateView):
    template_name = 'SubjectList/syllabus.html'

    def get_context_data(self, **kwargs):
        """
        Retrieve and display the syllabus for a subject.

        This method fetches the topics associated with the specified subject and displays them in the template.

        Args:
            subject_id (str): The ID of the subject.

        Returns:
            dict: A dictionary containing context data for the template.
        """
        context = super().get_context_data(**kwargs)

        try:
            adm_no = self.kwargs['adm_no']
            student = Students.objects.get(adm_no=adm_no)
            context['student'] = student
            subject_id = self.kwargs.get('subject_id')

            # Fetch topics for the specified subject and order them
            topics = Topic.objects.filter(subject__id=subject_id).order_by('order')

            if not topics:
                # Display a message if no topics are found
                # messages.success(self.request, 'We could not find results matching your query!!')
                pass
            else:
                # Add data to context
                context['subject'] = topics.last()
                context['syllabus'] = topics

        except Exception as e:
            messages.error(self.request, 'An error occurred, We are fixing it.')

            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',
                }
            )

        return context


class Assignment(LoginRequiredMixin,  TemplateView):
    """
    View for viewing assignments based on the current class of the user.
    """
    template_name = 'SubjectList/assignment.html'

    def get_context_data(self, **kwargs):
        """
        Retrieve and display assignments for the current class.

        This method fetches assignments associated with the current class of the user and displays them in the template.

        Args:
            **kwargs: Additional keyword arguments from the URL.

        Returns:
            dict: A dictionary containing context data for the template.
        """
        context = super().get_context_data(**kwargs)
        user = Students.objects.get(adm_no=self.kwargs['adm_no'])
        try:
            
            # Fetch assignments for the current class
            assignments = ClassTest.objects.filter(class_id=user.academicprofile.current_class)
            print(assignments)
            context['assignments'] = assignments
            context['now'] = timezone.now().date()  # Add current date to context
            if not assignments:
                messages.info(self.request, 'You do not have any pending assignments.')

        
        except Exception as e:
            # Handle DatabaseError
            messages.error(self.request, str(e))
            context['assignments'] = 'error'
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',
                }
            )

        return context


class AssignmentDetail(LoginRequiredMixin, TemplateView):
    """
    View class assignments details
    """
    template_name = 'SubjectList/assignment_lobby.html'

    def get_context_data(self, **kwargs):
        context = super(AssignmentDetail, self).get_context_data(**kwargs)  # Include 'request' as an argument here
        test_uuid_str = self.kwargs.get('uuid')
        if 'index' in self.request.session:
                del self.request.session['index']
        if 'test_mode' in self.request.session:
            del self.request.session['test_mode']
        try:
            test_uuid = uuid.UUID(test_uuid_str)  # Convert the string to a UUID object
        except ValueError:
            # Handle invalid UUID format
            messages.error(self.request, 'Invalid UUID format. Please do not edit the url !!.')

        try:
            test = ClassTest.objects.get(uuid=test_uuid_str)
            context['assignment'] = test
            context['user'] = Students.objects.get(adm_no=self.kwargs['adm_no'])
        except (ClassTest.DoesNotExist, ClassTest.MultipleObjectsReturned) as e:
            # Handle assignment not found
            messages.error(self.request,
                           'Oops, We could not find a matching assignment. Please do not edit the url. Try again or contact @support.')

            # Handle DatabaseError

            context['assignments'] = 'error'
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'ClassTest',
                    'object_id': test_uuid_str,
                }
            )


        except Exception as e:
            # Handle other unexpected exceptions
            messages.error(self.request, f'An error occurred: {e}. Please contact the admin for assistance.')
            context['assignments'] = 'error'
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',
                    'object_id': test_uuid_str,
                }
            )

        return context

   

    def post(self, request, **kwargs):
        """
        Handle the POST request to create a test for a learner related to the class test.
        """
        if request.method == "POST":
            user = Students.objects.get(adm_no=self.kwargs['adm_no'])
            test_uuid = self.kwargs['uuid']  # Assuming you have 'uuid' in your URL kwargs
            if 'index' in self.request.session:
                del self.request.session['index']
            if 'test_mode' in self.request.session:
                del self.request.session['test_mode']
            try:
                # Get class test instance from cache
                class_test = self.get_context_data().get('assignment')

                # Create a ClassTestStudentTest object
                save_test = ClassTestStudentTest.objects.create(user=user, test=class_test, finished=False)
                self.request.session['test_mode'] = 'test_mode'

                # Redirect to the 'tests' view with appropriate arguments
                return redirect('tests',user.adm_no, 'ClassTests', test_uuid)

            except Exception as e:
                # Handle IntegrityError
                messages.error(request, 'Sorry, we could not create a test for you. Please contact Admin')
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'ClassTestStudentTest',
                        'object_id': test_uuid,
                    }
                )
                return redirect(request.get_full_path())


class Messages(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    """
    View for displaying notifications and messages to users.
    """
    template_name = 'SubjectList/messages.html'

    # noinspection PyBroadException
    def get_context_data(self, **kwargs):
        """
        Retrieve and organize notifications based on the user's role.

        This method fetches and organizes notifications based on the user's role and displays them in the template.

        Args:
            **kwargs: Additional keyword arguments from the URL.

        Returns:
            dict: A dictionary containing context data for the template.
        """
        context = super().get_context_data(**kwargs)
        user = self.request.user

        # Determine the base HTML template based on the user's role
        
        if user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        else:
            context['base_html'] = 'Users/base.html'

        # Fetch and organize notifications based on user's role
        try:
            if user.role == "Student":
                class_id = user.academicprofile.current_class
                # Fetch relevant notifications for students
                topical_exam_results = TopicalExamResults.objects.filter(user=user).order_by('-date')
                topical_exam = TopicExamNotifications.objects.filter(user=user).order_by('-date')
                class_test_notifications = ClassTestNotifications.objects.filter(class_id=class_id).order_by('-date')

                # Combine and order notifications
                notifications = list(topical_exam) + list(topical_exam_results)  + list(
                    class_test_notifications)

                if not notifications:
                    messages.info(self.request, 'You do not have any Notifications.')
                context['notifications'] = notifications



        except Exception as e:
            messages.error(self.request, 'Sorry, we could not get your messages. Contact @support')

            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',
                }
            )

        return context
    
    def test_func(self):
        return self.request.user.role in ['Student', 'Teacher']


class MyProgress(LoginRequiredMixin, IsStudent, TemplateView):
    """
    View for displaying user's progress in different subjects.
    """
    template_name = 'SubjectList/progress.html'

    def get_context_data(self, **kwargs):
        """
        Retrieve and display user's progress in different subjects.

        This method fetches the user's progress in different subjects and displays it in the template.

        Args:
            **kwargs: Additional keyword arguments from the URL.

        Returns:
            dict: A dictionary containing context data for the template.
        """
        context = super().get_context_data(**kwargs)

        try:
            grade = self.kwargs['grade']

            # Fetch the user's progress in different subjects
            subject_progress = Progress.objects.filter(user=self.request.user, subject__grade=grade).values(
                'subject__name', 'subject__topics', 'subject__grade', 'subject__id').annotate(
                topic_count=Count('topic', distinct=True))

            if not subject_progress:
                messages.warning(self.request, f'You do not have any saved Learning history for grade {grade}.')

            context['subject'] = subject_progress




        except Exception as e:
            # Handle other exceptions with a generic error message
            messages.error(self.request, 'Database Error! Were Fixing it')
            context['subject'] = None
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )

        return context


class ContactUs(LoginRequiredMixin, TemplateView):
    template_name = 'SubjectList/contact.html'

    def get_context_data(self, **kwargs):
        context = super(ContactUs, self).get_context_data(**kwargs)

        role = self.request.user.role
        if role == 'Student':
            context['base_html'] = 'Users/base.html'
        elif role == 'Guardian':
            context['base_html'] = 'Guardian/baseg.html'
        elif role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'

        return context

    def post(self, request, **kwargs):
        """
        Handle user inquiries based on the 'about' field.

        This method handles different types of user inquiries based on the 'about' field and stores them in the database.

        Args:
            request (HttpRequest): The HTTP request object.
            **kwargs: Additional keyword arguments from the URL.

        Returns:
            HttpResponseRedirect: Redirects the user to the appropriate page.
        """
        user = request.user
        message = request.POST.get('message')


        try:

            # Create an AccountInquiry record
            AccountInquiries.objects.create(user=user, message=message)
            messages.info(self.request, 'We have received your request. Please be patient as we try to resolve your issues.')
            if self.request.user.role == 'Student':
                return redirect('student-home')
            elif self.request.user.role == 'Teacher':
                return redirect('teachers-home')
            else:
                return redirect('guardian-home')


        except Exception as e:
            # Handle database-related errors and invalid data errors
            messages.error(request, 'An error occurred. Please try again or contact @support.')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )

        return redirect(request.get_full_path())


class AskAi(TemplateView):
    template_name = 'SubjectList/ask.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        student = Students.objects.get(adm_no=self.kwargs['adm_no'])
        context['student'] = student
        prompts = list(
    Prompt.objects.filter(user=student)
    .prefetch_related('file', 'completion_set')
    .order_by('-id')[:3]
)[::-1]



        print(prompts)
        context['prompts'] = prompts
    

        return context




def chatgpt_answer(request):
    if request.method == 'POST':
        try:
            # Log the incoming request data
            print("Request POST data:", request.POST)
            print("Request FILES:", request.FILES)
            
            # Get request data with fallbacks
            adm_no = request.POST.get('adm_no')
            prompt = request.POST.get('prompt') or request.POST.get('message')
            images = request.FILES.getlist('images[]') or request.FILES.getlist('file')
            
            # Log the extracted data
            print(f"Extracted data - adm_no: {adm_no}, prompt: {prompt}, images count: {len(images)}")
            
            # Validate adm_no - check for empty string or None
            if not adm_no:
                print("Error: Empty or missing adm_no parameter")
                return JsonResponse({
                    'error': 'You are not allowed to use this service'
                }, status=403)
                
            if not prompt:
                print("Error: Message content is required")
                return JsonResponse({
                    'error': 'Message content is required'
                }, status=400)
            
            # Get student and rate limiter
            try:
                student = Students.objects.get(adm_no=adm_no)
                rate = RateLimiter.objects.get(user=request.user)
                print(f"Found student: {student}, rate limit: {rate.tokens}")
            except Students.DoesNotExist:
                print(f"Error: Student not found for adm_no: {adm_no}")
                return JsonResponse({
                    'error': 'Student account not found. Please make sure you are logged in as a student.'
                }, status=404)
            except RateLimiter.DoesNotExist:
                rate = RateLimiter.objects.create(user=request.user, tokens=100, image=0, speech=0)
                print(f"Created new rate limiter for user")
            
            # Check rate limit
            if rate.tokens <= 0:
                print(f"Error: Rate limit exceeded for student: {adm_no}")
                return JsonResponse({
                    'answer': 'You have consumed your tokens. Please subscribe to continue with the experience. Thank you!'
                })
            
            # Get recent chat history
            prompts = Prompt.objects.filter(user=student).order_by('-id')[:5]
            messages = []
            
            # Add system message with student context
            try:
                academia = AcademicProfile.objects.get(user=student)
                profile = StudentProfile.objects.get(user=student)
                grade = academia.current_class.grade
                name = profile.get_names()
                messages.append({
                    "role": "system",
                    "content": f"You are a helpful assistant for a grade {grade} student named {name}. Use simple language since you are talking to a child."
                })
            except (AcademicProfile.DoesNotExist, StudentProfile.DoesNotExist):
                messages.append({
                    "role": "system",
                    "content": "You are a helpful assistant. Use simple language since you are talking to a child."
                })
            
            # Add chat history
            if prompts:
                for prompt_obj in prompts:
                    try:
                        completion = Completion.objects.get(prompt=prompt_obj)
                        messages.append({
                            'role': 'assistant',
                            'content': completion.response
                        })
                    except Completion.DoesNotExist:
                        pass
                    messages.append({
                        "role": "user",
                        "content": prompt_obj.quiz
                    })
            messages.reverse()
            
            # Create new prompt
            quiz = Prompt.objects.create(user=student, quiz=prompt)
            
            # Handle image upload if present
            if images:
                try:
                    upload = AIFiles.objects.create(file=images[0])
                    quiz.file.add(upload)
                    
                    with open(upload.file.path, "rb") as image_file:
                        encoded_string = base64.b64encode(image_file.read()).decode('utf-8')
                        data_url = f"data:image/{upload.file.name.split('.')[-1]};base64,{encoded_string}"
                    
                    messages.append({
                        "role": "user",
                        "content": [
                            {
                                "type": "text",
                                "text": prompt
                            },
                            {
                                "type": "image_url",
                                "image_url": {
                                    "url": data_url
                                }
                            }
                        ]
                    })
                    model = "gpt-4o"
                except Exception as e:
                    print(f"Error processing image: {str(e)}")
                    messages.append({"role": "user", "content": prompt})
                    model = "gpt-3.5-turbo"
            else:
                messages.append({"role": "user", "content": prompt})
                model = "gpt-3.5-turbo"
            
            # Call OpenAI API
            try:
                print("Calling OpenAI API with model:", model)
                SECRET_KEY = os.getenv("SECRET_KEY")
                # print(SECRET_KEY)
                # SECRET_KEY = 
                client = OpenAI(api_key=SECRET_KEY)
                response = client.chat.completions.create(
                    model=model,
                    messages=messages,
                    temperature=0.8,
                    n=1
                )
                
                # Process response
                response_text = response.choices[0].message.content
                tokens_used = response.usage.total_tokens
                
                # Update rate limiter
                rate.tokens = max(0, rate.tokens - tokens_used)
                rate.save()
                
                # Save completion
                completion = Completion.objects.create(prompt=quiz, response=response_text)
                
                print("Successfully processed request and got response")
                return JsonResponse({
                    'answer': response_text,
                    'prompt_id': quiz.id,
                    'completion_id': completion.id
                })
                
            except Exception as e:
                print(f"OpenAI API error: {str(e)}")
                return JsonResponse({
                    'error': 'Error processing your request. Please try again later.'
                }, status=500)
                
        except Exception as e:
            print(f"General error: {str(e)}")
            return JsonResponse({
                'error': 'An unexpected error occurred. Please try again later.'
            }, status=500)
    
    return JsonResponse({
        'error': 'Invalid request method'
    }, status=405)
