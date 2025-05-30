import datetime
import logging
import random
from django.conf import settings
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Count
from django.http import JsonResponse
from django.shortcuts import redirect, render
from django.utils import timezone
from Exams.models import ClassTest, TopicalQuizes, TopicalQuizAnswers, StudentsAnswers, ClassTestStudentTest
from SubjectList.models import Course, Topic, Subtopic
from Users.models import AcademicProfile, Classes
from .models import *
from django.views.generic import TemplateView
from django.db import IntegrityError, DatabaseError

logger = logging.getLogger('django')

class IsTeacher(UserPassesTestMixin):
    def test_func(self):
        
        if self.request.user.is_authenticated:
            return self.request.user.role == 'Teacher'
        else:
            return False
    

class TeacherView(IsTeacher, TemplateView):
    """
        Teachers home page
    """
    template_name = 'Teacher/teachers_home.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
    
        # Get teachers classes
        my_class = MyClass.objects.filter(user=user)
        # count = QuestionCount.objects.get(user=user).count
        # context['count'] = count
        teaching_profile, created = TeacherProfile.objects.get_or_create(user=user)
        context['subjects'] = teaching_profile.subject.all()
        context['classes'] = my_class
        return context
class ClassesView(IsTeacher, LoginRequiredMixin, TemplateView):
    """
        view teachers classes
    """
    template_name = 'Teacher/my_classes.html'

    def get_context_data(self, **kwargs):
        context = super(ClassesView, self).get_context_data(**kwargs)
        user = self.request.user
        try:
            # Get teachers classes
            my_class = MyClass.objects.filter(user=user)
            # count = QuestionCount.objects.get(user=user).count
            # context['count'] = count

            context['classes'] = my_class
            if not my_class:
                messages.warning(self.request, 'You have not been assigned any class yet!.')
        except Exception as e:
            messages.error(self.request, 'An error occurred when processing your request. Please try again later')

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


