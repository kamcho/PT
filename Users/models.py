from django.db import models
import uuid
from django.utils import timezone
from django.db import models
from django.urls import reverse
from django.contrib.auth.models import (
    BaseUserManager, AbstractBaseUser
)




class MyUserManager(BaseUserManager):
    def create_user(self, email, role, password=None):
        """
        Creates and saves a User with the given email, date of
        birth and password.
        """

        user = self.model(

            email=email,
            role=role,

        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None):
        """
        Creates and saves a superuser with the given email, date of
        birth and password.
        """
        user = self.create_user(

            email=email,
            role='Admin',
            password=password,

        )
        user.is_admin = True
        user.save(using=self._db)
        return user


class MyUser(AbstractBaseUser):
    class Role(models.TextChoices):
        Student = "Student"
        Teacher = "Teacher"
        ADMIN = "Admin"
        Guardian = "Guardian"
        Supervisor = "Supervisor"
        Referer = "Referer"
       


    base_role = Role.Student
    email = models.EmailField(unique=True)
    uuid = models.CharField(max_length=100, default=uuid.uuid4, unique=True, editable=True)   
    date = models.DateField(default=timezone.now)
    role = models.CharField(max_length=15, choices=Role.choices, default=base_role)
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)
    objects = MyUserManager()
    USERNAME_FIELD = 'email'


    def __str__(self):
        return str(self.email)



    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin
    
    # class Meta:
    #     db_table = 'users_myuser'  # Custom table name
    #     managed = False



class RefererManager(BaseUserManager):
    def get_queryset(self, *args, **kwargs):
        result = super().get_queryset(*args, **kwargs)
        return result.filter(role=MyUser.Role.Referer)


class Referer(MyUser):
    base_role = MyUser.Role.Referer
    partner = RefererManager()

    class Meta:
        proxy = True



class TeacherManager(BaseUserManager):
    def get_queryset(self,*args,**kwargs):
        result = super().get_queryset(*args,**kwargs)
        return result.filter(role=MyUser.Role.Teacher)


class Teacher(MyUser):
    base_role = MyUser.Role.Teacher
    teacher = TeacherManager()

    class Meta:
        proxy = True


class StudentManager(BaseUserManager):
    def get_queryset(self, *args, **kwargs):
        result = super().get_queryset(*args, **kwargs)
        return result.filter(role=MyUser.Role.Student)


class Student(MyUser):
    base_role = MyUser.Role.Student
    student = StudentManager()

    class Meta:
        proxy = True


class GuardianManager(BaseUserManager):
    def get_queryset(self, *args, **kwargs):
        result = super().get_queryset(*args, **kwargs)
        return result.filter(role=MyUser.Role.Guardian)


class Guardian(MyUser):
    base_role = MyUser.Role.Guardian
    guardian = GuardianManager()

    class Meta:
        proxy = True


class SupervisorManager(BaseUserManager):
    def get_queryset(self, *args, **kwargs):
        result = super().get_queryset(*args, **kwargs)
        return result.filter(role=MyUser.Role.Supervisor)


class Supervisor(MyUser):
    base_role = MyUser.Role.Supervisor
    partner = SupervisorManager()

    class Meta:
        proxy = True

class Grade(models.Model):
    grade= models.PositiveIntegerField(unique=True)
    level = models.CharField(max_length=100)

    def __str__(self):
        return str(self.grade)
    
    # class Meta:
    #     db_table = 'users_grade'  # Custom table name
    #     managed = False

class AcademicProfile(models.Model):

    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    current_class = models.ForeignKey(Grade, null=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.user.email
    def is_content(self):
        return self.current_class.grade in [4, 5, 6]

    
    # class Meta:
    #     db_table = 'users_academicprofile'  # Custom table name
    #     managed = False
    
class PersonalProfile(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    f_name = models.CharField(max_length=30)
    location = models.CharField(max_length=100, blank=True)
    l_name = models.CharField(max_length=30)
    surname = models.CharField(max_length=30, blank=True)
    gender = models.CharField(max_length=10, blank=True)
    phone = models.CharField(max_length=15, null=True)

    def __str__(self):
        return self.user.email
    def get_names(self):
        first = self.f_name
        last = self.l_name
        surname = self.surname
        if first or last or surname:
            if last:
                last = last[0]
            return first.upper() + ' ' + last.upper() + '.' + ' ' + surname.upper()
        else:
            return self.user
        
    # class Meta:
    #     db_table = 'users_personalprofile'  # Custom table name
    #     managed = False
    