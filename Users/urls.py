from django.urls import path
from django.contrib.auth import views as auth_views
from .views import  Home, RegisterView, MyProfile, StudentsHome, LoginRedirect, FinishSetup, Login, StaticViewSitemap, Success, VerifyAccount
from django.contrib.sitemaps.views import sitemap

from Users import views

sitemaps = {
    'static': StaticViewSitemap,
}
urlpatterns = [

    path('Sign-Up/', RegisterView.as_view(), name='register'),
    path('success', Success.as_view(), name='success'),
    path('Verify/<str:id>', VerifyAccount.as_view(), name='verify'),
    path('Profile/<str:email>', MyProfile.as_view(), name='update-profile'),
    path('sitemap.xml', sitemap, {'sitemaps': sitemaps}, name='django.contrib.sitemaps.views.sitemap'),
    path('Student/', StudentsHome.as_view(), name='student-home'),
    path('router/', views.rout, name='rout'),
    path('', Home.as_view(), name='home'),
    path('login-Redirect/', LoginRedirect.as_view(), name='redirect'),
    path('Profile-Set-Up/', FinishSetup.as_view(), name='edit-profile'),
    path('Login/', Login.as_view(), name='login'),
    path('Logout/', auth_views.LogoutView.as_view(template_name='Users/logout.html'), name='logout'),

]