class TaskViewSelect(IsTeacher, LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/task_view_select.html'

    def get_context_data(self, **kwargs):
        context = super(TaskViewSelect, self).get_context_data(**kwargs)
        user = self.request.user  # get logged in user
        subject = self.kwargs['id']
        try:
            # Get class list
            my_class = StudentList.objects.get(user=self.request.user, id=subject)
            

            context['subject'] = my_class.subject
            # Get a few students in a class to display
            # Get a few tests to display
            tests = ClassTest.objects.filter(teacher=user, class_id=my_class)[:3]
            context['tests'] = tests
            print(my_class.students.all(), 'hjiop')
           
            context['students'] = my_class.students.all()
        except Exception as e:
            messages.error(self.request, str(e))

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


class StudentsView(IsTeacher, LoginRequiredMixin, TemplateView):
    """
        view students in a given class
    """
    template_name = 'Teacher/students_list.html'

    def get_context_data(self, **kwargs):
        context = super(StudentsView, self).get_context_data(**kwargs)
        class_id = self.kwargs['class']
        user = self.request.user
        try:
            # Get students in a given class
            students = StudentList.objects.get(user=user, id=class_id)
            context['students'] = students.students.all()

        except Exception as e:
            messages.error(self.request, 'An error occurred when processing your request. Please try again later')

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


class TestsView(IsTeacher, LoginRequiredMixin, TemplateView):
    """
        A view for a teacher to view tests he/she created for a specific class
    """
    template_name = 'Teacher/tests_view.html'

    def get_context_data(self, **kwargs):
        context = super(TestsView, self).get_context_data(**kwargs)
        user = self.request.user
        try:
            # Get class tests where author is the logged in user for specific class
            tests = ClassTest.objects.filter(teacher=user).order_by('-date')

            context['tests'] = tests
            context['today'] = datetime.date.today()
            # context['subject'] = 
        except Exception as e:
            messages.error(self.request, 'An error occurred when processing your request. Please try again later')

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


def get_failed_value_by_uuid(queryset, uuid_str):
    """
    Get the 'failed' value associated with a specific UUID from a queryset and return it.

    :param queryset: The queryset containing UUID-keyed values.
    :type queryset: QuerySet
    :param uuid_str: The UUID string to search for.
    :type uuid_str: str
    :return: The 'failed' value associated with the UUID or 0 if not found.
    :rtype: int
    """
    try:
        result_dict = {str(item['quiz']): item['failed'] for item in queryset}

        # Check if the UUID exists in the queryset
        if uuid_str in result_dict:
            return result_dict[uuid_str]

    except Exception as e:
        # Handle any unexpected errors and print the exception
        print(f"Error in get_failed_value_by_uuid: {str(e)}")

    return 0  # Return 0 if UUID not found or in case of any errors


class ClassTestAnalytics(LoginRequiredMixin, TemplateView):
    """
    Get a class's performance on a given test
    """

    template_name = 'Teacher/class_test_analytics.html'

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            command = self.request.POST.get('command')
            if command == 'delete':
                if self.request.user.role == 'Supervisor':
                    
                    test = self.get_context_data().get('test')
                    test.delete()
                    messages.success(self.request, 'Success')
                    return redirect('school-assignments')
                elif self.request.user.role == 'Supervisor':
                    messages.success(self.request, 'Success')
                    return redirect('teachers-home')
            else:
                messages.error(self.request, 'Invalid command')
            return redirect(self.request.get_full_path())

    def get_context_data(self, **kwargs):
        context = super(ClassTestAnalytics, self).get_context_data(**kwargs)
        # try:
        test_uuid = self.kwargs['uuid']  # Get test UUID from URL
        test_uuid = uuid.UUID(test_uuid)

        # Get the number of students who took the test
        test_instance = ClassTestStudentTest.objects.filter(test=test_uuid)
        test_count = int(test_instance.count())
        context['test_count'] = test_count

        class_test = ClassTest.objects.get(uuid=test_uuid)  # Get the class test
        context['test'] = class_test
        class_id = class_test.class_id
        members = AcademicProfile.objects.filter(current_class__class_id=class_id.class_id)
        dodgers = members.exclude(user__adm_no__in=test_instance.values_list('user__adm_no'))
        print(dodgers)
        context['fails'] = dodgers
        context['passes'] = test_instance
        print(test_instance, 'instanxe')

        

        context['class_size'] = members.count()  # Get the number of students in that class
        test_dict = {}
        index = 1
        performance_data = {}

        for quiz in class_test.quiz.all():  # Get all quizzes in a test
            test_dict[index] = quiz
            index += 1
        # print(test_dict)

        # Get all correct selections from students' class test
        passed_count = StudentsAnswers.objects.filter(test_object_id=test_uuid, is_correct=True).values(
            'quiz').annotate(failed=Count('quiz')).order_by('quiz')

        passed = StudentsAnswers.objects.filter(test_object_id=test_uuid, is_correct=True).values('quiz').distinct()
        passed_list = [item['quiz'] for item in passed]
        p_index = 1
        for choice in passed_list:
            for key, value in test_dict.items():
                relative = get_failed_value_by_uuid(passed_count, str(value))

                if str(choice) == str(value):
                    performance_data[int(key)] = relative
                    p_index += 1
                else:
                    performance_data[int(key)] = relative

        if performance_data:
            most_failed = min(performance_data, key=performance_data.get)
            most_passed = max(performance_data, key=performance_data.get)
            print(performance_data)

            context['passed'] = most_passed
            context['failed'] = most_failed

        context['quizzes'] = class_test.quiz.all()
        context['performance_data'] = performance_data

        # except ValueError as e:
        #     messages.error(self.request, 'Invalid UUID format. Do not edit the url!!')
        #     context['error'] = 'True'
        # except Exception as e:
        #     error_type = type(e).__name__
        #     if error_type == 'DoesNotExist':
        #         messages.error(self.request, 'We could not find this test. Do not edit the url !!. '
        #                                      'If you did not edit the url contact @support.')
        #     else:
        #         messages.error(self.request, str(e))

        #     error_message = str(e)  # Get the error message as a string


        #     logger.critical(
        #         error_message,
        #         exc_info=True,  # Include exception info in the log message
        #         extra={
        #             'app_name': __name__,
        #             'url': self.request.get_full_path(),
        #             'school': settings.SCHOOL_ID,
        #             'error_type': error_type,
        #             'user': self.request.user,
        #             'level': 'Critical',
        #             'model': 'DatabaseError',

        #         }
        #     )
        #     context['error'] = 'True'
        return context



class InitialiseCreateTest(IsTeacher, LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/initialise_create_test.html'

    def get_context_data(self, **kwargs):
        context = super(InitialiseCreateTest, self).get_context_data(**kwargs)
        id = self.kwargs['class']
        try:
            # get class list
            context['class'] = Classes.objects.get(class_id=id)

        except Exception as e:
            error_type = type(e).__name__
            if error_type == 'DoesNotExist':
                messages.error(self.request, 'Invalid class id. Do not edit the url!!.')
            else:
                messages.error(self.request, str(e))

            error_message = str(e)  # Get the error message as a string


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

    def post(self, request, **kwargs):
        if self.request.method == "POST":  # Handle POST requests

            # Get data from form
            
            exam_type = self.request.POST.get('exam-type')
            selection_type = self.request.POST.get('selection-type')
            size = self.request.POST.get('test-size')
            date = self.request.POST.get('date')

                # Parse data to a dict and add to session
            test_data = {'exam_type': exam_type, 'date': date, 'subject': self.kwargs['id'],
                            'selection_type': selection_type, 'size': size, 'class_id': self.kwargs['class']}
            self.request.session['test_data'] = test_data

            return redirect('test-topic-select')

            # else:
            #     return redirect(self.request.get_full_path())


class ClassTestSelectTopic(IsTeacher, LoginRequiredMixin, TemplateView):
    """
        A view to select topics to select questions from
    """
    template_name = 'Teacher/topic_select.html'

    def get_context_data(self, **kwargs):
        context = super(ClassTestSelectTopic, self).get_context_data(**kwargs)
        # get data from session
        class_id = self.request.session.get('test_data')['class_id']
        exam_type = self.request.session.get('test_data')['exam_type']
        subject = self.request.session.get('test_data')['subject']
        print(class_id, 'hjnkvrfv')
        subject = Subject.objects.get(id=subject)
        topics = Topic.objects.filter(subject=subject)  # filter topics by subject id
        print(topics)
        if not topics:
            messages.error(self.request, 'We could not find any topics of the said subject.'
                                         ' Did you edit the url on the previous page ??')

        context['topics'] = topics
        context['exam_type'] = exam_type
        return context

    def post(self, request, **kwargs):
        # Handle POST requests
        if request.method == "POST":
            selected = request.POST.getlist('selected')  # get all selected topics

            request.session['selected_topics'] = selected  # add selected topics to session
            try:
                if selected:
                    # get selection_type from session and reroute appropriately
                    selection_type = self.request.session.get('test_data')['selection_type']
                    if selection_type == 'user':
                        return redirect('user-question-selection')
                    elif selection_type == 'system':

                        return redirect('system-question-selection')


                else:
                    messages.info(request, 'Please select at least 1 topic.')
                    return redirect(self.request.get_full_path())
            except KeyError as e:
                messages.error(self.request, 'We encountered an error when processing your request.'
                                             ' Please restart test creation process.'
                                             ' If the problem persists contact @support')
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
                        'model': 'NoDatabase',

                    }
                )

        return redirect(self.request.get_full_path())



