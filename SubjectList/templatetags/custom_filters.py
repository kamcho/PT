import logging
import math
import random
from django.db import DatabaseError
from django.db.models import Count, F

from django import template
from django.db.models import Sum
from django.shortcuts import redirect
import datetime

from Exams.models import StudentTest, StudentsAnswers, ClassTestStudentTest, ClassTest,  GeneralTest, \
    TopicalQuizes, TopicalQuizAnswers
from SubjectList.models import *


from Subscription.models import MpesaPayments
from Teacher.models import MyClass
from Term.models import Exam
from Users.models import Classes, MyUser

register = template.Library()
logger = logging.getLogger('django')

@register.filter
def get_tests_count(user, user2):
    excluded1= StudentTest.objects.filter(user=user).values('uuid')
    test1 = TopicExamNotifications.objects.filter(user=user).exclude(uuid__in=excluded1).count()
    # current_class = StudentList.objects.filter(students=user).values_list('id')
    # test2 = ClassTest.objects.filter(class_id__in=current_class).count()
    if test1:
        return int(test1) 
    else:
        return None

@register.filter
def get_assignments(user, id):
    current_class = StudentList.objects.filter(students=user).values_list('id')
    test2 = ClassTest.objects.filter(class_id__in=current_class).count()

    if test2:
        return test2
    else:
        return None

@register.filter
def get_stars(user, id):
    rank = TeacherRanking.objects.get(user=user).rank
    lst = ['i']*int(rank)
    return lst

@register.filter
def user_topic_percentile(user, topic):
    weakness = StudentsAnswers.objects.filter(user=user, quiz__topic__id=topic, is_correct=False)
    strength = StudentsAnswers.objects.filter(user=user, quiz__topic__id=topic, is_correct=True)
    if strength or weakness:
        total = weakness.count() + strength.count()
        pas = (strength.count()/total)*100
        return str(round(pas)) + ' %'
    else:
        return 'no tests taken'
@register.filter
def get_passed(user, topic):  
    strength = StudentsAnswers.objects.filter(user=user, quiz__topic__id=topic, is_correct=True).count()
    return strength
@register.filter
def get_failed(user, topic):  
    strength = StudentsAnswers.objects.filter(user=user, quiz__topic__id=topic, is_correct=False).count()
    return strength
    
@register.filter
def divide(value, arg):
    try:
        value = int(value)
        arg = int(arg)
        return round((value / arg) * 100)
    except (ValueError, ZeroDivisionError):
        return 0
    
@register.filter
def progress(subject_id, count):
    try:
        subtopics = Subtopic.objects.filter(subject__id=subject_id).count()
        print(subtopics, count)
        progress = (count / subtopics) * 100
        progress = round(progress, 0)
        return progress
    except Exception as e:
        print(str(e))
        return 0
@register.filter

def subject_progress(user, subject_id):
    try:
        print(user, 'User:', subject_id)
        
        # Filter Progress by user and subject
        progress = Progress.objects.filter(user=user, subject__id=subject_id)
        
        # Get the total count of subtopics for the given subject
        total_subtopics = Subtopic.objects.filter(subject__id=subject_id).count()
        print("Total subtopics:", total_subtopics)

        # Count the number of subtopics for this user in the specific subject
        subtopic_count = progress.annotate(subtopic_count=Count('subtopic')).values('subtopic_count')

        # If there are no progress records or subtopics, return 0
        if not subtopic_count:
            return 0
        
        # Since annotate() returns a queryset, you need to access the value in the result
        completed_subtopics = subtopic_count[0]['subtopic_count']  # Access the first result
        
        print("Completed subtopics:", completed_subtopics)
        
        # Calculate the percentage of completed subtopics
        if total_subtopics > 0:
            return round((completed_subtopics * 100) / total_subtopics)
        else:
            return 0  # Avoid division by zero

    except Exception as e:
        print("Error:", str(e))
        return 0


@register.filter
def get_user_progress_topic(user, subject):
    subject = Subject.objects.get(id=subject)
    progress = Progress.objects.filter(user=user, subject=subject).last()
    if progress:
        try:
            current_subtopic = progress.subtopic.last()  # Get the latest subtopic
            if current_subtopic:
                return current_subtopic

        except Subtopic.DoesNotExist:
            try:
                introduction = Topic.objects.filter(subject=subject).last()
                introduction = Subtopic.objects.filter(topic=introduction).last()
                return introduction
            except Topic.DoesNotExist:
                return None
            except Subtopic.DoesNotExist:
                return None
    else:
        try:
            introduction = Topic.objects.filter(subject=subject).last()
            introduction = Subtopic.objects.filter(topic=introduction).last()
            return introduction
        except Topic.DoesNotExist:
            return None
        except Subtopic.DoesNotExist:
            return None


