import logging
from django.db.models import Q

from django.db import transaction
from django.conf import settings
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.db.models import Sum
import random
from django.http import HttpResponseForbidden
from django.shortcuts import get_object_or_404, redirect, render
from django.views.generic import TemplateView
from datetime import datetime, timedelta
from django.contrib import messages
from Finance.models import  Expenses, InvoicePayments, Invoices, ProcessedSalaries, RawFeePayment, StudentFeePayment, SupplierBalances, TermFeeStructure
from Finance.tests import pullTransactions
from Subscription.views import initiate_b2c_payment
from Term.models import Terms
from Users.models import Accounts, MyUser, Schools, StudentProfile, Students, StudentsFeeAccount, Classes
# Create your views here.
from django.db.models import Q



logger = logging.getLogger('django')

class FinanceHome(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/finance_home.html'
    
    def dispatch(self, request, *args, **kwargs):
        if request.user.groups.filter(name='view_fees').exists() or  request.user.groups.filter(name='manage_expenses').exists():
            return super().dispatch(request, *args, **kwargs)
        return HttpResponseForbidden("You do not have permission to access this page.")
        
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        expenses = Expenses.objects.filter(school=user.school)
        payments =InvoicePayments.objects.filter(school=user.school ).aggregate(amount=Sum('amount'))['amount'] or 0
        # students = Students.objects.all()
        
        # for student in students:
        #     StudentsFeeAccount.objects.create(user=student, balance=random.randint(-7600, 23000))
        incomes = StudentFeePayment.objects.filter(user__school=user.school)
        context['expenses'] = expenses
        context['incomes'] = incomes.aggregate(total_amount=Sum('transaction_id__amount'))['total_amount'] or 0
        context['year'] = datetime.now().strftime('%Y')
        totals = expenses.aggregate(total_amount=Sum('amount'))['total_amount'] or 0
        context['totals'] = totals + payments

        return context
    

class RawFeePayments(TemplateView):
    template_name = 'Finance/raw_fee_payments.html'

    def get_context_data(self, *args, **kwargs):
        context = super().get_context_data(**kwargs)
        payments = RawFeePayment.objects.filter(school=self.request.user.school).order_by('-id')[:30]
        context['transactions'] = payments
        context['accounts'] = Accounts.objects.filter(school=self.request.user.school)
        return context
    
    def post(self, request, **kwargs):
        if self.request.method == 'POST':
            start_date_str = self.request.POST.get('from')
            end_date_str = self.request.POST.get('to')
            tid = self.request.POST.get('receipt')
            adm = self.request.POST.get('adm')
            account_id = self.request.POST.get('account')
            status = self.request.POST.get('status')

            if start_date_str:
                start_date = datetime.strptime(start_date_str, '%Y-%m-%d')
            else:
                start_date = None
            if end_date_str:
                end_date = datetime.strptime(end_date_str, '%Y-%m-%d')
                end_date += timedelta(days=1)
            else:
                end_date = None
            
            try:
                # Filter transactions within the date range
                bank_kwargs = {}
                stk_kwargs = {}
                
                if account_id:
                    stk_kwargs['account_id'] = account_id
                    bank_kwargs['account_id'] = account_id
               
                if start_date:
                    bank_kwargs['date__gte'] = start_date
                    stk_kwargs['date__gte'] = start_date
                if end_date:
                    bank_kwargs['date__lte'] = end_date
                    stk_kwargs['date__lte'] = end_date
                if tid:
                    stk_kwargs['receipt'] = tid
                    bank_kwargs['receipt'] = tid
                if adm:
                    stk_kwargs['adm_no'] = adm
                    bank_kwargs['adm_no'] = adm
               
                transactions = RawFeePayment.objects.filter(**stk_kwargs)
                if status:
                    status = True if status == 'True' else False
                    transactions = transactions.filter(status=status)
                totals = transactions.aggregate(totals=Sum('amount'))['totals'] or 0
 
                if not transactions:
                    messages.info(self.request, 'We could not find results matching your query!')
                    context = {'nun':'True'}
                else:
                    context = {
                        'transactions': transactions,
                        'totals': totals,
                        'accounts': Accounts.objects.filter(school=self.request.user.school)
                    }
                return render(self.request, self.template_name, context)
            except:
                return redirect(self.request.get_full_path())
        return redirect(self.request.get_full_path())


class CreateInvoice(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/create_invoice.html'
    def dispatch(self, request, *args, **kwargs):       
        if not request.user.groups.filter(name='manage_expenses').exists():
            return HttpResponseForbidden("You do not have permission to access this page.")
        return super().dispatch(request, *args, **kwargs)
    def get_context_data(self, *args, **kwargs):
        context = super().get_context_data(**kwargs)
        context['associates'] = MyUser.objects.filter(role='Supplier', school=self.request.user.school)

        return context

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            title = self.request.POST.get('title')
            description = self.request.POST.get('description')
            amount = self.request.POST.get('amount')
            user = self.request.POST.get('user')
            user = MyUser.objects.get(id_number=user)
            profile = SupplierBalances.objects.get(user=user)
            balance = profile.balance + int(amount)
            try:
                invoice = Invoices.objects.create(title=title,school=self.request.user.school, description=description,
                                                amount=amount, user=user, balance=balance)
                
                profile.balance = balance
                profile.save()
                messages.success(self.request, f'Invoices for {user} created succesfully')
                
                return redirect('invoice-id', invoice.id)
            

            except Exception as e:

                messages.error(self.request, str(e))
                return redirect(self.request.get_full_path())



class SalaryProfiles(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/salary_selection.html'

    def get_context_data(self, *args, **kwargs):
        context = super().get_context_data(**kwargs)
        users = TeacherPaymentProfile.objects.all().order_by('-balance')
        print(users)
        context['users'] = users

        return context

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            ids = self.request.POST.getlist('selected')
            self.request.session['beneficiaries'] = ids
            messages.success(self.request, f'selected {ids}')

            return redirect('confirm-payment')
        

class DisburseSalaries(TemplateView):
    template_name = 'Finance/disburse.html'

    def get_context_data(self, *args, **kwargs):
        context = super().get_context_data(**kwargs)

        email = self.kwargs['email']
        context['profile'] = TeacherPaymentProfile.objects.get(user__email=email)
        
        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            mode = self.request.POST.get('mode')
            tid = self.request.POST.get('transaction')
            user = self.get_context_data().get('profile')
         
            if mode == 'CASH':
                amount = self.request.POST.get('amount')
                balance = int(user.balance) - int(amount)
                salary = ProcessedSalaries.objects.create(mode=mode, user=user.user, amount=amount, balance=balance)
                user.balance = balance
                user.save()
                messages.success(self.request, f'Payment of {amount} was a success. Balance is {balance}.')
            else:
                balance = int(user.balance) - 3000
                salary = ProcessedSalaries.objects.create(mode=mode, user=user.user, amount='13000', balance=balance, transaction_id=tid)
                user.balance = balance
                user.save()
                messages.success(self.request, f'Payment of 13000 was a success. Balance is {balance}.')

            return redirect(self.request.get_full_path())

class SalaryPayments(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/salary_payments.html'

    def get_context_data(self, *args, **kwargs):
        context = super().get_context_data(**kwargs)
        context['salaries'] = ProcessedSalaries.objects.all()


        return context

class SalaryReceipt(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/salary_receipt.html'

    def get_context_data(self, *args, **kwargs):
        context = super().get_context_data(**kwargs)
        tid = self.kwargs['id']
        context['transaction'] = ProcessedSalaries.objects.get(id=tid)


        return context


class InvoicesListView(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/invoices.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            invoices = Invoices.objects.filter(school=self.request.user.school).order_by('-date')
            context['invoices'] = invoices[:100]
            context['totals'] = invoices.aggregate(totals=Sum('amount'))['totals'] or 0

        except Exception:
            messages.error(self.request, 'An error occured, contact @support')

        return context

    def post(self, request, *args, **kwargs):
        # Extract form data
        from_date = request.POST.get('from', None)
        to_date = request.POST.get('to', None)
        status = request.POST.get('mode', None)
        user_query = request.POST.get('user', None)
        lower_amount = request.POST.get('lower', None)
        upper_amount = request.POST.get('upper', None)

        if from_date or to_date or status or user_query or lower_amount or upper_amount:
            # Build query filters
            filters = Q()

            # Date range filter
            if from_date:
                filters &= Q(date__gte=datetime.strptime(from_date, '%Y-%m-%d'))
            if to_date:
                filters &= Q(date__lte=datetime.strptime(to_date, '%Y-%m-%d'))

            # Status filter (assuming 1 is Payment Complete and 0 is Pending Balances)
            if status is not None:
                filters &= Q(balance=0) if status == '1' else Q(balance__gt=0)

            # Amount range filters
            if lower_amount:
                filters &= Q(amount__gte=lower_amount)
            if upper_amount:
                filters &= Q(amount__lte=upper_amount)

            # User filter (search by name, phone, or email)
            if user_query:
                # Create the filter for user-related fields in PersonalProfile
                filters &= Q(user__id_number__icontains=user_query) 
             

            # Apply the combined filters on invoices
            invoices = Invoices.objects.filter(filters)
            totals = invoices.aggregate(totals=Sum('amount'))['totals'] or 0
            # Pass the filtered invoices to the context
            context = {"invoices": invoices, 'totals':totals}

            return render(self.request, self.template_name, context=context)
        else:
            return redirect(self.request.get_full_path())
class InvoiceDetail(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/invoice_id.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        invoice_id = self.kwargs['id']
        try:
            invoice = Invoices.objects.get(id=invoice_id)
          
            context['invoice'] = invoice
            context['accounts'] = Accounts.objects.filter(school=self.request.user.school) 

        except Invoices.DoesNotExist:
            messages.error(self.request, 'We could not find an invoice with the given id. Do not edit URL')
        except Exception as e:
            messages.error(self.request, str(e))

        return context
    
    



def get_transaction_detail(transaction_id):


    transaction = {
        'tid':'QJS7SJS89',
        'date':'today',
        'amount':100,
        'msdn':254742134431

    }
    return transaction
    


@transaction.atomic
def transaction_callback(checkout_id, invoice_id):
    try:
        transaction = get_transaction_detail(checkout_id)
        amount = transaction['amount']
        user_account = transaction['msdn']
        date = transaction['date']
        
        invoice = get_object_or_404(Invoices, id=invoice_id)
        balance = invoice.balance
        new_balance = balance - amount
        

        invoice_payment = InvoicePayments.objects.create(invoice=invoice,mode='M-PESA', amount=amount, balance=new_balance,
                                                            user_account=user_account, transaction_id=checkout_id,
                                                              processed_at=date)

        invoice.balance = new_balance
        invoice.save()

        
        #     print('yeees')
        #     for user in payment.beneficiaries.all():
        #         try:
        #             payouts = MpesaPayouts.objects.create(user=user, checkout_id=processed_payment,
        #                                                 phone='254783680273', amount=1000, balance=200,
        #                                                     receipt='ydkshkdkdyjd')
        #         except Exception as e:
        #             print(str(e))

        # elif payment.purpose == 'Salary':
        #     user = 'user'
        #     payouts = MpesaPayouts.objects.create(user=user, checkout_id=processed_payment,
        #                                                 phone='254783680273', amount=1000, balance=200,
        #                                                     receipt='ydkshkdkdyjd')





    
    except Exception as e:
        print(f"An error occurred: {str(e)}")

    return None




class InvoiceDisbursments(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/invoice_payments.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        try:
            payments = InvoicePayments.objects.all().order_by('-date')
            context['payments'] = payments

        except Exception:
            messages.error(self.request, 'System error please contact @support')

        return context
    

    def post(self,*args, **kwargs):
        if self.request.method == 'POST':
            title = self.request.POST.get('user')
            start = self.request.POST.get('from')
            end = self.request.POST.get('to')
            mode = self.request.POST.get('mode').upper()
            min_ = self.request.POST.get('lower')
            max_ = self.request.POST.get('upper')


            params = {}
            if title:
                params['invoice__title__icontains'] = title
            if start:
                params['date__gte'] = start
            if end:
                params['date__lte'] = end
            if mode:
                params['mode__icontains'] = mode
            if min_:
                params['amount__gte'] = min_
            if max_:
                params['amount__lte'] = max_

            payments = InvoicePayments.objects.filter(**params)

            if payments:
                totals = payments.aggregate(total_amount=Sum('amount'))['total_amount'] or 0
                context = {
                    'payments':payments,
                    'totals':totals
                }
            else:
                messages.info(self.request, 'We could not find invoice payments matching your query')
                context = {}
                # return redirect(self.request.get_full_path())
            
            return render(self.request, self.template_name, context)

class InvoicePaymentId(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/invoice_payment_id.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        payment_id = self.kwargs['id']

        try:
            payment = InvoicePayments.objects.get(id=payment_id)
            context['payment'] = payment
          

        except InvoicePayments.DoesNotExist:
            messages.error(self.request, 'We could not find a transaction with the given id')

        except Exception as e:
            messages.error(self.request, f' {str(e)} System error please contact @support')

        return context


class TransactionsHome(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/finance.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            transactions = MpesaPayouts.objects.all().order_by('-date')
            context['transactions'] = transactions
        except Exception as e:
            messages.error(self.request, 'Database Error ! Contact @Support !!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )


        return context

class InitiatedTransactions(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/initiated_payments.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            transactions = InitiatedPayments.objects.all().order_by('-date')
            context['transactions'] = transactions
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )


        return context
    
    def post(self, **kwargs):
        if self.request.method == 'POST':
            start_date_str = self.request.POST.get('from')  # Assuming 'from' is the field for start date
            end_date_str = self.request.POST.get('to')
            start_date = datetime.strptime(start_date_str, '%Y-%m-%d')
            end_date = datetime.strptime(end_date_str, '%Y-%m-%d')

            # Add one day to the end date to include transactions on that day
            end_date += timedelta(days=1)
            try:
                # Filter transactions within the date range
                transactions = InitiatedPayments.objects.filter(date__range=[start_date, end_date]).order_by('-date')

                context = {
                    'transactions': transactions
                }
                return render(self.request, self.template_name, context)
            except Exception as e:
                # Handle DatabaseError if needed
                messages.error(self.request, 'An error occurred. We are fixing it!')
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'DatabaseError',

                    }
                )
                return redirect(self.request.get_full_path())


    

class ProcessedTransactions(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/processed_payments.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            transactions = ProcessedPayments.objects.all().order_by('-processed_at')
            context['transactions'] = transactions
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )

        return context

    def post(self, request, **kwargs):
        if self.request.method == 'POST':
            start_date_str = self.request.POST.get('from')  # Assuming 'from' is the field for start date
            end_date_str = self.request.POST.get('to')
            start_date = datetime.strptime(start_date_str, '%Y-%m-%d')
            end_date = datetime.strptime(end_date_str, '%Y-%m-%d')

            # Add one day to the end date to include transactions on that day
            end_date += timedelta(days=1)
            try:
                # Filter transactions within the date range
                transactions = ProcessedPayments.objects.filter(processed_at__range=[start_date, end_date]).order_by('-processed_at')

                context = {
                    'transactions': transactions
                }
                return render(self.request, self.template_name, context)
            except Exception as e:
                # Handle DatabaseError if needed
                messages.error(self.request, 'An error occurred. We are fixing it!')
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'DatabaseError',

                    }
                )
                return redirect(self.request.get_full_path())

    
class SuccesfulPayouts(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/succesful_payouts.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            transactions = MpesaPayouts.objects.all().order_by('-date')
            context['transactions'] = transactions
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )


        return context
    
    def post(self, request, **kwargs):
        if self.request.method == 'POST':
            start_date_str = self.request.POST.get('from')  # Assuming 'from' is the field for start date
            end_date_str = self.request.POST.get('to')
            start_date = datetime.strptime(start_date_str, '%Y-%m-%d')
            end_date = datetime.strptime(end_date_str, '%Y-%m-%d')

            # Add one day to the end date to include transactions on that day
            end_date += timedelta(days=1)
            try:
                # Filter transactions within the date range
                transactions = MpesaPayouts.objects.filter(date__range=[start_date, end_date]).order_by('-date')

                context = {
                    'transactions': transactions
                }
                return render(self.request, self.template_name, context)
            except Exception as e:
            # Handle DatabaseError if needed
                messages.error(self.request, 'An error occurred. We are fixing it!')
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'DatabaseError',

                    }
                )
                return redirect(self.request.get_full_path())

        

def initiated_payment_receipt(request, receipt):
    try:
        transaction = InitiatedPayments.objects.get(checkout_id=receipt)
        context = {
            'receipt':transaction
        }
        return render(request, 'Finance/initiated_receipts.html', context)
    except (InitiatedPayments.DoesNotExist, InitiatedPayments.MultipleObjectsReturned):
        messages.error(request, 'We could not find a transaction by this ID !!')
    except Exception as e:
            # Handle DatabaseError if needed
            messages.error(request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )


    return render(request, 'Finance/initiated_receipts.html')

def processed_payment_receipt(request, receipt):
    try:
        transaction = ProcessedPayments.objects.get(transaction_id=receipt)
        context = {
            'receipt':transaction
        }
        return render(request, 'Finance/processed_receipts.html', context)
    except (ProcessedPayments.DoesNotExist, ProcessedPayments.MultipleObjectsReturned):
        messages.error(request, 'We could not find a transaction by this ID !!')
    except Exception as e:
        # Handle DatabaseError if needed
        messages.error(request, 'An error occurred. We are fixing it!')
        error_message = str(e)  # Get the error message as a string
        error_type = type(e).__name__

        logger.critical(
            error_message,
            exc_info=True,  # Include exception info in the log message
            extra={
                'app_name': __name__,
                'url': request.get_full_path(),
                'school': settings.SCHOOL_ID,
                'error_type': error_type,
                'user': request.user,
                'level': 'Critical',
                'model': 'DatabaseError',

            }
        )
    return render(request, 'Finance/processed_receipts.html')
def payout_receipt(request, receipt):
    try:
        transaction = MpesaPayouts.objects.get(receipt=receipt)
        context = {
            'receipt':transaction
        }
        return render(request, 'Finance/payout_receipts.html', context)
    except (MpesaPayouts.DoesNotExist, MpesaPayouts.MultipleObjectsReturned):
        messages.error(request, 'We could not find a transaction by this ID !!')
    except Exception as e:
        # Handle DatabaseError if needed
        messages.error(request, 'An error occurred. We are fixing it!')
        error_message = str(e)  # Get the error message as a string
        error_type = type(e).__name__

        logger.critical(
            error_message,
            exc_info=True,  # Include exception info in the log message
            extra={
                'app_name': __name__,
                'url': request.get_full_path(),
                'school': settings.SCHOOL_ID,
                'error_type': error_type,
                'user': request.user,
                'level': 'Critical',
                'model': 'DatabaseError',

            }
        )
        return render(request, 'Finance/payout_receipts.html')
    


class CreateTerm(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/create_term.html'

    def post(self, request, **kwargs):
        if request.method == 'POST':
            year = request.POST.get('year')
            term = request.POST.get('term')
            starts_at = request.POST.get('from')
            ends_at = request.POST.get('to')

            try:
                term = Terms.objects.get(year=year, term=term)
                messages.error(request, f'{term} of Year {year} already exists. Click Manage Terms above to delete or edit term info.')
            except Terms.DoesNotExist:
                try:
                    term = Terms.objects.create(year=year, term=term, starts_at=starts_at, ends_at=ends_at)
                    messages.success(request, f'Succesfully created {term} for the year {year}')
                except Exception:
                    messages.error(request, f'We could not create this term, Please try again contact @support')
            except Exception as e:
            # Handle DatabaseError if needed
                messages.error(self.request, 'An error occurred. We are fixing it!')
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'DatabaseError',

                    }
                )

        return redirect('term-info', term.id)
    

class FeesListView(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/fees_list.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            fees = TermFeeStructure.objects.all().order_by('id')
            context['terms'] = fees
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )

        return context
    
    def post(self, request, **kwargs):
        if request.method == 'POST':
            term = request.POST.get('term')
            year = request.POST.get('year')
            grade = request.POST.get('grade')
            try:
            
                fees = TermFeeStructure.objects.filter(term__term=term, term__year=year, grade=grade).order_by('-id')
                context = {
                    'terms':fees,
                    'term':term,
                    'grade':grade,
                    'year':year
                }
                if not fees:
                    messages.info(self.request, 'We could not find results matching your query !')

                return render(request, self.template_name, context)
            except Exception as e:
                # Handle DatabaseError if needed
                messages.error(self.request, 'An error occurred. We are fixing it!')
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'DatabaseError',

                    }
                )
                return redirect(self.request.get_full_path())
            



class SetFees(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/set_fees.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            structure = Terms.objects.all().order_by('-id')
            context['terms'] = structure
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )
        return context
    
    def post(self, request, **kwargs):
        if request.method == 'POST':
            term_id = request.POST.get('term')
            grades = request.POST.getlist('grade')
            amount = request.POST.get('amount')
            term = Terms.objects.get(id=term_id)
            gender = request.POST.get('gender')
            boarding = request.POST.get('boarding')

            try:
                structure = TermFeeStructure.objects.get(
    term=term_id,
    grade__in=grades,
    boarding=boarding,
    gender__in=[gender, 'all']  # Use __in to check both gender values
)
                messages.error(request, f'School fees for {term.term} - {term.year} has already been set. Click Manage Fees to edit or delete Fee Structure')
            except TermFeeStructure.DoesNotExist:
                for grade in grades:
                    structure = TermFeeStructure.objects.create(school=request.user.school,term=term, grade=grade, amount=amount, gender=gender, boarding=boarding)
            except Exception as e:
                # Handle DatabaseError if needed
                messages.error(self.request, str(e))
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'DatabaseError',

                    }
                )

            return redirect(request.get_full_path())