def SystemQuestionsSelect(request):
    """
        A view where the system randomly selects question for a test
    :param request:
    :return:
    """
    # Get data from session
    selected_topics = request.session.get('selected_topics')
    class_id = request.session['test_data']['class_id']
    test_size = int(request.session.get('test_data')['size'])
    subject = StudentList.objects.get(id=class_id).subject

    if test_size and subject and selected_topics:
        try:
            # get random topical questions of the specified test size
            quizzes = TopicalQuizes.objects.filter(subject=subject, topic__in=selected_topics).order_by('?')[:test_size]
            items = []
            # parse data
            if quizzes:
                for item in list(quizzes.values_list('id', flat=True)):
                    items.append(str(item))
                request.session['selected'] = items  # add the questions to session
        except Exception as e:
            messages.error(request, 'We could not find questions for the selected topics. Contact @support')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )


        return redirect('save-test')


def load_class(request):
    """
        Get class list of a teacher by subject
    :param request:
    :return:
    """
    default = {'None':'None'}
    subject = request.GET.get('subject')  # get subject from POST
    classes = StudentList.objects.filter(user=request.user, subject=subject)  # get class list by subject

    # parse data
    if classes:
        class_data = [{'id': class_obj.class_id.id, 'name': class_obj.class_id.class_name} for class_obj in classes]
        return JsonResponse(class_data, safe=False)
    else:
        return JsonResponse(default, safe=True)


def get_topical_quizzes(request):
    
    topic_id = request.GET.get('topic_id')
    print(topic_id, 'topic id')
    # Try to get the questions for the given topic_id
    questions = TopicalQuizes.objects.filter(topic_id=topic_id)
    if questions:

        # Prepare the data in a format suitable for JSON serialization
        questions_data = [{'id': question.id, 'quiz': question.quiz} for question in questions]

        return JsonResponse({'questions': questions_data})




def add_question_to_session(request):
    try:
        # Get the question_id from the POST request
        question_id = request.POST.get('question_id')

        # Retrieve the list of selected question_ids from the session, defaulting to an empty list if not present
        question_ids = request.session.get('selected', [])

        # Check if the question_id is not already in the list
        if question_id not in question_ids:
            # Append the new question_id to the list
            question_ids.append(question_id) 

            # Update the 'selected' key in the session with the modified list
            request.session['selected'] = question_ids

        # Return a JSON response with success and the length of the updated question_ids list
        return JsonResponse({'success': True, 'session_data': len(question_ids)})

    except Exception as e:
        # Handle any exceptions that may occur during this process
        return JsonResponse({'success': False, 'error_message': str(e)})


