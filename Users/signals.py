from datetime import datetime
from django.db.models.signals import post_save
from django.db.models.signals import m2m_changed
from django.core.mail import send_mail

from Discipline.models import StudentDisciplineScore
from Finance.models import SupplierBalances
from Supervisor.models import ExamMode

# from SubjectList.models import RateLimiter
# from Subscription.models import MySubscription, Subscriptions
# from Supervisor.models import QuestionCount
# from Teacher.models import TeacherProfile, TeacherRanking


# from SubjectList.models import MySubjects, Course
from .models import MyUser, PersonalProfile, AcademicProfile, Schools
from django.dispatch import receiver
from datetime import timedelta, date




@receiver(post_save,sender=MyUser)
def create_profile(sender, instance, created, **kwargs):
    if created:

        PersonalProfile.objects.create(user=instance)
        if instance.role == 'Student':
            StudentDisciplineScore.objects.create(user=instance, points=100)
            # AcademicProfile.objects.create(user=instance)
            # sub = Subscriptions.objects.all().last()
            # RateLimiter.objects.create(user=instance, tokens=750, speech=0, image=0)
            expiry = date.today()
            # MySubscription.objects.create(user=instance, type=sub, expiry=expiry )

        elif instance.role == 'Supplier':
            SupplierBalances.objects.create(user=instance, balance=0)
            # TeacherRanking.objects.create(user=instance)
            # QuestionCount.objects.create(user=instance)
            # TeacherProfile.objects.get_or_create(user=instance)
            pass
        tor = datetime.now().strftime('%D:/%m %H:%M')
        send_mail(f'New User {tor} ', f'{instance.email}', 'njokevin9@gmail.com', ['kevingitundu@gmail.com',], fail_silently=True)
            
# @receiver(m2m_changed, sender=QuestionCount.quiz.through)
# def update_quiz_count(sender, instance, action, **kwargs):
#     if action in ['post_add', 'post_remove', 'post_clear']:
#         instance.update_quiz_count()


# @receiver(post_save,sender=MyUser)
# def payed(sender, instance, created, **kwargs):
#     if created: