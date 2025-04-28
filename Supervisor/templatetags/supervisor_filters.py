import calendar
from django import template
# from Supervisor.views import get_marks_distribution_data
from Finance.models import Expenses, InvoicePayments, Invoices, StudentFeePayment, TermFeeStructure
from Teacher.models import MyClass

from django.db.models import Sum

from Term.models import CurrentTerm, Exam
from Users.models import Classes, MyUser, Students, StudentsFeeAccount


register = template.Library()
# logger = logging.getLogger('django')

@register.simple_tag
def get_term():
    term = CurrentTerm.objects.all().first()
    if term:
        return str(term.term) + ' - ' +str(term.term.year)
    else:
        return 'Set Current Term'

@register.filter
def get_migrations(school):
    term = CurrentTerm.objects.all().first()
    structures = TermFeeStructure.objects.filter(term__term=term)
    fee_profiles = StudentsFeeAccount.objects.filter(user__is_active=True)
    current = 0
    for profile in fee_profiles:
        try:
            grade = profile.user.academicprofile.current_class.grade    
            debit = int(structures.get(grade=grade).amount)
            current = current + debit            
        except:
            pass
    print(current)
    return current
                

@register.simple_tag
def get_grade_count(class_id, subject, term, grade):
    
    count = [exam for exam in Exam.objects.filter(user__academicprofile__current_class__class_id=class_id, subject__id=subject,term=term) if exam.get_grade() == grade]
    
    if count:
        return len(count)
    else:
        return 0

@register.filter
def get_fee_balances(user):
    print('new r')
    balances = StudentsFeeAccount.objects.filter(balance__gte=1, user__school=user.school)
    all_users = Students.objects.filter(is_active=True, school=user.school)

    percentage = (balances.count() / all_users.count() )* 100
    print(balances.count())
    print(percentage, '\n\n\n\n')

    return round(percentage)
@register.filter
def get_fee_percentage():
    profiles = StudentsFeeAccount.objects.filter(balance__gt=0).count()
    students = MyUser.objects.filter(is_active=True, role='Students').count()
    percent = (profiles/students)*100
    return round(percent)
@register.filter
def get_invoice_balances(user):
    invoices = Invoices.objects.filter(school=user.school)
    if invoices:
        balances = invoices.filter(balance=0)
        percentage = (balances.count() / invoices.count()) * 100

        return round(percentage)
    else:
        return 0
def get_days_in_month(year, month):
    # monthrange(year, month) returns a tuple (weekday of first day of the month, number of days in month)
    _, num_days = calendar.monthrange(int(year), int(month))
    return str(num_days)
@register.simple_tag
def get_expenses(year, month, school):
    
    upper_limit = str(get_days_in_month(year, month))
    ud = str(year) + '-' + str(month) + '-' + str(upper_limit)
    expenses = Expenses.objects.filter(date__gte=f'{year}-{month}-1', date__lte=ud, school=school)
    payments = InvoicePayments.objects.filter(date__gte=f'{year}-{month}-1', date__lte=ud,school=school ).aggregate(amount=Sum('amount'))['amount'] or 0
    if expenses:
        amount = expenses.aggregate(amount=Sum('amount'))['amount'] or 0
    else:
        amount = 0
    return int(amount) + int(payments)

@register.simple_tag
def get_incomes(year, month, school):
    
    upper_limit = str(get_days_in_month(year, month))
    ud = str(year) + '-' + str(month) + '-' + str(upper_limit)
    incomes = StudentFeePayment.objects.filter(date__gte=f'{year}-{month}-1', date__lte=ud, user__school=school)
    sums = incomes.aggregate(totals=Sum('transaction_id__amount'))['totals'] or 0

    return sums


@register.simple_tag
def get_class_perfomance(class_id, year, term, period):
    grade_results = Exam.objects.filter(term__term=term,term__year=year, user__academicprofile__current_class__class_id=class_id, period=period).values('user__id').annotate(
        total_marks=Sum('score')
    ).order_by('total_marks')

    # Define the range size
    range_size = 20

    # Create a histogram of total marks in specified ranges
    marks_histogram = {}
    for result in grade_results:
        total_marks = result['total_marks']
        marks_range = (total_marks // range_size) * range_size
        marks_histogram[marks_range] = marks_histogram.get(marks_range, 0) + 1
    labels = list(marks_histogram.keys())
    datasets = [
        {
            'label': 'MARKS DISTRIBUTION',
            'data': [marks_histogram.get(label, 0) for label in labels],
            'backgroundColor': 'rgba(0, 0, 0, 0.5)',
            'borderColor': 'rgba(0, 0, 0, 0.5)',
            'borderWidth': 4,
        }

        ]
    chart_data = {
            'labels': labels,
            'datasets': datasets,
        }
    return chart_data


def sort_marks_distribution_data(grade, year, term, period):
    # Replace 'YourGradeModelField' with the actual field name representing the grade in your SchoolClass model
    grade_results = Exam.objects.filter(term__term=term,term__year=year, user__academicprofile__current_class__class_id__in=grade, period=period).values('user__id').annotate(
        total_marks=Sum('score')
    ).order_by('total_marks')

    
    # Define the range size
    range_size = 20
    

    # Create a histogram of total marks in specified ranges
    marks_histogram = {}
    for result in grade_results:
        total_marks = result['total_marks']
        marks_range = (total_marks // range_size) * range_size
        marks_histogram[marks_range] = marks_histogram.get(marks_range, 0) + 1

    return marks_histogram

@register.simple_tag
def get_schools_grap(grade, year, term, period):
    class_id = grade
    class_id = Classes.objects.filter(grade=grade).values('class_id')
    print(grade,year, term)
    
    academy = sort_marks_distribution_data(class_id, year, term, period)
    

    labels = [160, 180, 200, 220, 240, 260, 280, 300,320, 340, 360, 380, 400, 420, 440, 460, 480, 500, 520]
    datasets = [
        {
            'label': 'E.Academy',
            'data': [academy.get(label, 0) for label in labels],
            'backgroundColor': 'rgba(0, 0, 0, 0.5)',
            'borderColor': 'rgba(0, 0, 0, 0.5)',
            'borderWidth': 2,
        }
    ]
    
    users = Students.objects.filter(academicprofile__current_class__grade=grade).count()
        

    # Convert data to JSON for passing to the template
    chart_data = {
        'labels': labels,
        'datasets': datasets,
        'grade':users
    }

    return chart_data