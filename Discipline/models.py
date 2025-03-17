from django.db import models

from Users.models import MyUser, Students

# Create your models here.

class ClassIncident(models.Model):
    incident_degree = models.CharField(max_length=100)
    name = models.CharField(max_length=100)
    description = models.TextField(max_length=300)
    points = models.PositiveIntegerField()

    def __str__(self):
        return str(self.name)
    

class StudentDisciplineScore(models.Model):
    user = models.OneToOneField(Students, on_delete=models.CASCADE)
    points = models.PositiveIntegerField(default=100)

    def __str__(self):
        return str(self.user)

    def get_score(self):
        profile, object = StudentDisciplineScore.objects.create(user=self.user) 
        return self.points

    
class IncidentBooking(models.Model):
    user = models.ForeignKey(Students, on_delete=models.CASCADE)
    incident = models.ForeignKey(ClassIncident, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now=True)
    booked_by = models.ForeignKey(MyUser, on_delete=models.CASCADE, related_name='booker')

    def __str__(self):
        return str(self.user)