class ManageFees(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/manage_fees.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        structure_id = self.kwargs['id']
        try:
            structure = TermFeeStructure.objects.get(id=structure_id)
            context['fee'] = structure
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )

        return context
    
    def post(self, request, **kwargs):
        if request.method == 'POST':
            structure_id = self.kwargs['id']
            payable = request.POST.get('amount')
            try:
                structure = TermFeeStructure.objects.get(id=structure_id)
                if 'edit' in request.POST:
                    
                    structure.amount = payable
                    structure.save()
                    return redirect(request.get_full_path())
                
                else:
                    structure.delete()
                    return redirect('fees-list')
            except (TermFeeStructure.DoesNotExist, TermFeeStructure.MultipleObjectsReturned):
                messages.error(self.request, 'Term Fee Structure Error !')
            except Exception as e:
                # Handle DatabaseError if needed
                messages.error(self.request, 'An error occurred. We are fixing it!')
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'DatabaseError',

                    }
                )
            
        return redirect(request.get_full_path())



class FeesHome(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/fees_home.html'
class SchoolFeeTransactions(TemplateView):
    template_name = 'Finance/fee_transactions.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            transactions = StudentFeeMesaTransaction.objects.all().order_by('-date')
            context['transactions'] = transactions
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )

        return context
    
    
    def post(self, request, *args, **kwargs):
        # Get parameters from the form
        date_param = self.request.POST.get('date')
        receipt_param = self.request.POST.get('receipt')
        admission_number_param = self.request.POST.get('adm_no')
        phone = self.request.POST.get('phone')

        # Start with an empty filter dictionary
        filter_conditions = {}

        # Add conditions for provided parameters
        if date_param:
            filter_conditions['date__date'] = date_param

        if receipt_param:
            filter_conditions['receipt'] = receipt_param
        if phone:
            filter_conditions['phone'] = phone

        if admission_number_param:
            filter_conditions['adm_no'] = admission_number_param
        try:

            # Filter transactions based on the conditions
            transactions = StudentFeeMesaTransaction.objects.filter(**filter_conditions).order_by('-date')

            # Add additional context if needed
            context = {
                'transactions': transactions,
            }
            return render(self.request, self.template_name, context)
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )
            return redirect(self.request.get_full_path())
    