class UserQuestionsSelect(IsTeacher, LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/user_questions_select.html'

    def get_context_data(self, **kwargs):
        context = super(UserQuestionsSelect, self).get_context_data(**kwargs)

        # Retrieve data from the session, providing default values if not present
        subject = self.request.session.get('test_data', {}).get('subject', None)
        selected_topics = self.request.session.get('selected_topics', [])
        print(selected_topics, 'selected topics')

        try:
            # Query the Topic objects using the selected_topic IDs
            context['topics'] = Topic.objects.filter(id__in=selected_topics)
        except Exception as e:
            messages.error(self.request, 'An error occurred when processing your request. Please try again later !!')

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





class SaveTest(IsTeacher, LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/save_test.html'

    def get_context_data(self, **kwargs):
        context = super(SaveTest, self).get_context_data(**kwargs)

        try:
            print(self.request.session.get('test_data', {}).get('date', None))
            # Retrieve data from the session, providing default values if not present
            ids = self.request.session.get('selected', [])
            class_id = self.request.session.get('test_data', {}).get('class_id', None)
            subject_id = self.request.session.get('test_data', {}).get('subject', None)
            # Query the TopicalQuizes objects using the selected IDs
            context['subject'] = Subject.objects.get(id=subject_id)
            context['class'] = Classes.objects.get(class_id=class_id)
            quizes = TopicalQuizes.objects.filter(id__in=ids)
            context['quizzes'] = quizes

            # Query the SchoolClass object using the class_id
            

        except Exception as e:
            # Handle any exceptions that may occur during the database query
            messages.error(self.request, f'An error occured when processing your request.'
                                         f' You might be required to restart this process again !!.')
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

    def post(self, request, **kwargs):
        if self.request.method == "POST":
            teacher = self.request.user
            subject = self.get_context_data()['subject']
            size = self.request.session.get('test_data', {}).get('size', None)
            date = self.request.session.get('test_data', {}).get('date', None)
            class_id = self.get_context_data()['class']
           
            
            ids = self.request.session.get('selected', [])

            try:
                # Ensure subject, size, and date are not None before proceeding
                if subject is None or size is None or date is None:
                    raise ValueError('Missing required data.')


                # Create a ClassTest instance
                test = ClassTest(
                    teacher=teacher,
                    subject=subject,
                    test_size=size,
                    date=timezone.now(),
                    expiry=date,
                    class_id=class_id
                )
                test.save()
                test.quiz.add(*ids)
                messages.success(self.request, 'Test creations was successful')
                # Clear session data
                try:
                    del self.request.session['test_data']
                    del self.request.session['selected']
                except:
                    pass

                message = f'{subject} test is now available. Please finish before {date}.'
                about = f'{subject} class-test is now available.'
                notification_type = 'class-test'
                class_instance = ClassTest.objects.get(uuid=test.uuid)

                # Create a ClassTestNotifications instance
                # msg = ClassTestNotifications.objects.create(
                #     user=teacher,
                #     subject=subject_instance,
                #     class_id=class_id,
                #     test=class_instance,
                #     message=message,
                #     notification_type=notification_type,
                #     about=about,
                #     date=timezone.now()
                # )

                # Clear session data


                return redirect('class-test-analytics', test.uuid)

            except Exception as e:
                # Handle missing required data
                messages.error(self.request, str(e))
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

        return redirect(request.get_full_path())  # Return a bad request response if not a POST request

def load_topic(request):
    """
    function to get topics by subject id
    :param request:
    :return:
    """
    subject_id = request.GET.get('subject_id')  # get subject id from Post
    user = request.GET.get('tch')
    print('new', subject_id, 'user',user)

    # topics = Topic.objects.filter(subject=subject_id)  # get all topics from this subject
    # print(topics, '\n\n\n')
    topics = Topic.objects.filter(subject__id=subject_id)
    print(topics)
    print(topics, 'topics')
    topic_options = [{'id': topic.id, 'name': topic.name} for topic in topics]
    return JsonResponse(topic_options, safe=False)

def select_topic(request):
    """
    function to get topics by subject id
    :param request:
    :return:
    """
    subject_id = request.GET.get('subject_id')  # get subject id from Post
    user = request.GET.get('tch')
    print('new', subject_id, 'user',user)

    # topics = Topic.objects.filter(subject=subject_id)  # get all topics from this subject
    # print(topics, '\n\n\n')
    excluded = Topic.objects.filter(quizassignment__isnull=False).values_list('id', flat=True).distinct()

    topics_option = Topic.objects.filter(subject_id=subject_id).exclude(id__in=excluded)
    print(excluded)
    topics_list = [{'id': topic.id, 'name': topic.name} for topic in topics_option]

    return JsonResponse(topics_list, safe=False)

def load_subtopics(request):
    """
    Get  subtopics from a given topic
    :param request:
    :return:
    """
    topic_id = request.GET.get('topic_id')  # get topic_id from POST
    subtopics = Subtopic.objects.filter(topic_id=topic_id)  # get subtopics from a given topic
    subtopic_options = [{'id': subtopic.id, 'name': subtopic.name} for subtopic in subtopics]
    return JsonResponse(subtopic_options, safe=False)


class CreateQuestion(IsTeacher, LoginRequiredMixin, TemplateView):
    """
        A view to create questions
    """
    template_name = 'Teacher/create_question.html'

    def get_context_data(self, **kwargs):
        context = super(CreateQuestion, self).get_context_data(**kwargs)

        user = self.request.user
        if user.role == 'Teacher':
            # Handle question creation request from teachers
            try:
                # get teachers profile
                subjects = MyClass.objects.filter(user=user)
                ids = subjects.values('subject__name', 'subject__grade', 'subject__id')
                
            
                context['subjects'] = ids

            except Exception as e:
                messages.error(self.request,str(e))



            except Exception as e:
                # Handle multiple profiles returned
                messages.error(self.request, 'You have not been assigned any Topic! Contact @support')
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
                        'model': 'TeacherProfile',

                    }
                )
            # print(selected_subjects)
            # if not subjects:
            #     messages.warning(self.request, 'You have not selected any Subjects and can therefore, not add any '
            #                                    'questions.')
            #     context['subjects'] = None


            context['base_html'] = 'Teacher/teachers_base.html'
        elif user.role == 'Supervisor':
            # Handle question creation request from Supervisors
            context['subjects'] = Subject.objects.all()
            context['base_html'] = 'Supervisor/base.html'

        return context

    def post(self, request, **kwargs):
        if self.request.method == "POST":
            # get data from form
            subject = request.POST.get('subject')
            topic = request.POST.get('topic')
            sub_topic = request.POST.get('subtopic')
            quiz = request.POST.get('quiz')
            exam_type = request.POST.get('exam_type')

            user = self.request.user  # get user

            # Ensure all required data was received and add it to session
            if subject and topic and sub_topic:

                quiz_info = {'subject': subject, 'topic': topic, 'subtopic': sub_topic,
                             'quiz': quiz, 'exam_type': exam_type}
                request.session['quiz_info'] = quiz_info

                return redirect('add-answer')  # redirect to adding options

            # handle the case where all required data is not present
            messages.error(self.request, 'An error occurred, try again. If the error persists contact support')

            return redirect(request.get_full_path())


