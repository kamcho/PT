from django.db import models
from Term.models import Terms

from Users.models import Accounts, MyUser, Schools, Students

# Create your models here.


# class StkPayments
class SupplierBalances(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    balance = models.IntegerField()

    def __str__(self):
        return str(self.user)
    
class Invoices(models.Model):
    school = models.ForeignKey(Schools, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now=True)
    title = models.CharField(max_length=200)
    amount = models.PositiveIntegerField()
    balance = models.PositiveIntegerField(default=0)
    description = models.TextField(max_length=1000)
    user = models.ForeignKey(MyUser, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.user)
    

    

class InvoicePayments(models.Model):
    date = models.DateTimeField(auto_now=True)
    school = models.ForeignKey(Schools, on_delete=models.CASCADE)
    processed_at = models.CharField(max_length=100, null=True)
    transaction_id = models.CharField(max_length=100, null=True, blank=True)
    account = models.ForeignKey(Accounts, null=True, on_delete=models.CASCADE)
    mode = models.CharField(max_length=100)
    amount = models.PositiveIntegerField()
    balance = models.PositiveIntegerField()
    user = models.ForeignKey(MyUser, on_delete=models.CASCADE)
    # user_account = models.CharField(max_length=100)
    

    def __str__(self):
        return str(self.user)


    
class ProcessedSalaries(models.Model):
    date = models.DateTimeField(auto_now=True)
    processed_at = models.CharField(max_length=100, null=True)
    transaction_id = models.CharField(max_length=100, null=True,unique=True)
    mode = models.CharField(max_length=100)
    user = models.ForeignKey(MyUser, on_delete=models.CASCADE)
    amount = models.PositiveIntegerField()
    balance = models.PositiveIntegerField()
    user_account = models.CharField(max_length=100, null=True)
    

    def __str__(self):
        return str(self.user.email)



    
class FeeMigrations(models.Model):
    school = models.ForeignKey(Schools, on_delete=models.CASCADE)
    term = models.ForeignKey(Terms, on_delete=models.CASCADE)
    grade = models.CharField(max_length=30)
    boarding = models.BooleanField(default=False)
    gender = models.CharField(max_length=30, null=True)
    amount = models.PositiveIntegerField()
    affected = models.ManyToManyField(Students)

    class Meta:
        unique_together = ('term','grade','boarding','gender')
    def __str__(self):
        return str(self.term.year) + ' ' + str(self.term.term) + ' ' + str(self.grade)
class TermFeeStructure(models.Model):
    school = models.ForeignKey(Schools, on_delete=models.CASCADE)
    term = models.ForeignKey(Terms, on_delete=models.CASCADE)
    grade = models.CharField(max_length=30)
    boarding = models.BooleanField(default=False)
    gender = models.CharField(max_length=30, null=True)
    amount = models.PositiveIntegerField()

    class Meta:
        unique_together = ('term','grade','boarding','gender')
    def __str__(self):
        return str(self.term.year) + ' ' + str(self.term.term) + ' ' + str(self.grade)
    


class RawFeePayment(models.Model):
    receipt = models.CharField(max_length=100, unique=True)
    adm_no = models.CharField(max_length=10, null=True)
    amount = models.PositiveIntegerField()
    # mode = models.CharField(max_length=10)
    account = models.ForeignKey(Accounts,  on_delete=models.CASCADE)
    msdn = models.CharField(max_length=15, null=True)
    processed_at = models.CharField(max_length=100)
    date = models.DateField(auto_now=True)
    status = models.BooleanField(default=False)
    def __str__(self):
        return str(self.receipt)

 
        
class StudentFeePayment(models.Model):
    user = models.ForeignKey(Students, on_delete=models.CASCADE)
    transaction_id = models.ForeignKey(RawFeePayment, on_delete=models.CASCADE)
    balance = models.IntegerField()
    date = models.DateTimeField(auto_now=True)

    def __str__(self):
        return str(self.user)
    
    
class Expenses(models.Model):
    school = models.ForeignKey(Schools, on_delete=models.CASCADE)
    title  = models.CharField(max_length=100)
    description = models.TextField(max_length=1000)
    date = models.DateField(auto_now=True)
    amount = models.PositiveIntegerField()
    mode = models.CharField(max_length=100)

    class Meta:
        ordering = ('-id',)
    def __str__(self) :
        return str(self.title) + ' ' + str(self.amount)

