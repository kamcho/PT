
from django.db import models
from Exams.models import TopicalQuizes
from SubjectList.models import Subject, Topic, Subtopic
from Users.models import Classes, MyUser, Schools, Students




class Updates(models.Model):
    ministry = models.CharField(max_length=100, null=True)
    created_by = models.ForeignKey(MyUser,null=True, on_delete=models.CASCADE)
    title = models.CharField(max_length=300)
    description = models.TextField(max_length=500)
    date = models.DateField(auto_now=True)
    is_read = models.BooleanField(default=False)
    read_by = models.ManyToManyField(MyUser, related_name='read_by')
    # class_id = models.ForeignKey(Classes, null=True, blank=True, on_delete=models.CASCADE)
    user = models.ManyToManyField(Students)
    file = models.FileField(upload_to='Updates/', null=True, blank=True)
    school = models.ForeignKey(Schools,null=True, blank=True, on_delete=models.CASCADE)


    def __str__(self):
        return str(self.title)
    
    
    # class Meta:
    #     db_table = 'supervisor_updates'  # Custom table name
    #     managed = False
    
class FileModel(models.Model):
    file = models.FileField(upload_to='gallery/')  # Choose your upload_to path

    # class Meta:
    #     db_table = 'supervisor_filemodel'  # Custom table name
    #     managed = False


class ExamMode(models.Model) :
    school = models.OneToOneField(Schools, on_delete=models.CASCADE)
    status = models.BooleanField(default=False)
    period = models.CharField(max_length=100, default='MID')

    def __str__(self):
        return str(self.school)




class Inquire(models.Model):
    date = models.DateField(auto_now=True)
    message = models.TextField(max_length=1000)
    contact = models.CharField(max_length=100)
    names = models.CharField(max_length=100)

    def __str__(self):
        return str(self.names)
    
    # class Meta:
    #     db_table = 'supervisor_inquire'  # Custom table name
    #     managed = False
