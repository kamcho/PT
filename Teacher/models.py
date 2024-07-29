from django.utils import timezone
import uuid as uuid
from django.db import models
import uuid
# from Exams.models import  ClassTest
# from Exams.models import TopicalQuizes
from SubjectList.models import Subject, Topic, Notifications
from Users.models import MyUser


class TeacherProfile(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    subject = models.ManyToManyField(Subject)

    def subjects_for_grade(self, grade):
        return self.subject.filter(grade=grade)

    def __str__(self):
        return str(self.user)
    
    class Meta:
        db_table = 'teacher_teacherprofile'  # Custom table name
        managed = False

class TeacherRanking(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    rank = models.PositiveIntegerField(default=1)
    

    def __str__(self):
        return str(self.user)
    
    class Meta:
        db_table = 'teacher_teacherranking'  # Custom table name
        managed = False
    

    

    
class StudentList(models.Model):
    user = models.ForeignKey(MyUser, related_name='teacher_user', on_delete=models.CASCADE)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    students = models.ManyToManyField(MyUser, related_name='students')

    class Meta:
        db_table = 'teacher_studentlist'  # Custom table name
        managed = False

   

    def __str__(self):
        return str(self.user)

class SessionBooking(models.Model):
    link = models.CharField(max_length=500, null=True)
    mode = models.CharField(max_length=100, default='Virtual')
    created = models.DateField(auto_now=True)
    teacher = models.ForeignKey(MyUser, related_name='teacher',  on_delete=models.CASCADE)
    date = models.DateTimeField()
    students = models.ManyToManyField(MyUser)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    about = models.TextField(max_length=500)

    def __str__(self):
        return str(self.teacher)
    class Meta:
        db_table = 'teacher_sessionbooking'  # Custom table name
        managed = False
    
    def active(self):
        now = timezone.now()
        if self.date > now:
            return True
        else:
            return False

# class ClassTestNotifications(Notifications):
#     test = models.ForeignKey(ClassTest, on_delete=models.CASCADE)
#     class_id = models.ForeignKey(StudentList, on_delete=models.CASCADE)
#     subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
#     topic = models.ForeignKey(Topic, blank=True, null=True, on_delete=models.CASCADE)

#     def __str__(self):
#         return str(self.test)
