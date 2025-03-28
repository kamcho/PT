"""PSAAI URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path,include
from django.contrib.auth import views as auth_views


# handler404 = 'Users.views.error_404'
# handler500 = 'Users.views.error_500'
# handler403 = 'Users.views.error_403'
# handler400 = 'Users.views.error_400'
urlpatterns = [

    path('admin/', admin.site.urls),
    
    path('', include('Users.urls')),
    path('IAMLearning/', include('SubjectList.urls')),
    path('Exams/', include('Exams.urls')),
    path('Subscriptions/', include('Subscription.urls')),
    path('Support/', include('Support.urls')),
    path('Supervisor/', include('Supervisor.urls')),
    path('Logs/', include('Logs.urls')),
    path('Guardian/', include('Guardian.urls')),
    path('Finance/', include('Finance.urls')),
    path('Discipline/', include('Discipline.urls')),
    path('Term/', include('Term.urls')),
    path('Analytics/', include('Analytics.urls')),
    path('Teacher/', include('Teacher.urls')),
    path('password-reset/', auth_views.PasswordResetView.as_view(template_name='Users/password_reset.html'),
         name='password-reset'),
    path('password-reset-confirm/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.
         as_view(template_name='Users/password_reset_confirm.html'), name='password_reset_confirm'),
    path('password-reset/done/', auth_views.PasswordResetDoneView.
         as_view(template_name='Users/password_reset_done.html'), name='password_reset_done'),
    path('password-reset-complete/', auth_views.PasswordResetCompleteView.
         as_view(template_name='Users/password_reset_complete.html'), name='password_reset_complete'),

]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)



urlpatterns += static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)