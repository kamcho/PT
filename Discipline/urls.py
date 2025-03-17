from django.urls import path
from django.contrib.auth import views as auth_views
from .views import *
from . import views
from django.urls import re_path

urlpatterns = [
    re_path(r'^BookIncident(?:/(?P<adm_no>[^/]+))?/$', BookIncident.as_view(), name='book-incident'),

    path('CreateIncident/', CreateClassIncident.as_view(), name='create-incident'),
    path('Incidents/', Incidents.as_view(), name='incidents'),
    path('ManageIncident/<str:id>/', ManageIncident.as_view(), name='manage-incident'),
    path('BookedStudents/', BookedIncidents.as_view(), name='booked-students'),
    path('ManageBookedIncident/<str:id>/', ManageBookedIncident.as_view(), name='manage-booked-incident'),
    path('StudentsDisciplineProfile/<str:email>/', StudentsDisciplineProfile.as_view(), name='students-discipline')


]