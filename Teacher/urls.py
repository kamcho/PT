from django.urls import path
from .views import *
from . import views



urlpatterns = [
    path('Home', TeacherView.as_view(), name='teachers-home'),
    path('Dash', DashTasks.as_view(), name='dash-tasks'),
    path('Class/<str:id>/', TaskViewSelect.as_view(), name='class-task-view-select'),
    path('<str:class>/Tests/', TestsView.as_view(), name='teacher-tests-view'),
    path('class/<str:uuid>/Analytics/', ClassTestAnalytics.as_view(), name='class-test-analytics'),
    path('<str:class>/Student-List/', StudentsView.as_view(), name='students-list'),
    path('<str:class>/Create-Test/', InitialiseCreateTest.as_view(), name='initialise-test'),
    path('load_class/', views.load_class, name='load-class'),
    path('Select-Topic/', ClassTestSelectTopic.as_view(), name='test-topic-select'),
    path('Questions-Selection/', UserQuestionsSelect.as_view(), name='user-question-selection'),
    path('System/Select-Questions/', views.SystemQuestionsSelect, name='system-question-selection'),
    path('get-questions/', views.get_topical_quizzes, name='get_topical_quizzes'),
    path('add-quiz-to-session/', views.add_question_to_session, name='add-quiz-to-session'),
    path('save-test/', SaveTest.as_view(), name='save-test'),
    path('My-Classes/', ClassesView.as_view(), name='my-classes'),
    path('Create-Question/', CreateQuestion.as_view(), name='create-questions'),
    path('load_topics/', views.load_topic, name='load-topics'),
    path('select_topics/', views.select_topic, name='select-topics'),
    path('load_subtopics/', views.load_subtopics, name='load-subtopics'),
    path('Add-Answers/', AddAnswerSelection.as_view(), name='add-answer'),
    path('Save-Question/', SaveQuiz.as_view(), name='save-quiz'),
    path('Dashboard/', DashBoard.as_view(), name='dashboard'),
    path('get_subjects/', views.get_subjects, name='get_subjects'),
    path('DashBoard/AcademicProfile/', SubjectSelect.as_view(), name='subjects-selection'),
    # path('Subscriptions/', Subscriptions.as_view(), name='subscriptions'),
    path('AMClassTeacher/', AmClassTeacher.as_view(), name='am-class-teacher'),
    path('<str:subject>/Questions/', SubjectQuestionView.as_view(), name='questions'),
    path('<str:question>/Question/', ManageQuestion.as_view(), name='manage-questions'),

    path('BookSession/<str:id>', BookSession.as_view(), name='book-session'),
    path('Sessions/<str:id>', SessionId.as_view(), name='session'),

    path('MySessions/', MySessions.as_view(), name='my-sessions'),

    path('ViewTeachersProfile/<str:id>', TeachersProfile.as_view(), name='teacher-id'),
    path('Link/<str:student>/<str:teacher>/', Link.as_view(), name='link'),
    path('MyContent/', ContentSubjectSelect.as_view(), name='content-subject-select'),
    path('<str:id>/Contents/', SubjectContent.as_view(), name='subject-content'),
    path('ManageContent/<str:id>/', ManageContent.as_view(), name='manage-content'),
    path('<str:id>/AddContent/', AddContent.as_view(), name='add-content'), 

]