class ProcessedFeePayments(LoginRequiredMixin, TemplateView):

    template_name = 'Finance/fee_payments.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            transactions = StudentFeePayment.objects.filter(user__school=self.request.user.school).order_by('-date')[:30]
            context['transactions'] = transactions
            print('accounts', Accounts.objects.filter(school=self.request.user.school), )
            context['accounts'] = Accounts.objects.filter(school=self.request.user.school)
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )

        return context
    def post(self, request, *args, **kwargs):
        # Get parameters from the form
        date_param = self.request.POST.get('date')
        to = self.request.POST.get('to')
        receipt_param = self.request.POST.get('receipt')
        admission_number_param = self.request.POST.get('adm_no')
        mode = self.request.POST.get('mode')
        phone = self.request.POST.get('phone')
        account = self.request.POST.get('account')

        # Start with an empty filter dictionary
        filter_conditions = {}

        # Add conditions for provided parameters
        if account:
            filter_conditions['transaction_id__account__icontains'] = account
        if phone:
            filter_conditions['transaction_id__msdn__icontains'] = phone
        if date_param:
            filter_conditions['transaction_id__date__gte'] = date_param
        if to:
            filter_conditions['transaction_id__date__lte'] = to
        if receipt_param:
            filter_conditions['transaction_id__receipt'] = receipt_param
        

        if admission_number_param:
            filter_conditions['user__adm_no__icontains'] = admission_number_param
        if mode:
            print(mode)
            filter_conditions['transaction_id__account__account'] = mode

        # Filter transactions based on the conditions
        try:
            
            transactions = StudentFeePayment.objects.filter(**filter_conditions, user__school=self.request.user.school).order_by('-date')
            totals = transactions.aggregate(totals=Sum('transaction_id__amount'))['totals'] or 0
            # Add additional context if needed
            context = {
                'transactions': transactions,
                'totals':totals,
                'accounts':self.get_context_data().get('accounts')
            }

            return render(self.request, self.template_name, context)
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, str(e))
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )
            return redirect(self.request.get_full_path())
    
