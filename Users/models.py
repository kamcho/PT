from django.db import models
import uuid
from django.utils import timezone
from django.db import models
from django.urls import reverse
from django.contrib.auth.models import (
    BaseUserManager, AbstractBaseUser
)

class Schools(models.Model):
    uuid = models.UUIDField(default=uuid.uuid4, unique=True)
    names = models.CharField(max_length=150)
    display = models.CharField(max_length=100, null=True)
    location = models.CharField(max_length=100)
    contact = models.CharField(max_length=100)
    is_active = models.BooleanField(default=True)
    has_boarding = models.BooleanField(default=True)
    is_mixed = models.BooleanField(default=False)
    def __str__(self):
        return str(self.names)


class MyUserManager(BaseUserManager):
    def create_user(self, id_number, role, password=None):
        """
        Creates and saves a User with the given ID number and password.
        """
        if not id_number:
            raise ValueError("Users must have an ID number")

        user = self.model(
            id_number=id_number,
            role=role,
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, id_number, password=None):
        """
        Creates and saves a superuser with the given ID number and password.
        """
        user = self.create_user(
            id_number=id_number,  # ✅ Use id_number instead of id
            role='Admin',
            password=password,
        )
        user.is_admin = True
        user.is_staff = True
        user.is_superuser = True  # ✅ Ensure the superuser flag is set
        user.save(using=self._db)
        return user


class MyUser(AbstractBaseUser):
    class Role(models.TextChoices):
        Student = "Student"
        Teacher = "Teacher"
        ADMIN = "Admin"
        Finance = "Finance"
        Guardian = "Guardian"
        Receptionist = "Receptionist"
        Supervisor = "Supervisor"
        Referer = "Referer"
        Supplier = "Supplier"

    base_role = Role.Student
    email = models.EmailField(unique=True, null=True, blank=True)
    school = models.ForeignKey(Schools, null=True,blank=True, on_delete=models.CASCADE)
    id_number = models.CharField(max_length=20, unique=True)  # ✅ Ensure unique=True
    uuid = models.UUIDField(default=uuid.uuid4, unique=True, editable=False)   
    date = models.DateField(default=timezone.now)
    role = models.CharField(max_length=15, choices=Role.choices, default=base_role)
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)  # ✅ Required for Django Admin
    is_superuser = models.BooleanField(default=False)  # ✅ Needed for superusers

    objects = MyUserManager()

    USERNAME_FIELD = 'id_number'  # ✅ Django now identifies users by ID number
    REQUIRED_FIELDS = []  # No other required fields

    def __str__(self):
        return str(self.id_number)

    def has_perm(self, perm, obj=None):
        return True

    def has_module_perms(self, app_label):
        return True


class SupplierManager(BaseUserManager):
    def get_queryset(self, *args, **kwargs):
        result = super().get_queryset(*args, **kwargs)
        return result.filter(role=MyUser.Role.Supplier)


class Supplier(MyUser):
    base_role = MyUser.Role.Supplier
    partner = SupplierManager()

    class Meta:
        proxy = True

class ReceptionistManager(BaseUserManager):
    def get_queryset(self, *args, **kwargs):
        result = super().get_queryset(*args, **kwargs)
        return result.filter(role=MyUser.Role.Receptionist)


class Receptionist(MyUser):
    base_role = MyUser.Role.Receptionist
    partner = ReceptionistManager()

    class Meta:
        proxy = True
class FinanceManager(BaseUserManager):
    def get_queryset(self, *args, **kwargs):
        result = super().get_queryset(*args, **kwargs)
        return result.filter(role=MyUser.Role.Finance)


class Finance(MyUser):
    base_role = MyUser.Role.Finance
    partner = FinanceManager()

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


class Accounts(models.Model):
    school = models.ForeignKey(Schools, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    account = models.CharField(max_length=100, null=True, blank=True)
    is_active = models.BooleanField()

    def __str__(self):
        return str(self.name)

class Classes(models.Model):
    school = models.ForeignKey(Schools, on_delete=models.CASCADE)
    class_id = models.UUIDField(default=uuid.uuid4, unique=True)
    grade = models.CharField(max_length=10)
    name = models.CharField(max_length=100)
    year = models.PositiveIntegerField(default=2025)
    is_active = models.BooleanField(default=True)
    class_teacher = models.ForeignKey(MyUser, null=True, blank=True, on_delete=models.SET_NULL)
    def __str__(self):
        return str(self.name)
    
class Students(models.Model):
    school = models.ForeignKey(Schools, on_delete=models.CASCADE)
    adm_no = models.CharField(max_length=30, unique=True)
    date = models.DateField(auto_now=True)
    is_active = models.BooleanField(default=True)
    def __str__(self):
        return str(self.adm_no)
class StudentsFeeAccount(models.Model):
    user = models.OneToOneField(Students, on_delete=models.CASCADE)
    balance = models.PositiveIntegerField()
    def __str__(self):
        return str(self.user)

class AcademicProfile(models.Model):

    user = models.OneToOneField(Students, on_delete=models.CASCADE)
    current_class = models.ForeignKey(Classes, on_delete=models.CASCADE)
    
    def __str__(self):
        return str(self.user)
    def is_content(self):
        return self.current_class.grade in [4, 5, 6]

    
    # class Meta:
    #     db_table = 'users_academicprofile'  # Custom table name
    #     managed = False
    
class PersonalProfile(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    f_name = models.CharField(max_length=30)
    is_boarder = models.BooleanField(default=False)
    location = models.CharField(max_length=100, blank=True)
    l_name = models.CharField(max_length=30)
    surname = models.CharField(max_length=30, blank=True)
    gender = models.CharField(max_length=10, blank=True)
    phone = models.CharField(max_length=20, null=True)
    def __str__(self):
        return str(self.user)
    def get_names(self):
        first = self.f_name
        last = self.l_name
        surname = self.surname
        if first or last or surname:
            if last:
                last = last[0]
            return first.title() + ' ' + last.title() + '.' + ' ' + surname.title()
        else:
            return self.user


class StudentProfile(models.Model):
    user = models.OneToOneField(Students, on_delete=models.CASCADE)
    f_name = models.CharField(max_length=30)
    is_boarder = models.BooleanField(default=False)
    location = models.CharField(max_length=100, blank=True)
    l_name = models.CharField(max_length=30)
    surname = models.CharField(max_length=30, blank=True)
    gender = models.CharField(max_length=10, blank=True)

    def __str__(self):
        return str(self.user)
    def get_names(self):
        first = self.f_name
        last = self.l_name
        surname = self.surname
        if first or last or surname:
            if last:
                last = last[0]
            return first.title() + ' ' + last.title() + '.' + ' ' + surname.title()
        else:
            return self.user.adm_no
    # class Meta:
    #     db_table = 'users_personalprofile'  # Custom table name
    #     managed = False
    
class StudentsFeeAccount(models.Model):
    user = models.OneToOneField(Students, on_delete=models.CASCADE)
    balance = models.DecimalField(decimal_places=2, max_digits=10)
    last_update = models.DateField(auto_now=True)

    def __str__(self):
        return str(self.user)