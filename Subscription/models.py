import datetime
from django.utils import timezone
from django.db import models

# Create your models here.
from Users.models import MyUser


class Subscriptions(models.Model):
    type = models.CharField(max_length=30,unique=True)
    amount = models.PositiveIntegerField()
    validity = models.CharField(max_length=10)
    duration = models.PositiveIntegerField(default=30)

    def __str__(self):
        return str(self.type)
    
    class Meta:
        db_table = 'subscription_subscriptions'  # Custom table name
        managed = False

class Referal(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    referer = models.ForeignKey(MyUser, related_name='referer',  on_delete=models.CASCADE)

    class Meta:
        db_table = 'subscription_referal'  # Custom table name
        managed = False


class MySubscription(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    date = models.DateField(auto_now=True)
    expiry = models.DateField(auto_created=True, default=datetime.date.today )
    type = models.ForeignKey(Subscriptions, to_field='type', on_delete=models.CASCADE)

    def __str__(self):
        return str(self.user)
    def status(self):
        return self.expiry >= datetime.date.today()
    
    class Meta:
        db_table = 'subscription_mysubscription'  # Custom table name
        managed = False

    def active(self):
        today = datetime.date.today()
        if today > self.expiry:
            return 'Subscription Expired'
        elif self.expiry > today:
            return 'Active'
        else:
            return self.user.role



class MpesaPayments(models.Model):
    user = models.ForeignKey(MyUser, on_delete=models.CASCADE)
    amount = models.IntegerField()
    student_list = models.CharField(max_length=100, default='Null')
    date = models.DateTimeField(auto_now=True)
    checkout_id = models.CharField(max_length=100, default='chout')
    receipt = models.CharField(max_length=15)
    phone = models.CharField(max_length=15)
    transaction_date = models.CharField(max_length=100)
    sub_type = models.ForeignKey(Subscriptions, on_delete=models.CASCADE)
    

    def __str__(self):
        return str(self.user)
    
    class Meta:
        db_table = 'subscription_mpesapayments'  # Custom table name
        managed = False


    