@register.filter
def topic_in_progress(user, topic):
    try:
        progress = Progress.objects.filter(user=user, topic=topic)
        if progress:
            return True
        else:
            return False

    except Exception as e:
        return False


@register.filter
def guardian_topic_view(email, topic):
    try:
        # user = MyUser.objects.get(email=email)
        progress = Progress.objects.filter(user__adm_no=email, topic=topic)
        if progress.exists():
            return True
        else:
            return False


    except Exception as e:
        return False


@register.filter
def subtopic_in_progress(user, subtopic):
    try:
        progress = Progress.objects.filter(user=user, subtopic=subtopic)
        if progress:
            return True
        else:
            return False

    except Exception as e:
        return False


@register.filter
def guardian_subtopic_view(email, subtopic):
    try:
        print(email, subtopic)
        # user = MyUser.objects.get(email=email)

        progress = Progress.objects.filter(user__adm_no=email, subtopic__id=subtopic)
        print(progress)
        if progress:
            return True
        else:
            return False

    except Exception as e:
        return False

@register.filter
def guardians_subtopic_view(email, topic):
    try:
        # user = MyUser.objects.get(email=email)
        progress = Subtopic.objects.filter(topic__id=topic).order_by('order')
        print(progress)
        
        return progress

    except Exception as e:
        return False

@register.filter
def test_is_done(user, test_uuid):
    try:
        class_test = ClassTestStudentTest.objects.filter(user=user, test=test_uuid)
        student_test = StudentTest.objects.filter(user=user, uuid=test_uuid)
        if student_test or class_test :

            return True
        else:
            return False

        return True

    except DatabaseError:
        return False


@register.filter
def get_total_test(email, subject):
    print(email,subject )
    test = StudentTest.objects.filter(user__adm_no=email, subject__id=subject).count()
    class_tests = ClassTestStudentTest.objects.filter(user__adm_no=email, test__subject__id=subject).count()
    general = GeneralTest.objects.filter(user__adm_no=email, subject__id=subject).count()

    return test + class_tests + general

@register.filter
def get_total_correct(email, subject):
    correct = StudentsAnswers.objects.filter(user__adm_no=email, quiz__subject__id=subject, is_correct=True).count()
    return correct

@register.filter
def get_total(email, subject):
    correct = StudentsAnswers.objects.filter(user__adm_no=email, quiz__subject__id=subject).count()
    return correct
@register.filter
def get_accuracy(email, subject):
    correct = StudentsAnswers.objects.filter(user__adm_no=email, quiz__subject__id=subject, is_correct=True).count()
    all = StudentsAnswers.objects.filter(user__adm_no=email, quiz__subject__id=subject).count()
    try:
        perc = (correct/all)*100
        return round(perc)
    except:
        return 0
@register.filter
def class_test_progress(test_uuid):
    class_test = ClassTest.objects.filter(uuid=test_uuid).last()
    student_count = class_test.class_id.students.count()
    test_count = ClassTestStudentTest.objects.filter(test=test_uuid).count()
    

    return f' {test_count} / {student_count} '


@register.filter
def class_test_average(test_uuid):
    tests = ClassTestStudentTest.objects.filter(test=test_uuid)
    test = ClassTest.objects.filter(uuid=test_uuid).first()
    total_marks = tests.aggregate(total_marks=Sum('marks'))['total_marks']
    if int(tests.count()) == 0:
        return 0
    else:
        average = (int(total_marks) / int(tests.count()))
        average = round(average)

        return f'{average} / {test.test_size} '


@register.filter
def class_test_active(date):
    if datetime.date.today() > date:
        return True
    else:
        return False


@register.filter
def split_value(value, delimiter):
    return value.split(delimiter)[0]


@register.filter
def topical_average(user, topic):
    tests = StudentTest.objects.filter(user=user, topic__name=topic)

    total_marks = tests.aggregate(total_marks=Sum('marks'))['total_marks']
    average = round(int(total_marks) / int(tests.count()))
    return average


@register.filter
def topical_average_count(user, topic):
    tests = StudentTest.objects.filter(user=user, topic__name=topic)
    return tests.count()


@register.filter
def subject_analytics_marks(user, subject):
    student_test = StudentTest.objects.filter(subject__id=subject, user=user)
    sum_marks_and_test_sizes = student_test.aggregate(total_marks=Sum('marks'))
    total_marks = sum_marks_and_test_sizes['total_marks']

    return int(total_marks)


@register.filter
def subject_analytics_size(user, subject):
    student_test = StudentTest.objects.filter(subject__id=subject, user=user)
    sum_marks_and_test_sizes = student_test.aggregate(total_test_size=Sum('test_size'))
    total_test_size = sum_marks_and_test_sizes['total_test_size']
    return int(total_test_size)