class ManageProcessedFeePayment(LoginRequiredMixin, TemplateView):

    template_name = 'Finance/manage_fee_payment.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        transaction_id = self.kwargs['id']
        try:
            transaction = StudentFeePayment.objects.get(id=transaction_id, user__school=self.request.user.school)
            print(transaction.user.adm_no)
            # context['names'] = Students.objects.get(adm_no=transaction.user.adm_no)
            number = ''.join(random.choices('0123456789', k=6))
            context['number'] = number
            context['transaction'] = transaction
            students = Students.objects.all()
            for student in students:
                profile = StudentProfile.objects.get(user=student)
                
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, str(e))
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )



        return context
    
    def post(self, request, **kwargs):
        if request.method == 'POST':
            
            adm_no = request.POST.get('adm_no')
            try:
                student = Students.objects.get(adm_no=adm_no)
                if 'verify' in request.POST:
                    
      

                        context = {
                            'student': student,
                            'transaction': self.get_context_data().get('transaction'),
                            'number':self.get_context_data().get('number'),
                            'adm_no':adm_no
                        }

                        return render(request, self.template_name, context=context)
            
                else:
                    transaction_id = self.kwargs['id']
                    otp = request.POST.get('random')
                    
                    if 'TRANSFER' == otp.upper():
                        transaction = StudentFeePayment.objects.get(id=transaction_id, user__school=self.request.user.school)
                        transaction.user = student
                        transaction.save()
                        messages.success(request, 'SUCCESS !')
                    else:
                        messages.error(request, 'You entered the wrong code. Try Again !')
            except MyUser.DoesNotExist:
                messages.error(request, 'Student with this Admission Number Does Not Exist !!')
            except Exception as e:
                # Handle DatabaseError if needed
                messages.error(self.request, 'An error occurred. We are fixing it!')
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'DatabaseError',

                    }
                )
            return redirect(request.get_full_path())

    
