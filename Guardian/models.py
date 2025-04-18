from django.db import models

from Users.models import MyUser, Students

# Create your models here.


class MyKids(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    kids = models.ManyToManyField(Students, related_name='kids')

    def __str__(self):
        return str(self.user)
    
    # class Meta:
    #     db_table = 'guardian_mykids'  # Custom table name
    #     managed = False