class AddAnswerSelection(IsTeacher, LoginRequiredMixin, TemplateView):
    """
        A view to add choices to previous added question
    """
    template_name = 'Teacher/add_answer.html'

    def get_context_data(self, **kwargs):
        context = super(AddAnswerSelection, self).get_context_data(**kwargs)
        try:
            quiz_info = self.request.session.get('quiz_info', None)  # get quiz from session to display
            context['quiz'] = quiz_info
            if not quiz_info:
                # Handle where key was not found
                messages.error(self.request, 'A key error occurred please follow protocol.'
                                             ' Youll need to restart the process again!!')
                context['error'] = 'error'
        except Exception as e:
            messages.error(self.request, 'An error occurred when processing your request. Please contact @support.')
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
                    'model': 'Exception',

                }
            )


        return context

    def post(self, request, **kwargs):
        # Handle POST requests
        if self.request.method == 'POST':
            user = request.user
            # get choices from form
            selection1 = self.request.POST.get('selection1')
            selection2 = self.request.POST.get('selection2')
            selection3 = self.request.POST.get('selection3')
            selection4 = self.request.POST.get('selection4')

            # Ensure all required data was received and add them to session
            if selection1 and selection2 and selection3 and selection4:
                try:
                    self.request.session['selection_info'] = {'selection1': selection1,
                                                              'selection2': selection2,
                                                              'selection3': selection3,
                                                              'selection4': selection4
                                                              }
                except Exception as e:

                    messages.error(self.request,
                                   'An error occurred when processing your request. Please contact @support.')
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
                            'model': 'TeacherProfile',

                        }
                    )
                # redirect based on role
                if user.role == 'Teacher':
                    return redirect('save-quiz')
                elif user.role == 'Supervisor':
                    return redirect('knec-add-quiz')

            else:
                return redirect(self.request.get_full_path())


class SaveQuiz(IsTeacher, LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/save_question.html'

    def get_context_data(self, **kwargs):
        context = super(SaveQuiz, self).get_context_data(**kwargs)
        try:
            # get data stored in session
            subtopic = self.request.session.get('quiz_info')['subtopic']
            quiz = self.request.session.get('quiz_info')['quiz']
            selection = self.request.session.get('selection_info')

            subtopic = Subtopic.objects.get(id=subtopic)  # get subtopic from DB
            context['quiz'] = quiz
            context['subtopic'] = subtopic
            context['selection'] = selection


        except Exception as e:
            # Handle any errors
            context['error'] = 'error'
            messages.error(self.request, 'An error occurred when processing your request. Please contact @support.')
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
                    'model': 'TeacherProfile',

                }
            )

        return context

    def post(self, request, **kwargs):
        # handle POST requests
        if request.method == 'POST':
            try:
                # Get data from context
                sub_topic = self.get_context_data().get('subtopic')
                quiz = self.get_context_data().get('quiz')
                session_selection_data = self.get_context_data().get('selection')
                file = request.FILES.get('file')
                

                # Get choices from session
                selection1 = session_selection_data['selection1']
                selection2 = session_selection_data['selection2']
                selection3 = session_selection_data['selection3']
                selection4 = session_selection_data['selection4']
                subtopic_uuid = sub_topic.id

                db_sub_topic = Subtopic.objects.get(id=subtopic_uuid)
                if db_sub_topic:
                    # Create a question and its choices
                    if file:
                        quiz = TopicalQuizes.objects.create(subject=db_sub_topic.subject, topic=db_sub_topic.topic,
                                                        subtopic=db_sub_topic, quiz=quiz, file=file)
                    else:
                        quiz = TopicalQuizes.objects.create(subject=db_sub_topic.subject, topic=db_sub_topic.topic,
                                                        subtopic=db_sub_topic, quiz=quiz)
                    selection_1 = TopicalQuizAnswers.objects.create(quiz=quiz, choice=selection1, is_correct=True) # correct choice

                    # False choices
                    selection_2 = TopicalQuizAnswers.objects.create(quiz=quiz, choice=selection2, is_correct=False)
                    selection_3 = TopicalQuizAnswers.objects.create(quiz=quiz, choice=selection3, is_correct=False)
                    selection_4 = TopicalQuizAnswers.objects.create(quiz=quiz, choice=selection4, is_correct=False)
                    count, obj = QuestionCount.objects.get_or_create(user=self.request.user)
                    count.quiz.add(quiz)
                    messages.success(self.request, 'You have successfully saved a question.')
            # Handle any errors that may arise

            except Exception as e:

                messages.error(self.request, 'An error occurred when processing your request. Please contact @support.')
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
                        'model': 'TeacherProfile',

                    }
                )
                return redirect(request.get_full_path())



        return redirect('create-questions')