class ManageFeeTransaction(LoginRequiredMixin, TemplateView):

    template_name = 'Finance/manage_fee_transaction.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        transaction_id = self.kwargs['id']
        try:
            transaction = StudentFeeMesaTransaction.objects.get(id=transaction_id)
            context['transaction'] = transaction
        except StudentFeeMesaTransaction.DoesNotExist:
            messages.error(self.request, 'We could not find a transaction with this ID !!')
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )


        return context
    

class StudentsFeeProfile(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Finance/student_fee_profile.html'

    def test_func(self):
        return self.request.user.role != 'Teacher'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs) 
        id = self.kwargs['id']
     
        if self.request.user.role == 'Guardian':
            context['base_html'] = 'Guardian/baseg.html'
        elif self.request.user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        elif self.request.user.role in ['Supervisor', 'Finance', 'Receptionist']:
            context['base_html'] = 'Supervisor/base.html'
        try:
            profile = StudentsFeeAccount.objects.get(user__adm_no=id)
            context['profile'] = profile
        except StudentsFeeAccount.DoesNotExist:
           
            messages.error(self.request, 'We could not find a user matching your query')
        except Exception as e:

            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )
        
        if self.request.user.role == 'Guardian':
            print(id)
            transactions = StudentFeePayment.objects.filter(user__adm_no=id)
            if not transactions:
                messages.info(self.request, 'This student has no transactions available')
            context['transactions'] = transactions
        else:
            transactions = StudentFeePayment.objects.filter(user__adm_no=id, user__school=self.request.user.school) 
            if not transactions:
                messages.info(self.request, 'This student has no transactions available')
            context['transactions'] = transactions
        

        return context