@register.filter
def get_subject(subject):
    subject = Subject.objects.get(id=subject)
    return subject
@register.filter
def get_subtopics(topic):
    subtopics = Subtopic.objects.filter(topic=topic)
    return subtopics
@register.filter
def get_expectations(subtopic, school):
    subtopics = StudentsAnswers.objects.filter( user__school__id=school, quiz__subtopic__id=subtopic)
       
    count = subtopics.count()
    correct = subtopics.filter(is_correct=1).count()
    wrong = subtopics.filter(is_correct='0')
    data = {
        'EE':80,
        'ME':50,
        'AE':30,
        'BE':0
    }
    try:
        percent = round((correct*100)/count)
        return percent
    except:
        return 'No Tests Taken'


@register.filter
def topic_analytics_strength(user, topic):
    topical_answers = StudentsAnswers.objects.filter(user=user, quiz__topic__name=topic, is_correct=True).count()
    class_test_answers = StudentsAnswers.objects.filter(user=user, quiz__topic__name=topic,
                                                        is_correct=True).count()
    passed = int(topical_answers) + int(class_test_answers)
    return passed


@register.filter
def topic_analytics_weakness(user, topic):
    topical_answers = StudentsAnswers.objects.filter(user=user, quiz__topic__name=topic, is_correct=False).count()
    class_test_answers = StudentsAnswers.objects.filter(user=user, quiz__topic__name=topic,
                                                        is_correct=False).count()
    failed = int(topical_answers) + int(class_test_answers)
    return failed


@register.filter
def topic_analytics_count(user, topic):
    passed = topic_analytics_strength(user, topic)
    failed = topic_analytics_weakness(user, topic)
    total = passed + failed

    return total


@register.filter
def get_topics(user, subject):
    if user is  int:
        topical_tests = StudentTest.objects.filter(user=user, subject=subject)
    else:
        topical_tests = StudentTest.objects.filter(user__email=user, subject=subject)

    topical_topics = topical_tests.values('topic__name')
    return topical_topics


@register.filter
def get_test_count(user, subject):
    if user is int:
        topical_tests = StudentTest.objects.filter(user=user, subject=subject).count()
        class_test = ClassTestStudentTest.objects.filter(user=user, test__subject=subject).count()
        general_test = GeneralTest.objects.filter(user=user, subject=subject).count()
    else:
        topical_tests = StudentTest.objects.filter(user__email=user, subject=subject).count()
        class_test = ClassTestStudentTest.objects.filter(user__email=user, test__subject=subject).count()
        general_test = GeneralTest.objects.filter(user__email=user, subject=subject).count()

    return topical_tests + class_test  + general_test


@register.filter
def get_topic_count(user, subject):
    if user is int:
        topical_tests = StudentTest.objects.filter(user__email=user, subject=subject).annotate(
    similar_topic=F('topic')
).annotate(
    count=Count('similar_topic')
).values('similar_topic').distinct().order_by('similar_topic').count()
    else:

        topical_tests = StudentTest.objects.filter(user__email=user, subject=subject).annotate(
    similar_topic=F('topic')
).annotate(
    count=Count('similar_topic')
).values('similar_topic').distinct().order_by('similar_topic').count()
    return topical_tests


@register.filter
def get_correct_choice(quiz):
    correct_choice = TopicalQuizAnswers.objects.get(quiz__id=quiz, is_correct=True)

    return correct_choice.choice



@register.simple_tag
def get_class_highest(class_id, subject, term, period):
    # term = Terms.objects.get(id=21)
    # cl = SchoolClass.objects.get(class_id=class_id)
    # sb = Subject.objects.get(id=subject)
    # print(cl,subject, term.term, term.term.year)
    scores = Exam.objects.filter(user__academicprofile__current_class__class_id=class_id, subject__id=subject, term__term=term, period=period)
    highest = scores.values('score').order_by('-score').first()
    print(highest)
    if highest:

        return highest['score']
    else:
        return None
    

@register.simple_tag
def get_class_lowest(class_id, subject, term, period):
    scores = Exam.objects.filter(user__academicprofile__current_class__class_id=class_id, subject__id=subject, term__term=term, period=period)
    lowest = scores.values('score').order_by('score').first()
    if lowest:

        return lowest['score']
    else:
        return None
    
@register.simple_tag
def get_class_average(class_id, subject, term, period):

    scores = Exam.objects.filter(user__academicprofile__current_class__class_id=class_id, subject__id=subject, term__term=term, period=period)
    total_marks = scores.aggregate(total_marks=Sum('score'))['total_marks']
    # print(total_marks)
    

    if total_marks:

        average = (int(total_marks)/ int(scores.count()))

        return round(average,3)
    else:
        return None

