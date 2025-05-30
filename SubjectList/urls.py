from django.urls import path
from SubjectList.views import AskAi, CreateCourse, Learning, ManageCourse, ManageSubTopic, ManageSubject, ManageTopic, SubtopicInfo, Tests, MediaSelect, Read, Assignment, Finish, AssignmentDetail, Syllabus, Messages, MyProgress, \
    ContactUs
from .import views
urlpatterns = [

    path('<str:adm_no>/Grade-<str:grade>/Subjects/', Learning.as_view(), name='learn'),
    path('E-Learning/<str:topic> /<str:subtopic>/<str:media>/Study', Read.as_view(), name='read'),
    path('Assignments/<str:adm_no>/', Assignment.as_view(), name='assignments'),
    path('<str:adm_no>/<str:uuid>/Assignment-Lobby', AssignmentDetail.as_view(), name='assignment-lobby'),
    path('Save/<str:topic> /<str:subtopic>/Save-Progress/', Finish.as_view(), name='save-progress'),
    path('<str:adm_no>/<str:subject_id>/Syllabus-Coverage/', Syllabus.as_view(), name='syllabus'),
    path('<str:adm_no>/<str:subtopic>/Objectives/', SubtopicInfo.as_view(), name='subtopic-info'),
    
    path('<str:topic>/<str:subtopic>/Media-Select/', MediaSelect.as_view(), name='media' ),
    path('Notifications/', Messages.as_view(), name='notifications'),
    path('Grade-<str:grade>/Learning-Progress', MyProgress.as_view(), name='progress'),
    path('Support/', ContactUs.as_view(), name='contact'),
    path('Undone-Tests/',Tests.as_view(), name='pending-tests' ),
    path('Course-Management/', CreateCourse.as_view(), name='create-course'),
    path('Course/<str:id>/Manage/', ManageCourse.as_view(), name='manage-course'),
    path('Subject/<str:id>/Manage/', ManageSubject.as_view(), name='manage-subject'),
    path('Topic/<str:id>/Manage/', ManageTopic.as_view(), name='manage-topic'),
    path('SubTopic/<str:id>/Manage/', ManageSubTopic.as_view(), name='manage-subtopic'),
    path('AskAI/<str:adm_no>/', AskAi.as_view(), name='ask-ai'),
    path('answer/', views.chatgpt_answer, name='answer')


]