class SchoolFeesBalance(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/all_credit_fees.html'

    def dispatch(self, request, *args, **kwargs):
        if not request.user.groups.filter(name='view_fees').exists():
            return HttpResponseForbidden("You do not have permission to access this page.")
        return super().dispatch(request, *args, **kwargs)
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs) 
        try:
            profiles = StudentsFeeAccount.objects.filter(balance__lt=0)[:20]
            balances = profiles.aggregate(balances=Sum('balance'))['balances']
            
            context['balance'] = balances
            context['profiles'] = profiles
            context['classes'] = Classes.objects.filter(school=self.request.user.school, is_active=True)
            
        except Exception:
            messages.error(self.request, 'Database Error !! Contact @support')

        return context
    
    def post(self, request, **kwargs):
        if request.method == 'POST':
            limit = request.POST.get('limit')
            grade = request.POST.get('grade')
            class_name = request.POST.get('class_name')
            
            if not limit and not grade and not class_name:
                return redirect(self.request.get_full_path())
            
            else:
                try:
                    if not limit:
                        limit = 0
                    if int(limit) < 0:
                        profiles = StudentsFeeAccount.objects.filter(balance__lte=limit,balance__lt=0).order_by('balance')
                    else:
                        profiles = StudentsFeeAccount.objects.filter(balance__gte=limit).order_by('-balance')
                    
                    balances = profiles.aggregate(balances=Sum('balance'))['balances']
                    
                    if grade:
                        profiles = profiles.filter(user__academicprofile__current_class__grade=grade)
                    
                    if class_name:
                        profiles = profiles.filter(user__academicprofile__current_class__class_id=class_name)
                    
                    balance = profiles.aggregate(balances=Sum('balance'))['balances']
                    
                    context = {
                        'profiles': profiles,
                        'limit': limit,
                        'grade': grade,
                        'class_name': class_name,
                        'balance': self.get_context_data().get('balance'),
                        'query_balance': balance,
                        'classes': Classes.objects.filter(school=self.request.user.school, is_active=True)
                    }

                    return render(self.request, self.template_name, context)
                    
                except Exception as e:
                    messages.error(self.request, str(e))
                    error_message = str(e)
                    error_type = type(e).__name__

                    logger.critical(
                        error_message,
                        exc_info=True,
                        extra={
                            'app_name': __name__,
                            'url': self.request.get_full_path(),
                            'school': settings.SCHOOL_ID,
                            'error_type': error_type,
                            'user': self.request.user,
                            'level': 'Critical',
                            'model': 'DatabaseError',
                        }
                    )
                    return redirect(self.request.get_full_path())


