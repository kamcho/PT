import datetime
import json
from django.utils import timezone
from datetime import timedelta, datetime
import requests
from django.contrib import messages
from django.shortcuts import render, redirect
import base64
import datetime
from django.db import DatabaseError, IntegrityError
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.generic import TemplateView
from requests.auth import HTTPBasicAuth
from SubjectList.models import PaymentNotifications
from Subscription.tests import generate_access_token, process_number
from Users.models import MyUser, PersonalProfile
from .models import  MpesaPayments, MySubscription, PendingPayment, Subscriptions
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin


# Create your views here.



class Subscribe(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Subscription/subscription.html'

    def get_context_data(self, **kwargs):
        context = super(Subscribe, self).get_context_data(**kwargs)
        user = self.request.user
        try:
            context['subscriptions'] = Subscriptions.objects.all()
            if user.role == 'Student':
                context['my_subscription'] = MySubscription.objects.filter(user=user).first()

                context['today'] = datetime.date.today()
                context['template'] = 'Users/base.html'
            elif user.role == 'Guardian':
                context['template'] = 'Guardian/baseg.html'
        except DatabaseError:
            pass
        return context
    
    def test_func(self):
        roles = ['Guardian', 'Student']
        return self.request.user.role in roles

class Pay(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Subscription/pay.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs) 
        if self.request.user.role == 'Student':
            context['template'] = 'Users/base.html'
        elif self.request.user.role == 'Guardian':
            context['template'] = 'Guardian/baseg.html'
       
        
        context['subscriptions'] = Subscriptions.objects.all().order_by('amount')
        

        return context  
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            amount = self.request.POST.get('amount')
            phone = self.request.POST.get('phone')
            subscription = self.request.POST.get('subscription')
            user = self.request.user.id
            
            if amount != '0':
                
                response = initiate_payment(phone, user, amount)
                if response.status_code == 200:
                    messages.success(self.request, 'Enter M-Pesa pin to complete payment')
                else:
                    messages.error(self.request, 'An error occurred. Kindly try again!')
            return redirect(self.request.get_full_path())
        
    def test_func(self):
        roles = ['Student']
        return self.request.user.role in roles






def initiate_payment(phone, user, total):
    phone=process_number(phone)
    paybill = "4161900"
    timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
    consumer_key = 'fa0e41448ce844d1a7a37553cee8bf22b61fec894e1ce3e9c0e32b1c6953b6d9'
    concatenated_string = f"{paybill}{consumer_key}{timestamp}"
    base64_encoded = base64.b64encode(concatenated_string.encode()).decode('utf-8')
    password = str(base64_encoded)
    access_token = generate_access_token()
    headers = {
        'Authorization': f'Bearer {access_token}',
        'Content-Type': 'application/json'
    }

    payload = {
        "BusinessShortCode": 4161900,  # Use double quotes for all keys and values
        "Password": password,  # Use the generated password
        "Timestamp": timestamp,
        "TransactionType": "CustomerPayBillOnline",
        "Amount": 1,
        "PartyA": phone,
        "PartyB": 4161900,
        "PhoneNumber": phone,
        "CallBackURL": "https://knowedge.online/Subscription/callback/",
        "AccountReference": user,
        "TransactionDesc": "Subscription",

    }

    response = requests.request("POST", 'https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest', headers = headers, json = payload)
    
    return response




def processPayments(request):
    # transactions = pullTransactions()
    transactions = [{'transactionId': 'SH80FBUUHW', 'trxDate': '2024-08-08T21:28:56+03:00', 'msisdn': 254722985477, 'sender': 'MPESA', 'transactiontype': 'c2b-pay-bill-debi', 'billreference': '5', 'amount': '5.0', 'organizationname': 'CRIMSONS ANALYTICS'},
                    {'transactionId': 'SH87F80I47', 'trxDate': '2024-08-08T21:02:51+03:00', 'msisdn': 254742134431, 'sender': 'MPESA', 'transactiontype': 'c2b-pay-bill-debi', 'billreference': 'jhn', 'amount': '5.0', 'organizationname': 'CRIMSONS ANALYTICS'},
                    {'transactionId': 'SH89F73ZIL', 'trxDate': '2024-08-08T20:57:02+03:00', 'msisdn': 254742134431, 'sender': 'MPESA', 'transactiontype': 'c2b-pay-bill-debi', 'billreference': 'kng', 'amount': '1.0', 'organizationname': 'CRIMSONS ANALYTICS'}]
    # print(transactions)
    if transactions:
        for transaction in transactions:
            try:
                receipt = transaction['transactionId']
                phone = transaction['msisdn']
                account = transaction['billreference']
                trxdate = transaction['trxDate']
                amount = int(float(transaction['amount']))

                if amount > 0:
                    sub = MySubscription.objects.get(user__id=3)
                    
                    subscriptions = Subscriptions.objects.get(amount=150)
                    if sub.expiry >= datetime.date.today():
                        expiry = sub.expiry + timedelta(days=subscriptions.duration)
                    else:
                        expiry = datetime.today() + timedelta(days=subscriptions.duration)
                    sub.expiry = expiry
                    sub.type = subscriptions
                    sub.save()
                    updatePayment(sub.user, subscriptions, amount, phone, trxdate, receipt)
                    messages.success(request, '200 ok')
                    # break
            except:
                pass
    return HttpResponse('code : 200 ok')

# def paymentMetadata(user, checkout_id, subscription, phone, beneficiaries):
#     subscription = Subscriptions.objects.get(type=subscription)
#     learners = MyUser.objects.filter(email__in=beneficiaries)
#     user = MyUser.objects.get(email=user)
#     payment = PendingPayment.objects.create(user=user, checkout_id=checkout_id, subscriptions=subscription, phone=phone)   
#     payment.beneficiaries.set(learners)
#     payment.save()

#     return None



def updatePayment(user, subscription, amount, phone, transaction_date, receipt):
  

    user = MyUser.objects.get(email=user)
    sub_type = Subscriptions.objects.get(type=subscription)
    try:
        payment = MpesaPayments.objects.create(user=user, amount=amount, phone=phone,
                                            transaction_date=transaction_date, sub_type=sub_type, receipt=receipt)
        

    except Exception as e:
        return str(e)
    return None

# def updateSubscription(beneficiaries, duration):
    
#     beneficiaries = beneficiaries.split(", ")
#     subscription_type = Subscriptions.objects.get(type=duration)
#     duration = subscription_type.duration
#     sub_type = subscription_type

#     for user in beneficiaries:
#         try:
#             subscription = MySubscription.objects.get(user__email=user)
#             subscription.expiry = subscription.expiry + timedelta(days=duration)
#             subscription.type = sub_type
#             subscription.save()
#         except MySubscription.DoesNotExist as e:
#             user = MyUser.objects.get(email=user)
#             subscription = MySubscription.objects.create(user=user, type=subscription_type)
#             subscription.expiry = subscription.expiry + timedelta(days=duration)
#             subscription.type = sub_type
#             subscription.save()

#     return None
        





# Function to initiate a B2C payment
def initiate_b2c_payment():
    token = generate_access_token()
    headers = {
        'Authorization': f'Bearer { token }',
        'Content-Type': 'application/json',
    }

    payload = {
        
        "OriginatorConversationID":'95f4cb57-ae30-40fb-836b-4f063d0e973t',
        'InitiatorName': 'kevin gitundu',
        "SecurityCredential": "141778215aA!",
        "CommandID": "SalaryPayment",
        "Amount": 1,
        "PartyA": 4161900,
        "PartyB": 254742134431,
        "Remarks": "Test remarks",
        "QueueTimeOutURL": "https://mydomain.com/b2c/queue",
        "ResultURL": "https://mydomain.com/b2c/result",
        "occasion": "Invoice Payment" 
    
    }
    print('initiate')
    response = requests.post('https://api.safaricom.co.ke/mpesa/b2c/v3/paymentrequest', headers=headers, json=payload)

    return response.text
# initiate_b2c_payment()