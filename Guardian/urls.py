from django.urls import path
from django.contrib.auth import views as auth_views
from .views import *
from . import views
# app_name = 'Guardian'
urlpatterns = [
    path('My-Kids/', MyKidsView.as_view(), name='my-kids'),
    path('Notifications/', Messages.as_view(), name='notifications'),
    path('Notification/<str:id>/', Message.as_view(), name='notification'),
    path('Parent', GuardianHome.as_view(), name='guardian-home'),
    path('Learner/<str:email>/<str:grade>/', views.TaskSelection.as_view(), name='task-view-select'),
    path('Guardian/<str:email>/Grade-<str:grade>/Overall/', KidTests.as_view(), name='kid-test'),
    path('<str:email>/<str:subject>/TopicInfo', KidExamTopicView.as_view(), name='kid-exam-topic-id'),
    path('<str:email>/<str:subject>/<str:topic>/Info', KidExamSubjectDetail.as_view(), name='kid-exam-subject-id'),
    path('<str:instance>/<str:email>/<str:uuid>/Test-Revision/', KidTestRevision.as_view(), name='kid-test-revision'),
    path('Quiz/<str:email>/<str:name>/', KidTestDetail.as_view(), name='kid-tests-detail'),
    path('View/<str:email>/<str:grade>/progress/', LearnerProgress.as_view(), name='learner-learning-progress'),
    path('<str:name>/<str:grade>/<str:email>/syllabus-coverage/', LearnerSyllabus.as_view(), name='learners-syllabus'),
    path('ManageKids/', AddKid.as_view(), name='manage-kids')

]