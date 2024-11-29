from django.contrib import admin
from .models import *
# Register your models here.

admin.site.register(Subscriptions)
admin.site.register(MySubscription)
admin.site.register(Bonuses)
admin.site.register(ReferalPayments)
admin.site.register(MpesaPayments)
admin.site.register(Referal)