class ClassFeeBalances(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Finance/class_fee_balances.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs) 
        class_id = self.kwargs['class_id']
        try:
            profiles = StudentsFeeAccount.objects.filter(user__academicprofile__current_class__class_name=class_id,
                                                        balance__lt=0)
            balances = profiles.aggregate(balances=Sum('balance'))['balances']
            
            context['balance'] = balances
            if not profiles:
                    messages.error(self.request, 'We could not find results matching your query.')
            context['profiles'] = profiles
            context['class_id'] = class_id
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )


        return context
    def post(self, request, **kwargs):
        if request.method == 'POST':
            class_id = self.kwargs['class_id']
            limit = request.POST.get('limit')  
            try:
                profiles = StudentsFeeAccount.objects.filter(user__academicprofile__current_class__class_name=class_id,balance__lt=limit)
                balances = profiles.aggregate(balances=Sum('balance'))['balances']
            
                context = {
                    'profiles':profiles,
                    'limit':limit,
                    'class_id':class_id,
                    'balance':self.get_context_data().get('balance'),
                    'query_balance':balances
                }
                if not profiles:
                    messages.error(self.request, 'We could not find results matching your query.')
                
                return render(self.request, self.template_name, context)
            except Exception as e:
                # Handle DatabaseError if needed
                messages.error(self.request, 'An error occurred. We are fixing it!')
                error_message = str(e)  # Get the error message as a string
                error_type = type(e).__name__

                logger.critical(
                    error_message,
                    exc_info=True,  # Include exception info in the log message
                    extra={
                        'app_name': __name__,
                        'url': self.request.get_full_path(),
                        'school': settings.SCHOOL_ID,
                        'error_type': error_type,
                        'user': self.request.user,
                        'level': 'Critical',
                        'model': 'DatabaseError',

                    }
                )
                return redirect(self.request.get_full_path())


    def test_func(self):
        user = self.request.user
        class_name = self.kwargs['class_id']
        try:
            class_id = SchoolClass.objects.filter(class_teacher=user, class_name=class_name)
            return class_id
        except Exception as e:
            # Handle DatabaseError if needed
            messages.error(self.request, 'An error occurred. We are fixing it!')
            error_message = str(e)  # Get the error message as a string
            error_type = type(e).__name__

            logger.critical(
                error_message,
                exc_info=True,  # Include exception info in the log message
                extra={
                    'app_name': __name__,
                    'url': self.request.get_full_path(),
                    'school': settings.SCHOOL_ID,
                    'error_type': error_type,
                    'user': self.request.user,
                    'level': 'Critical',
                    'model': 'DatabaseError',

                }
            )
            return False
        
def verifyPayment(receipt):
    transactions = pullTransactions()
    if transactions:
    
        for transaction in transactions:
            if transaction['transactionId'] == receipt:
                return transaction
            else:
                raise ValueError
   
    