class DashTasks(IsTeacher, LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/task_dash.html'
class DashBoard(IsTeacher, LoginRequiredMixin, TemplateView):
    """
        A view for teachers to manipulate their teaching profile
    """
    template_name = 'Teacher/dashboard.html'

    def get_context_data(self, **kwargs):
        context = super(DashBoard, self).get_context_data(**kwargs)
        try:
            # get student list, subjects and all classes
            my_class = StudentList.objects.filter(user=self.request.user)
            if not my_class:
                messages.info(self.request,'You do not have any classes attached. Add a class below')
            # print(my_class)
            try:
                t_profile = TeacherProfile.objects.get(user=self.request.user)
                subjects = t_profile.subject.all()
                context['subjects'] = subjects
            except:
                pass
            
            # subjects = Subject.objects.filter(subject_id__in=my_class)
            streams = SchoolClass.objects.all()
            
            context['classes'] = my_class
            context['streams'] = streams

        except Exception as e:
            # Handle any exceptions
            messages.error(self.request, str(e))
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
                    'model': 'TeacherProfile',

                }
            )

        return context

    def post(self, request):
        if request.method == 'POST':
            user = request.user
            try:
                # Handle POST requests to add a class to teaching profile
                if 'add' in request.POST:

                    subject = request.POST.get('subject')
                    class_id = request.POST.get('class_id')

                    subject = Subject.objects.get(id=subject)  # get subject by id
                    class_id = Classes.objects.get(class_id=class_id)  # get class by name
                    my_class = Classes.objects.filter(user=user, subject=subject, class_id=class_id)
                    

                elif 'delete' in request.POST:
                    # Handle POST requests to delete classes from teaching profile
                    subject = request.POST.get('del_subject')
                    class_id = request.POST.get('del_name')
                    print(class_id, subject)
                    my_class = StudentList.objects.filter(user=user, subject__name=subject,
                                                          class_id__class_id=class_id).first()
                    if my_class:
                        my_class.delete()  # delete object from db
                        messages.info(request, f'Successfully delete {class_id} from Watch List')


            except Exception as e:
                # Handle multiple objects returned
                messages.error(self.request, str(e))
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
                        'model': 'TeacherProfile',

                    }
                )
                return redirect(self.request.get_full_path())

        return redirect(self.request.get_full_path())


def get_subjects(request):
    """
        returns all subjects in a given grade
    :param request:
    :return Json:
    pri
    """
    print(request.user)
    selected_grade = request.GET.get("grade")  # get grade from POST
    # print(selected_grade)
    teachers_profile = TeacherProfile.objects.get(user=request.user)
    subjects = teachers_profile.subject.all().values_list('id')
    print('subjects:', subjects)
    try:
        grade = SchoolClass.objects.get(class_id=selected_grade).grade
        # Get subjects names and ids
        subjects = Subject.objects.filter(grade=grade,id__in=subjects).values("id", "name")
        print(subjects, 'uui')
        return JsonResponse({"subjects": list(subjects)})
    except (Exception, SchoolClass.DoesNotExist):
        return JsonResponse({"subjects": None})




class SubjectSelect(IsTeacher, LoginRequiredMixin, TemplateView):
    """ 
        Teacher subject manipulation
    """
    template_name = 'Teacher/subjects_select.html'

    def get_context_data(self, **kwargs):
        context = super(SubjectSelect, self).get_context_data(**kwargs)
        user = self.request.user
        try:
            # get teacher profile
            teaching_profile = TeacherProfile.objects.get(user=user)  # get users teaching profile
        except TeacherProfile.DoesNotExist:
            # create a TeacherProfile in case it doesnt exist
            teaching_profile = TeacherProfile.objects.create(user=user)
        try:
            subject_ids = teaching_profile.subject.all()
            subjects = Subject.objects.all()  # get all subjects

            # group subjects by grade
           
           
           
            # populate context data
            context['subjects'] = subject_ids
            context['courses'] = Course.objects.all()
           
            context['teaching_profile'] = teaching_profile

        except Exception as e:
            messages.error(self.request, 'An error occurred when processing your request. Please contact @support.')
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
                    'model': 'TeacherProfile',

                }
            )

        return context

    def post(self, args, **kwargs):
        if self.request.method == "POST":
            user = self.request.user
            subject = self.request.POST.getlist('subjects')
            if len(subject) > 4:
                messages.error(self.request, 'You can only select 4 subjects!')
                return redirect(self.request.get_full_path())
            else:
                try:
                    if 'profile' in self.request.POST:
                        # Handles adding subjects to teaching profile
                        # get selected subject(s)
                        
                        print('processing')
                        # get subject instance of selected subjects
                        subject_instance = Course.objects.filter(id__in=subject)
                        # get teaching profile from cache
                        teaching_profile = self.get_context_data().get('teaching_profile')
                        print(teaching_profile)
                        teaching_profile.subject.add(*subject_instance)  # add selected subjects to profile

                    elif 'purge' in self.request.POST:
                        # Handles deletion of subjects from teaching profile
                        button_id = self.request.POST.get('purge')

                        teacher_profile = self.get_context_data().get('teaching_profile')  # get teaching profile from cache

                        # Remove the subject from the teacher's profile
                        teacher_profile.subject.remove(button_id)

                # Handle any exceptions
                except Subject.DoesNotExist:
                    messages.error(self.request, 'Invalid subject id')

                except Exception as e:
                    messages.error(self.request, str(e))
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
                            'model': 'TeacherProfile',

                        }
                    )

                return redirect(self.request.get_full_path())


class AmClassTeacher(TemplateView):
    template_name = 'Teacher/am_class_teacher.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        class_id = SchoolClass.objects.filter(class_teacher=user)
        context['classes'] = class_id
        return context


class Subscriptions(TemplateView):
    template_name = 'Teacher/subscriptions.html'

class SubjectQuestionView(LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/questions_view.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        subject_id = self.kwargs['subject']
        questions = TopicalQuizes.objects.filter(subject__id=subject_id)
        topics = Topic.objects.filter(subject__id=subject_id)
        subtopics = Subtopic.objects.filter(subject__id=subject_id)
        context['topics'] = topics
        context['subtopics'] = subtopics
        context['questions'] = questions

        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            topic = self.request.POST.get('topic')
            subtopic = self.request.POST.get('subtopic')
            if subtopic:
                

                questions = TopicalQuizes.objects.filter(subtopic__id=subtopic)
            else:
                questions = TopicalQuizes.objects.filter(topic__id=topic)
            context = {
                'questions':questions,
                'subtopics':self.get_context_data().get('subtopics'),
                'topics':self.get_context_data().get('topics'),
            }


            return render(self.request, self.template_name, context)

class ManageQuestion(LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/manage_question.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        question_id = self.kwargs['question']
        question = TopicalQuizes.objects.get(id=question_id)
        context['quiz'] = question
        choices = TopicalQuizAnswers.objects.filter(quiz__id=question_id).distinct().order_by('-is_correct')
        context['choices'] = choices

        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            if 'delete' in self.request.POST:
                dlete = self.get_context_data().get('quiz')
                dlete.delete()
                messages.success(self.request, 'SUCCESS!')
            else:
                quiz = self.get_context_data().get('quiz')
                choices = self.get_context_data().get('choices')

                quiz1 = self.request.POST.get('quiz')
                right = self.request.POST.get('correct')
                choicelist = self.request.POST.getlist('choices')
       
                

                quiz.quiz = quiz1
                quiz.save()
                correct = choices.get(is_correct=True)
                correct.choice = right
                correct.save()
                wrong = choices.filter(is_correct=False)
                index = 0
                for ans in wrong:
                    ans.choice = choicelist[index]
                    ans.save()
                    index = index + 1
                messages.success(self.request, 'Update was a success')
                return redirect(self.request.get_full_path())



        return redirect('questions',dlete.subject.id)
    
class MySessions(LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/sessions.html'

    def get_context_data(self,*args, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        if user.role == 'Teacher':
            sessions = SessionBooking.objects.filter(teacher=user).order_by('-date')
            context['sessions'] = sessions
            context['template'] = 'Teacher/teachers_base.html'
        else:
            sessions = SessionBooking.objects.filter(students=user).order_by('-date')
            context['sessions'] = sessions
            context['template'] = 'Users/base.html'
        now = datetime.datetime.now()
        context['now'] = now
        print(now)

        return context



class BookSession(LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/book.html'

    def get_context_data(self,*args, **kwargs):
        context = super().get_context_data(**kwargs)
        id = self.kwargs['id']
        students = StudentList.objects.get(user=self.request.user, id=id)
        context['subject'] = students.subject
        context['students'] = students.students.all()
        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            students = self.request.POST.getlist('student')
            teacher = self.request.user
            about = self.request.POST.get('about')
            mode = self.request.POST.get('mode')
            link = self.request.POST.get('link')
            date = self.request.POST.get('date')
            subject = self.get_context_data().get('subject')
            print(students)
            # students = MyUser.objects.filter(email__in=students)
            try:
                if mode == 'Virtual':
                    booking = SessionBooking.objects.create(teacher=teacher,about=about, date=date,
                                                         subject=subject, mode=mode, link=link)
                else:
                    booking = SessionBooking.objects.create(teacher=teacher,about=about, date=date,
                                                         subject=subject, mode=mode)
                booking.students.add(*students)

                messages.success(self.request, 'Session booked succesfully.')
                return redirect('session', booking.id)
            except Exception as e:
                messages.error(self.request, str(e))
                return redirect(self.request.get_full_path())
            
class SessionId(LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/session.html'

    def get_context_data(self,*args, **kwargs):
        context = super().get_context_data(**kwargs)
        id = self.kwargs['id']
        user = self.request.user
        session = SessionBooking.objects.get(id=id)
        context['session'] = session
        context['students'] = session.students.all()
        if user.role == 'Teacher':
            context['template'] = 'Teacher/teachers_base.html'
        else:
            context['template'] = 'Users/base.html'
        return context


    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            session = self.get_context_data().get('session')
            command = self.request.POST.get('command')
            if command == 'delete':
                session.delete()
                messages.success(self.request, 'Session cancelled succesfully !')

                return redirect('my-classes')
            
            else:
                messages.error(self.request, 'Invalid delete command')

                return redirect(self.request.get_full_path())


class TeachersProfile(LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/teachers_profile.html'

    def get_context_data(self,*args, **kwargs):
        context = super().get_context_data(**kwargs)
        id = self.kwargs['id']
        teacher = MyUser.objects.get(id=id)
        context['teacher'] = teacher
        role = self.request.user.role
        subjects, object = TeacherProfile.objects.get_or_create(user=teacher)
        context['subjects'] = subjects.subject.all()
        if role == 'Teacher':
            context['template'] = 'Teacher/teachers_base.html'
        elif role == 'Guardian':
            context['template'] = 'Guardian/baseg.html'
        elif role == 'Student':
            context['template'] = 'Users/base.html'
        else:
            
            context['template'] = 'Supervisor/base.html'
        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            topics = self.request.POST.getlist('topics')
            teacher = self.get_context_data().get('teacher')
            if 'archive' in self.request.POST:
                teacher.is_active='0'
                teacher.save()
                messages.success(self.request, "Teacher's account deactivated")
            elif 'delete' in self.request.POST:
                teacher.delete()
                messages.success(self.request, "Teacher's account deleted")
                return redirect('supervisor-home')
            else:
                teacher.is_active='1'
                teacher.save()
                messages.success(self.request, "Teacher's account restored")
            return redirect(self.request.get_full_path())
    
class Link(LoginRequiredMixin, TemplateView):
    template_name = 'Teacher/link.html'

    def get_context_data(self,*args, **kwargs):
        context = super().get_context_data(**kwargs)
        stdid = self.kwargs['student']
        tchid = self.kwargs['teacher']
        context['teacher'] = MyUser.objects.get(id=tchid)
        context['student'] = MyUser.objects.get(id=stdid)
        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            teacher = self.get_context_data().get('teacher')
            student = self.get_context_data().get('student')
            subject = self.request.POST.get('subject')
            subject_ins = Subject.objects.get(id=subject)
            profile, created = StudentList.objects.get_or_create(user=teacher, subject=subject_ins)
            profile.students.add(student)
            messages.success(self.request, 'Success!')
            return redirect(self.request.get_full_path())


class ContentSubjectSelect(TemplateView):
    template_name='Teacher/content_subject_select.html'

class SubjectContent(TemplateView):
    template_name='Teacher/subject_content.html'

    def get_context_data(self, **kwargs):
        context =  super().get_context_data(**kwargs)
        id = self.kwargs['id']
        context['subject'] = id
        context['contents'] = MyContent.objects.filter(subtopic__subject__id=id)
        return context
    
class ManageContent(TemplateView):
    template_name='Teacher/manage_content.html'

    def get_context_data(self, **kwargs):
        context =  super().get_context_data(**kwargs)
        try:
            id = self.kwargs['id']
            context['command'] = random.randint(10000, 99458)
            context['content'] = MyContent.objects.get(id=id)
        except Exception as e:
            messages.error(self.request, str(e))
        return context
    
    def post(self, request, **kwargs):
        if self.request.method == "POST":
            command = self.get_context_data().get('command')
            content = self.get_context_data().get('content')
            txt = self.request.POST.get('command')
            if command == txt:
                content.delete()
                messages.success(self.request, 'Content was deleted')
                return redirect('subject-content', content.subtopic.subject.id)
            else:
                messages.error(self.request, 'Invalid number')
                return redirect(self.request.get_full_path())

from django.http import JsonResponse
from django.shortcuts import redirect
from django.contrib import messages

class AddContent(TemplateView):
    template_name = "Teacher/add_content.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        id = self.kwargs["id"]
        context["subject"] = Subject.objects.get(id=id)
        context["subtopics"] = Subtopic.objects.filter(subject__id=id)
        return context

    def post(self, request, **kwargs):
        if request.method == "POST":
            try:
                subtopics = self.get_context_data().get("subtopics")
                subtopic_id = request.POST.get("subtopic")
                file = request.FILES.get("file")
                title = request.POST.get("title")

                # Ensure subtopic exists
                subtopic = subtopics.get(id=subtopic_id)

                # Create content object
                content = MyContent.objects.create(
                    user=request.user, file=file, title=title, subtopic=subtopic
                )

                # Return JSON response if it's an AJAX request
                if request.headers.get("X-Requested-With") == "XMLHttpRequest":
                    return JsonResponse({"status": "success", "content_id": content.id})

                # Otherwise, redirect normally
                return redirect("manage-content", content.id)

            except Exception as e:
                messages.error(self.request, str(e))
                if request.headers.get("X-Requested-With") == "XMLHttpRequest":
                    return JsonResponse({"status": "error", "message": str(e)}, status=400)
                return redirect(self.request.get_full_path())

@login_required
def remove_quiz_from_session(request):
    if request.method == 'POST':
        question_id = request.POST.get('question_id')
        
        # Get the current session data
        selected = request.session.get('selected', [])
        
        # Remove the question if it exists
        if question_id in selected:
            selected.remove(question_id)
            request.session['selected'] = selected
            
            return JsonResponse({
                'status': 'success',
                'session_data': len(selected)
            })
    
    return JsonResponse({
        'status': 'error',
        'message': 'Invalid request'
    }, status=400)

@login_required
def reset_session(request):
    if request.method == 'POST':
        print('im here  ')
        # Clear test_data and selected questions from session
        if 'test_data' in request.session:
            del request.session['test_data']
        if 'selected' in request.session:
            del request.session['selected']
        
        return JsonResponse({
            'status': 'success',
            'message': 'Session data cleared successfully'
        })
    
    return JsonResponse({
        'status': 'error',
        'message': 'Invalid request method'
    }, status=400)