@register.simple_tag
def get_class_overall_average(class_id, grade, term, period):
    scores = Exam.objects.filter(user__academicprofile__current_class__class_id=class_id, subject__grade=grade, term__term=term, period=period)
    total_marks = scores.aggregate(total_marks=Sum('score'))['total_marks']

    if total_marks:

        average = (int(total_marks)/ int(scores.count()))

        return round(average,3)
    else:
        return 'Not Found'
    

@register.simple_tag
def get_stream_overall_average(class_id, grade, term):
    class_id = Classes.objects.get(class_id=class_id)
    class_id = Classes.objects.filter(grade=class_id.grade).values_list('class_id')

    scores = Exam.objects.filter(user__academicprofile__current_class__class_id__in=class_id, subject__grade=grade, term__term=term)
    # print(scores)
    ranking = scores.values('user','score').order_by().aggregate(total_marks=Sum('score'))['total_marks']
    total_marks = scores.aggregate(total_marks=Sum('score'))['total_marks']

    if total_marks:

        average = (int(total_marks)/ int(scores.count()))

        return round(average,3)
    else:
        return 'Not Found'

@register.simple_tag
def get_user_term_average(user, grade, term):
    scores = Exam.objects.filter(user=user, subject__grade=grade, term__term=term)
    print(scores.explain())
    total_marks = scores.aggregate(total_marks=Sum('score'))['total_marks']

    if total_marks:

        average = (int(total_marks)/ int(scores.count()))

        return round(average,3)
    else:
        return 'Not Found'


@register.simple_tag
def get_class_overall_ranking(class_id, grade, term):
    scores = Exam.objects.filter(user__academicprofile__current_class__class_id=class_id, subject__grade=grade, term__term=term)
    # print(scores)
    ranking = scores.values('user','score').order_by().aggregate(total_marks=Sum('score'))['total_marks']
    total_marks = scores.aggregate(total_marks=Sum('score'))['total_marks']

    if scores:

      

        return scores
    else:
        return 'Not Found'

@register.simple_tag
def check_payment(user):

    return MpesaPayments.objects.filter(user=user).exists()

@register.filter
def hide_email_percentage(value, percentage=40):
    """This filter hides a given percentage of the characters before @gmail.com with asterisks."""
    if isinstance(value, str) and '@gmail.com' in value:
        username, domain = value.split('@', 1)
        
        # Calculate the number of characters to hide based on the percentage
        num_chars_to_hide = math.floor(len(username) * (percentage / 100))
        print(username)
        # Hide the calculated number of characters
        visible_part = username[:len(username) - num_chars_to_hide]  # Keep the visible part of the username
        hidden_part = '*' * num_chars_to_hide  # Replace the hidden part with asterisks
        
        # Reassemble the email with the hidden part
        return visible_part + hidden_part + '@' + domain
    
    return value
@register.simple_tag
def is_class_teacher(user):
    class_id = Classes.objects.filter(class_teacher=user).values_list('class_name')
    classes = ""
    if class_id:
        for class_name in class_id:
            classes += str((class_name)[0]) + ', '


        return str(classes)
    else:
        return " "
    
@register.filter
def abs_value(value):
    try:
        return abs(value)
    except TypeError:
        return value 


@register.simple_tag
def get_subject_score(user, grade, subject, term, period):
    print(user)
    score = Exam.objects.filter(user__adm_no=user, subject__grade=grade, subject=subject, term__term=term, period__icontains=period).first()
    # print(user,subject,term,grade)
    
    if score:

      

        return score.score
    else:
        return 0
    
@register.filter
def get_student_latest_score(user, subject):
    exam = Exam.objects.filter(user=user,subject__id=subject).last()
    if exam:
        score = exam.score
    else:
        score = 'N/A'


    return score


@register.filter
def average_percentile(topic, count):
    answers = StudentsAnswers.objects.filter(quiz__topic__id=topic).count()
    percentage = (count / answers) * 100
    percentage = round(percentage, 2)
    
    return percentage

@register.simple_tag
def topic_percentile(topic):
    answers = StudentsAnswers.objects.filter(quiz__topic__id=topic)
    if answers.count() != 0:
        passed = answers.filter(is_correct=True).count()
        percentage = (passed / answers.count()) * 100
        percentage = round(percentage, 2)
        return percentage
    else:
        return 0
    

@register.filter
def get_dev(user, topic):
    quizes = TopicalQuizes.objects.filter(subtopic__id=topic)
    return quizes.count()

@register.filter
def get_files(user, quiz):
    print(user, quiz)
    # Retrieve the last Prompt object filtered by user and quiz
    files = Prompt.objects.filter(user=user, quiz=quiz).last()
    if files:
        return files.file.all()  # Assuming `file` is a ManyToManyField
    return []