class PrintReceipt(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/print_receipt.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        transaction_id = self.kwargs['transaction_id']
        try:
            fee_payment = StudentFeePayment.objects.get(transaction_id__receipt=transaction_id)
            context['fee_payment'] = fee_payment
            context['student'] = fee_payment.user
            context['transaction'] = fee_payment.transaction_id
        except StudentFeePayment.DoesNotExist:
            messages.error(self.request, 'Receipt not found!')
        return context

class AddFeePayment(LoginRequiredMixin, TemplateView):
    template_name = 'Finance/add_fee_payment.html'

    def dispatch(self, request, *args, **kwargs):
        if not request.user.groups.filter(name='manage_fee').exists():
            return HttpResponseForbidden("You do not have permission to access this page.")
        return super().dispatch(request, *args, **kwargs)
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        email = self.kwargs['email']
        try:
            student = Students.objects.get(adm_no=email)
            context['student'] = student
            context['profile'] = StudentsFeeAccount.objects.get(user=student)
            context['accounts'] = Accounts.objects.filter(school=self.request.user.school, is_active='1')
        except StudentsFeeAccount.DoesNotExist:
            pass
        except:
            messages.error(self.request, 'We could not find a user matching your query!')
        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            try:
                transaction_id = self.request.POST.get('receipt')
                cash = self.request.POST.get('amount')
                amount = int(float(cash))
                phone = self.request.POST.get('phone')
                mode = self.request.POST.get('mode')
                date = self.request.POST.get('date')
                student = self.get_context_data().get('student')
                profile = self.get_context_data().get('profile')
                balance = profile.balance - amount
                profile.balance = balance
                accounts = self.get_context_data().get('accounts')
                account = accounts.get(id=mode)
                



                
                if phone:
                    raw = RawFeePayment.objects.create(receipt=transaction_id, amount=amount,
                                                    account=account, processed_at=date, msdn=phone)
                else:
                    raw = RawFeePayment.objects.create(receipt=transaction_id, amount=amount,
                                                    account=account, processed_at=date)
                fee = StudentFeePayment.objects.create(user=student, transaction_id=raw, balance=balance)
                raw.status = True
                raw.save()
                profile.save()
                messages.success(self.request, 'Payment was successfully added to the system')
                
                # Redirect to print receipt view with the transaction ID
                return redirect('print-receipt', transaction_id=transaction_id)
            except Exception as e:
                messages.error(self.request, str(e))
                return redirect(self.request.get_full_path())



        return redirect('students-view')



class CreateExpense(TemplateView):
    template_name = 'Finance/add_expense.html'
    def dispatch(self, request, *args, **kwargs):
        if not request.user.groups.filter(name='manage_expenses').exists():
            return HttpResponseForbidden("You do not have permission to access this page.")
        return super().dispatch(request, *args, **kwargs)
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['accounts'] = Accounts.objects.filter(school=self.request.user.school, is_active='1')
        return context
    
    def post(self,*args, **kwargs):
        if self.request.method == 'POST':
            

            title = self.request.POST.get('name')
            description = self.request.POST.get('description')
            amount = self.request.POST.get('amount')
            mode = self.request.POST.get('mode')
            
            try:
                expense = Expenses.objects.create(title=title, description=description, amount=amount,
                                                mode=mode, school=self.request.user.school)
            except:
                messages.error(self.request, 'We could not create this expense')
                return redirect(self.request.get_full_path())
            return redirect('manage-expense', expense.id)

class ManageExpense(TemplateView):
    template_name = 'Finance/manage_expense.html'
    def dispatch(self, request, *args, **kwargs):
        if not request.user.groups.filter(name='manage_expenses').exists():
            return HttpResponseForbidden("You do not have permission to access this page.")
        return super().dispatch(request, *args, **kwargs)
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        expense_id = self.kwargs['id']
        try:
            context['expense'] = Expenses.objects.get(id=expense_id, school=self.request.user.school)
        except:
            messages.error(self.request, 'We could not find an expense matching your query!')
        return context
    
class ExpensesView(TemplateView):
    template_name = 'Finance/expenses.html'
    def dispatch(self, request, *args, **kwargs):
        if not request.user.groups.filter(name='view_expenses').exists():
            return HttpResponseForbidden("You do not have permission to access this page.")
        return super().dispatch(request, *args, **kwargs)   

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        expenses = Expenses.objects.filter(school=user.school)
        payments =InvoicePayments.objects.filter(school=user.school ).aggregate(amount=Sum('amount'))['amount'] or 0
        incomes = StudentFeePayment.objects.filter(user__school=user.school)
        context['expenses'] = expenses
        context['incomes'] = incomes.aggregate(total_amount=Sum('transaction_id__amount'))['total_amount'] or 0
        context['year'] = datetime.now().strftime('%Y')
        totals = expenses.aggregate(total_amount=Sum('amount'))['total_amount'] or 0
        context['totals'] = totals + payments

        return context
    
    def post(self,*args, **kwargs):
        if self.request.method == 'POST':
            if 'year' in self.request.POST:
                year = self.request.POST.get('year')
                expenses_t = Expenses.objects.filter(date__year=year, school=self.request.user.school).aggregate(totals=Sum('amount'))['totals'] or 0
                incomes = StudentFeePayment.objects.filter(date__year=year, user__school=self.request.user.school).aggregate(totals=Sum('transaction_id__amount'))['totals'] or 0
                context = {
                    'year':year,
                    'totals': expenses_t,
                    'incomes':incomes,
                    'expenses':self.get_context_data().get('expenses')
                }
                return render(self.request, self.template_name, context)
            else:
                title = self.request.POST.get('title')
                start = self.request.POST.get('from')
                end = self.request.POST.get('to')
                mode = self.request.POST.get('mode').upper()
                min_ = self.request.POST.get('lower')
                max_ = self.request.POST.get('upper')

                print(title, start, end, mode, min_, max_)

                params = {}
                if title:
                    params['title__icontains'] = title
                if start:
                    params['date__gte'] = start
                if end:
                    params['date__lte'] = end
                if mode:
                    params['mode__icontains'] = mode
                if min_:
                    params['amount__gte'] = min_
                if max_:
                    params['amount__lte'] = max_

                expenses = Expenses.objects.filter(**params, school=self.request.user.school)

                if expenses:
                    totals = expenses.aggregate(total_amount=Sum('amount'))['total_amount'] or 0
                    context = {
                        'expenses':expenses,
                        'q_totals':totals,
                        'totals':self.get_context_data().get('totals'),
                        'year':self.get_context_data().get('year'),
                        'incomes':self.get_context_data().get('incomes')
                    }
                else:
                    messages.info(self.request, 'We could not find expenses mattching your query')

                    return redirect(self.request.get_full_path())
                
                return render(self.request, self.template_name, context)


