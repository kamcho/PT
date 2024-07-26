from django.db.models.signals import post_save
from django.db.models.signals import m2m_changed

from Supervisor.models import QuestionCount
from Teacher.models import TeacherRanking


# from SubjectList.models import MySubjects, Course
from .models import MyUser, PersonalProfile, AcademicProfile
from django.dispatch import receiver


@receiver(post_save,sender=MyUser)
def create_profile(sender, instance, created, **kwargs):
    if created:
        PersonalProfile.objects.create(user=instance)
        if instance.role == 'Student':
            AcademicProfile.objects.create(user=instance)

        elif instance.role == 'Teacher':
            TeacherRanking.objects.create(user=instance)
            QuestionCount.objects.create(user=instance)
            
@receiver(m2m_changed, sender=QuestionCount.quiz.through)
def update_quiz_count(sender, instance, action, **kwargs):
    if action in ['post_add', 'post_remove', 'post_clear']:
        instance.update_quiz_count()

