
from django.db import models
from Exams.models import TopicalQuizes
from Guardian.views import MyKidsView
from SubjectList.models import Subject, Topic, Subtopic
from Users.models import MyUser




class Updates(models.Model):
    title = models.CharField(max_length=300)
    description = models.TextField(max_length=500)
    date = models.DateField(auto_now=True)
    file = models.FileField(upload_to='Updates/', null=True)

    def __str__(self):
        return str(self.title)
    
class FileModel(models.Model):
    file = models.FileField(upload_to='gallery/')  # Choose your upload_to path


class QuestionCount(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    quiz = models.ManyToManyField(TopicalQuizes, null=True)
    count = models.PositiveIntegerField(default=0)

    def update_quiz_count(self):
        self.count = self.quiz.count()
        self.save()

    def __str__(self):
        return str(self.user)
    

class QuizAssignment(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    topic= models.ManyToManyField(Topic)

    def __str__(self):
        return str(self.user)

class Inquire(models.Model):
    date = models.DateField(auto_now=True)
    message = models.TextField(max_length=1000)
    contact = models.CharField(max_length=100)
    names = models.CharField(max_length=100)

    def __str__(self):
        return str(self.names)
