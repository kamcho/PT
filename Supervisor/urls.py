from django.urls import path

from Supervisor.models import ExamMode
from . views import *
from . import *
from . import views

urlpatterns = [        path('search-guardian/', SearchGuardianView.as_view(), name='get-guardian'),


    path('AAdmin/', SupervisorHomeView.as_view(), name='supervisor-home'),
    path('Link/<str:adm>', LinkStudent.as_view(), name='link'),
    path('Admin-Dashboard/', SupervisorDashboard.as_view(), name='admin-dashboard'),
    path('AddStudent/', CreateUser.as_view(), name='create-user'),
    path('AddStaff/', CreateStaff.as_view(), name='create-staff'),
    path('search/', views.search_students, name='search'),
    path('AddStudentSubjects/<str:adm_no>/', StudentSubjectSelect.as_view(), name='student-subject-select'),
    path('AddGuardianInfo/<str:id>/', AddParent.as_view(), name='add-parent'),
    path('ArchivedUsers/', ArchivedUsers.as_view(), name='archived-users'),
    path('StudentsView/', StudentsView.as_view(), name='students-view'),
    path('TeachersView/', TeachersView.as_view(), name='teachers-view'),
    path('StudentsProfile/<str:email>/', StudentsProfile.as_view(), name='students-profile'),
    path('SupplierProfile/<str:id>/', SupplierProfile.as_view(), name='supplier-profile'),
    path('AddSubjectTopics/', AddSubjectTopics.as_view(), name='addsubjecttopics'),
    path('ManageUser/<str:email>/', ManageStudent.as_view(), name='manage-user'),
    path('TeacherProfile/<str:email>/', TeachersProfile.as_view(), name='teachers-profile'),
    path('TeacherInfo/<str:email>/', TeachersInfo.as_view(), name='teachers-info'),
    path('StudentsExamProfile/<str:id>/', StudentExamProfile.as_view(), name='students-exam-profile'),
    path('StudentsOptions/<str:email>/', StudentTaskSelect.as_view(), name='students-task-slect'),
    path('StudentsTestView/<str:email>/', StudentTestsView.as_view(), name='students-test-view'),
    path('StudentsTestDetailView/<str:test_type>/<str:email>/<str:test_id>/Test', StudentTestDetailView.as_view(), name='students-test-detail-view'),
    path('CreateClass/', CreateClass.as_view(), name='create-class'),
    path('Classes/', ClassesView.as_view(), name='classes'),
    path('Attendance/', SchoolAttendance.as_view(), name='attendance'),
    path('ClassList/<str:class_id>/', ClassList.as_view(), name='class-list'),
    path('GuardianView/<str:email>', GuardianView.as_view(), name='guardian-view'),
    path('Guardians/', GuardianListView.as_view(), name='guardians-view'),
    path('Classes/<str:class_id>/Info', ClassDetail.as_view(), name='class-profile'),
    path('Classes/<str:class_id>/Ranking/', ClassStudentsRanking.as_view(), name='class-students-ranking'),
    path('tests/', TestTaskView.as_view(), name='test-type'),
    path('ManageClassTeacher/', ManageClassTeacher.as_view(), name='class-teacher'),
   
    path('Promote-Classes/', Promote.as_view(), name='promote'),
    path('Migrate-Fees/', MigrateFees.as_view(), name='migrate-fees'),
    path('Rollback-Migrations/<str:id>/', Rollback.as_view(), name='rollback'),
    path('SchoolAssignments', AssignmentsView.as_view(), name='school-assignments'),


    path('Classes/<str:class_id>/<str:subject>/<str:term>/<str:period>/Results/', ClassSubjectDetail.as_view(), name='class-subject-detail'),
    path('<str:class_id>/ClassTestAnalytics/', ClassTestAnalytics.as_view(), name='class-exam-analytics'),
    path('CreateNotice/', CreateNotice.as_view(),name='create-notice'),
    path('Notices/', Notices.as_view(), name='notices'),
    path('Notice-Update/<str:notice_id>/', NoticeID.as_view(), name='notice-id'),
    path('Create-Activity/', AddActivity.as_view(), name='create-activity'),
    path('AddStudents/', AddStudents.as_view(), name='add-students'),
    path('Add-Files/', AddFiles.as_view(), name='add-files'),
    path('View-activities/', ViewActivities.as_view(), name='activities'),
    path('View-activity/<str:activity_id>/', ViewActivity.as_view(), name='view-activity'),
    path('Enable-Exam-Mode', ExamModes.as_view(), name='exam-mode'),
    path('Print-Card/<str:email>/<str:grade>/<str:term>/<str:rank>/', PrintReport.as_view(), name='print-report'),

    path('topicq-review/<str:subject>', TopicReview.as_view(), name='topic-review'),

]
