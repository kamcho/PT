from django.db import models
from SubjectList.models import Subject

from Users.models import Classes, MyUser, Schools, Students

# Create your models here.
class Terms(models.Model):
    choices = (
        ('Term 1','Term 1'),
        ('Term 2', 'Term 2'),
        ('Term 3', 'Term 3')
    )
    term = models.CharField(max_length=10, choices=choices)
    year = models.CharField(max_length=10)
    starts_at = models.DateField(auto_created=True, null=True)
    ends_at = models.DateField(auto_created=True, null=True)


    def __str__(self):
        return str(self.term)
    
class CurrentTerm(models.Model):
  
    term = models.ForeignKey(Terms, on_delete=models.CASCADE)
    mode = models.BooleanField(default=False)
  


    def __str__(self):
        return str(self.term)
    

class Exam(models.Model):
    user = models.ForeignKey(Students, on_delete=models.CASCADE)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    term = models.ForeignKey(Terms, on_delete=models.CASCADE)
    score = models.PositiveIntegerField()
    # points = models.PositiveIntegerField(max_length=10, default=6)
    grade = models.CharField(max_length=100)
    period = models.CharField(max_length=100)

    class Meta:
        unique_together = ('user', 'subject', 'term', 'period')

    def __str__(self):
        return str(self.user)

    def get_grade(self):
        if self.score >=80:
            return 'EE'
        elif self.score < 80 and  self.score >= 50:
            return 'ME'
        elif self.score < 50 and  self.score >= 30:
            return 'AE'
        else :
            return 'BE'
        

class GradeModel(models.Model):
    upper_limit = models.PositiveIntegerField()
    lower_limit = models.PositiveIntegerField()
    grade = models.PositiveIntegerField()
    comments = models.CharField(max_length=30)

    def __str__(self):
        return str(self.comments)

class Grade(models.Model):
    grade = models.PositiveIntegerField()

    def __str__(self):
        
        return str(self.grade)
    

class ClassTermRanking(models.Model):
    term = models.ForeignKey(Terms, on_delete=models.CASCADE)
    class_id = models.ForeignKey(Classes, on_delete=models.CASCADE)
    grade = models.PositiveIntegerField()
    file = models.FileField(upload_to='files/')

    def __str__(self):
        return str(self.class_id) + ' ' + str(self.grade)+ ' ' + str(self.term)

    
class StreamTermRanking(models.Model):
    class_id = models.ForeignKey(Classes, on_delete=models.CASCADE)
    grade = models.PositiveIntegerField()
    file = models.FileField(upload_to='files/')

    def __str__(self):
        return str(self.class_id) + ' ' + str(self.grade)