import datetime
import json
import random
import uuid
from django.contrib.auth import authenticate, login
from django.db.models import F, ExpressionWrapper, IntegerField, Case, When
from itertools import chain
from operator import attrgetter

from django.contrib.auth.hashers import make_password

from itertools import groupby
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin

from django.db.models import Sum, Count, F
from django.core.exceptions import ObjectDoesNotExist

from django.contrib import messages
from django.db import IntegrityError, transaction
from django.db.models import Q
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, render, redirect

# Create your views here.
from django.urls import reverse
from django.views import View
from django.views.generic import TemplateView

from Analytics.views import check_role
# from Finance.models import MpesaPayouts
from Discipline.models import StudentDisciplineScore
from Finance.models import FeeMigrations, InvoicePayments, Invoices, SupplierBalances
from Guardian.models import MyKids
from Supervisor.models import Attendance, ExamMode, FileModel, Updates
from Teacher.models import MyClass
from Term.models import CurrentTerm, Exam, Terms
from Users.models import AcademicProfile, Accounts, Classes, MyUser, PersonalProfile, StudentProfile, Students, StudentsFeeAccount
from Exams.models import ClassTest, ClassTestStudentTest, GeneralTest, StudentTest, TopicalQuizAnswers, TopicalQuizes
from SubjectList.models import MySubjects, Subject, Subtopic, Course, Topic

def get_marks_distribution_data(grade, term, year, school, period):
    # Replace 'YourGradeModelField' with the actual field name representing the grade in your SchoolClass model
    grade_results = Exam.objects.filter(term__term=term,term__year=year, user__academicprofile__current_class__grade=grade, user__school=school, period=period).values('user__id').annotate(
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
class SupervisorHomeView(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/supervisor_home.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
       


        students = Students.objects.filter(school=self.request.user.school)
        guardians = MyKids.objects.filter(kids__in=students).distinct()
        print(guardians)
        users = MyUser.objects.filter(school=self.request.user.school)
        val = users.filter(role='Student', personalprofile__gender='Male').count()
        context['users'] = students.count() + users.count() + guardians.count()
        context['males'] = students.filter(studentprofile__gender='Male').count()
        context['females'] = students.filter( studentprofile__gender='Female').count()
        
        context['t_males'] = users.filter(role='Teacher', personalprofile__gender='Male').count()
        context['t_females'] = users.filter(role='Teacher', personalprofile__gender='Female').count()
        context['g_males'] = guardians.filter( user__personalprofile__gender='Male').count()
        context['g_females'] = guardians.filter( user__personalprofile__gender='Female').count()
        context['students'] = students.count()
        context['teachers'] = users.filter(role='Teacher').count()
        context['parents'] = guardians.count()
        context['student_lst'] = users.filter(role='Student')[:10]
        school = self.request.user.school
        period = 'MID'
        grade_4_data = get_marks_distribution_data(4, 'Term 1', '2025', school, period)
        grade_5_data = get_marks_distribution_data(5, 'Term 1', '2025', school, period)
        grade_6_data = get_marks_distribution_data(6, 'Term 1', '2025', school, period)
        grade_7_data = get_marks_distribution_data(7, 'Term 1', '2025', school, period)
        grade_8_data = get_marks_distribution_data(8, 'Term 1', '2025', school, period)
        grade_9_data = get_marks_distribution_data(9, 'Term 1', '2025', school, period)

# Preparing data for the bar chart
        labels = list(grade_5_data.keys())
        datasets = [
            {
                'label': 'Grade 4',
                'data': [grade_4_data.get(label, 0) for label in labels],
                'backgroundColor': 'rgba(0, 0, 0, 0.5)',
                'borderColor': 'rgba(0, 0, 0, 0.5)',
                'borderWidth': 2.5,
            },
            {
                'label': 'Grade 5',
                'data': [grade_5_data.get(label, 0) for label in labels],
                'backgroundColor': 'rgba(85, 133, 181)',
                'borderColor': 'rgba(85, 133, 181)',
                'borderWidth': 2.5,
            },
            {
                'label': 'Grade 6',
                'data': [grade_6_data.get(label, 0) for label in labels],
                'backgroundColor': 'rgba(2, 181, 231)',
                'borderColor': 'rgba(255, 181, 181)',
                'borderWidth': 2.5,
            },
             {
                'label': 'Grade 7',
                'data': [grade_7_data.get(label, 0) for label in labels],
                'backgroundColor': 'rgba(255, 181, 181)',
                'borderColor': 'rgba(255, 181, 181)',
                'borderWidth': 2.5,
            },
             {
                'label': 'Grade 8',
                'data': [grade_8_data.get(label, 0) for label in labels],
                'backgroundColor': 'rgba(55, 181, 181)',
                'borderColor': 'rgba(255, 181, 181)',
                'borderWidth': 2.5,
            },
             {
                'label': 'Grade 9',
                'data': [grade_9_data.get(label, 0) for label in labels],
                'backgroundColor': 'rgba(255, 11, 181)',
                'borderColor': 'rgba(255, 181, 181)',
                'borderWidth': 2.5,
            }
        ]

        # Convert data to JSON for passing to the template
        chart_data = {
            'labels': labels,
            'datasets': datasets,
        }
        current_term = CurrentTerm.objects.filter().last()
        context['current_term'] = current_term
        context['chart_data'] = chart_data
        
        
        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            term = self.request.POST.get('term')
            year = self.request.POST.get('year')
            period = self.request.POST.get('period')
            user = self.request.user
            school = user.school
            grade_4_data = get_marks_distribution_data(4, term, year, school, period)
            grade_5_data = get_marks_distribution_data(5, term, year, school, period)
            grade_6_data = get_marks_distribution_data(6, term, year, school, period)
            grade_7_data = get_marks_distribution_data(7, term, year, school, period)
            grade_8_data = get_marks_distribution_data(8, term, year, school, period)
            grade_9_data = get_marks_distribution_data(9, term, year, school, period)
    # Preparing data for the bar chart
            labels = list(grade_6_data.keys())
            datasets = [
                {
                    'label': 'Grade 4',
                    'data': [grade_4_data.get(label, 0) for label in labels],
                    'backgroundColor': 'rgba(0, 0, 0, 0.5)',
                    'borderColor': 'rgba(0, 0, 0, 0.5)',
                    'borderWidth': 4,
                    
                },
                {
                    'label': 'Grade 5',
                    'data': [grade_5_data.get(label, 0) for label in labels],
                    'backgroundColor': 'rgba(0, 255, 0, 0.8)',
                    'borderColor': 'rgba(0, 255, 0, 1)',
                    'borderWidth': 4,
                },
                {
                    'label': 'Grade 6',
                    'data': [grade_6_data.get(label, 0) for label in labels],
                    'backgroundColor': 'rgba(255, 2, 2, 0.8)',
                    'borderColor': 'rgba(255, 2, 2, 1)',
                    'borderWidth': 4,
                },
                 {
                    'label': 'Grade 7',
                    'data': [grade_7_data.get(label, 0) for label in labels],
                    'backgroundColor': 'rgba(255, 122, 2, 0.8)',
                    'borderColor': 'rgba(255, 2, 2, 1)',
                    'borderWidth': 4,
                },
                {
                    'label': 'Grade 8',
                    'data': [grade_8_data.get(label, 0) for label in labels],
                    'backgroundColor': 'rgba(55, 212, 2, 0.8)',
                    'borderColor': 'rgba(255, 2, 2, 1)',
                    'borderWidth': 4,
                }
                ,
                {
                    'label': 'Grade 9',
                    'data': [grade_9_data.get(label, 0) for label in labels],
                    'backgroundColor': 'rgba(25, 12, 252, 0.8)',
                    'borderColor': 'rgba(255, 2, 2, 1)',
                    'borderWidth': 4,
                }
            ]

            # Convert data to JSON for passing to the template
            chart_data = {
                'labels': labels,
                'datasets': datasets,
            }
            
            context = {
                'chart_data':chart_data,
                'users': self.get_context_data().get('users'),
                'students': self.get_context_data().get('students'),
                'teachers': self.get_context_data().get('teachers'),
                'parents': self.get_context_data().get('parents'),
                'student_lst': self.get_context_data().get('student_lst'),
                'term':term,
                'year':year,
                'current_term':self.get_context_data().get('current_term')

            }

            return render(self.request, self.template_name, context)
        
    def test_func(self):
        return self.request.user.role in ['Supervisor', 'Admin']


class ClassTestAnalytics(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/class_test_analytics.html'

    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        class_id= self.kwargs['class_id']
        try:
            class_ins = Classes.objects.get(class_id=class_id)
        except:
            messages.error(self.request, 'Invalid class id')
        
        if self.request.user.role == 'Student':
            # get the current logged in user(learner) current grade and associated Subjects
            context['base_html'] = 'Users/base.html'
        elif self.request.user.role == 'Guardian':
            context['base_html'] = 'Guardian/baseg.html'
        elif self.request.user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        elif self.request.user.role in ['Supervisor', 'Finance']:
            context['base_html'] = 'Supervisor/base.html'

       
        current_term = CurrentTerm.objects.filter().last()
        context['classes'] = Classes.objects.filter(grade=class_ins.grade)
        context['class'] = class_ins
        context['current_term'] = current_term
        context['term'] = 'Term 1'
        context['year'] = 2025
        context['period'] = 'MID'


        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            term = self.request.POST.get('term')
            year = self.request.POST.get('year')
            period = self.request.POST.get('period')
            context = {
                'classes':self.get_context_data().get('classes'),
                'class':self.get_context_data().get('class'),
                'term':term,
                'year':year,
                'base_html':self.get_context_data().get('base_html'),
                'period':period
            }
            return render(self.request, self.template_name, context)


            


class SupervisorDashboard(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/admin_dashboard.html'

    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        current_term = CurrentTerm.objects.all().first()
        if current_term:
            context['current_term'] = current_term
        else:
            context['current_term'] = False


        return context
    
    def test_func(self):
        return self.request.user.role == 'Supervisor'



class CreateUser(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/create_user.html'

    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        classes = Classes.objects.filter(school=self.request.user.school)
        context['classes'] = classes
        context['adm_no'] = random.randint(10000, 99999999)
        return context
    def test_func(self):
        return self.request.user.role == 'Supervisor'

    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            try:
                f_name = request.POST.get('f_name')
                l_name = request.POST.get('l_name')
                surname = request.POST.get('surname')
                gender = request.POST.get('gender')
                boarding = request.POST.get('boarding')
                fee = request.POST.get('fee')
                class_id = request.POST.get('class')
                adm_no = self.get_context_data().get('adm_no')
                user = Students.objects.create(adm_no=adm_no, school=self.request.user.school)
                profile, obj = StudentProfile.objects.get_or_create(user=user)
                class_id = Classes.objects.get(class_id=class_id)
                profile.f_name = f_name
                profile.l_name = l_name
                profile.surname = surname
                profile.gender = gender
                profile.is_boarder = boarding
                profile.save()
                academia,obj = AcademicProfile.objects.get_or_create(user=user, current_class=class_id)
                
                created = StudentsFeeAccount.objects.create(user=user, balance=fee)
        

                return redirect('add-parent', user.id)
            
                
           
            except Exception as e:
                messages.error(self.request, f'We could not save the student. Contact @support')

            return redirect(request.get_full_path())

def search_students(request):
    query = request.GET.get('query', '')
    roles = Students.objects.filter(adm_no__icontains=query).values('adm_no', 'id', 'studentprofile__f_name', 'studentprofile__l_name', 'studentprofile__surname')
    return JsonResponse({'students': list(roles)})
class CreateStaff(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/create_staff.html'

    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        classes = Classes.objects.filter(school=self.request.user.school)
        context['classes'] = classes
        # context
        return context
    def test_func(self):
        return self.request.user.role == 'Supervisor'

    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            try:
                f_name = request.POST.get('f_name')
                l_name = request.POST.get('l_name')
                surname = request.POST.get('surname')
                gender = request.POST.get('gender')
                number = request.POST.get('id_number')
                phone = request.POST.get('phone')
                role = request.POST.get('role')
                

                if role == 'Guardian':
                    user = MyUser.objects.create(id_number=number,role=role, password=make_password(phone))
                elif role == 'Supplier':
                    number = self.request.user.school.id+number
                    user = MyUser.objects.create(id_number=number,role=role,school=self.request.user.school, password=make_password(phone))
                else:
                    user = MyUser.objects.create(id_number=number,role=role,school=self.request.user.school, password=make_password(phone))
                profile, obj = PersonalProfile.objects.get_or_create(user=user)
                
                profile.f_name = f_name
                profile.l_name = l_name
                profile.surname = surname
                profile.gender = gender
                profile.phone = phone
                profile.save()

                if role == 'Guardian':
                    selected_admission_numbers = request.POST.get('selected_admission_numbers', '')
    # Split the string into a list of admission numbers
                    selected_admission_numbers_list = selected_admission_numbers.split(',')
                    print(selected_admission_numbers_list)
                    my_kids, obj = MyKids.objects.get_or_create(user=user)
                    stds = Students.objects.filter(adm_no__in=selected_admission_numbers_list)
                    my_kids.kids.add(*stds)
                
                messages.success(self.request, 'Success!')

                return redirect(self.request.get_full_path())
            
                
           
            except Exception as e:
                messages.error(self.request, str(e))

            return redirect(request.get_full_path())

class StudentSubjectSelect(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/add_student_subjects.html'

    def test_func(self):
        return self.request.user.role == 'Supervisor'
    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        if self.request.user.role == 'Teacher':
            # get the current logged in user(learner) current grade and associated Subjects
            context['base_html'] = 'Users/base.html'
       
        elif self.request.user.role in ['Supervisor', 'Finance', 'Receptionist']:
            context['base_html'] = 'Supervisor/base.html'
        
        adm = self.kwargs['adm_no']
        profile = AcademicProfile.objects.get(user__adm_no=adm)
        context['student'] = profile
        context['subjects'] = Subject.objects.filter(grade=profile.current_class.grade)

        return context
    
    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            try:
                user = self.get_context_data().get('student')
                subjects = self.get_context_data().get('subjects')
                profile, obj = MySubjects.objects.get_or_create(user=user.user)
                subject_ids = self.request.POST.getlist('subjects')
                subjects = subjects.filter(id__in=subject_ids)
                profile.name.clear()
                profile.name.add(*subjects)
                messages.success(self.request, 'Subjects added successfully !')

                return redirect('students-profile', user.user.adm_no)
            except:
                messages.error(self.request, 'OOOps that didn`t work !!')
                return redirect(self.request.get_full_path())

class AddParent(LoginRequiredMixin, UserPassesTestMixin,TemplateView):
    template_name = 'Supervisor/add_parent.html'
    def test_func(self):
        return self.request.user.role == 'Supervisor'
    def get_context_data(self, **kwargs) :
        context = super().get_context_data(**kwargs)
        id = self.kwargs['id']
        student = Students.objects.get(id=id)
        context['student'] = student
        return context
    
    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body)  # Parse JSON data
            student= self.get_context_data().get('student')
            guardians = data.get("guardians", [])
            print(guardians)
            
            # Fetch the student
            if not student:
                return JsonResponse({"error": "Student not found"}, status=400)

            # Process each guardian
            for guardian_data in guardians:
                print(guardian_data)
                id_number = guardian_data.get("id_number")
                full_name = guardian_data.get("full_name")
                phone = guardian_data.get("phone")
                gender = guardian_data.get("gender")
                try:
                    MyUser.objects.get(id_number=id_number)
                # Check if guardian exists
                except:

                    guardian = MyUser.objects.create(id_number=id_number, role='Guardian', password=make_password(phone))
                    profile, obj = PersonalProfile.objects.get_or_create(user=guardian)
                    full_name = guardian_data.get("full_name", "").strip()

# Split the full name into parts
                    name_parts = full_name.split()

                    # Assign values based on the number of parts
                    f_name = name_parts[0] if len(name_parts) > 0 else ""
                    l_name = name_parts[1] if len(name_parts) > 1 else ""
                    surname = name_parts[2] if len(name_parts) > 2 else ""
                    profile.f_name = f_name
                    profile.phone = phone
                    profile.l_name = l_name
                    profile.surname = surname
                    profile.gender = gender
                    profile.save()
                    profilio, obj = MyKids.objects.get_or_create(user=guardian)
                    profilio.kids.add(student)
                # If guardian already exists but details are different, update them
            print(student.adm_no, 'mhd s d \n\n\n')
            return JsonResponse({"redirect_url": reverse('students-profile', args=[student.adm_no])})


        except json.JSONDecodeError:
            return JsonResponse({"error": "Invalid JSON data"}, status=400)

        except Exception as e:
            print(str(e))
            return JsonResponse({"error": str(e)}, status=500)
    
  # Assuming MyUser stores guardian details

class SearchGuardianView(View):
    def get(self, request):
        id_number = request.GET.get('id_number')
        
        try:
            guardian = MyUser.objects.get(id_number=id_number, role='Guardian')
            return JsonResponse({
                'exists': True,
                'name': " ".join((guardian.personalprofile.f_name, guardian.personalprofile.l_name, guardian.personalprofile.surname)),

                'phone': guardian.personalprofile.phone,
                'gender': guardian.personalprofile.gender
            })
        except MyUser.DoesNotExist:
            return JsonResponse({'exists': False})

class LinkStudent(LoginRequiredMixin,  UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/link.html'
    
    def test_func(self):
        return self.request.user.role == 'Supervisor'
    
    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            if 'verify' in self.request.POST:
                params = request.POST.get('search')
                print(params)
                adm = self.kwargs['adm']
                mykids = MyKids.objects.filter(kids__adm_no=adm)
                if params:
                    users = MyUser.objects.filter(Q(personalprofile__f_name__contains=params) | Q(personalprofile__l_name__contains=params)
                                                    | Q(personalprofile__surname__contains=params) | Q(email__contains=params), role='Guardian')
                    print(users)
                    context = {'parents':users,
                                'guardians':mykids,
                                'verified':True
                            }
                    

                    return render(self.request, self.template_name, context)
                else:
                    return redirect(self.request.get_full_path())        
            elif 'remove' in self.request.POST:
                pr = self.request.POST.get('remove')
                adm = self.kwargs['adm']
                std = MyUser.objects.get(adm_no=adm)
                mykkids = MyKids.objects.get(user__id=pr)
                mykkids.kids.remove(std)

                return redirect(self.request.get_full_path())
            else:
                parent = self.request.POST.get('names')
                adm = self.kwargs['adm']
                kid = MyUser.objects.get(adm_no=adm)
                pr = MyUser.objects.get(id=parent)
                mykids, create = MyKids.objects.get_or_create(user=pr)
                mykids.kids.add(kid)
                messages.success(self.request, 'Success')
        return redirect(self.request.get_full_path())
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        adm = self.kwargs['adm']

        mykids = MyKids.objects.filter(kids__adm_no=adm)
        context['guardians'] = mykids
        return context
class StudentsView(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/students_view.html'

    

    def get_context_data(self, **kwargs):
        context = super(StudentsView, self).get_context_data(**kwargs)
        user = self.request.user
        
        try:            
            users = Students.objects.filter(academicprofile__current_class__school=user.school).order_by('?')[:15]
            


            
            context['users'] = users
            if not users:
                messages.error(self.request, 'We could not fetch students from the database')
           
        except Exception:
            messages.error(self.request, 'An error occured. Contact @support')
            
        return context
    
    def post(self,*args, **kwargs):
        if self.request.method == 'POST':
            params = self.request.POST.get('search')
                            
            if params:
                users = Students.objects.filter(Q(studentprofile__f_name__contains=params) | Q(studentprofile__l_name__contains=params)
                                                | Q(studentprofile__surname__contains=params) | Q(adm_no__contains=params), school=self.request.user.school)
                context = {'users':users}
                if not users:
                    messages.info(self.request, 'We could not find results matching your query !')
                return render(self.request, self.template_name, context)
            else:
                return redirect(self.request.get_full_path())
            
                
                
            
          
    def test_func(self):
        return self.request.user.role not in ['Student', 'Guardian']
        

class TeachersView(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/teachers_view.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        try:
            
            users  = MyUser.objects.filter(role='Teacher', school=user.school)
            context['users'] = users
        
        except Exception:
            messages.error(self.request, 'We could not fetch Teachers from the database')
        return context
    
    def post(self, request, *args, **kwargs):
        if request.method == 'POST':

            params = request.POST.get('search')
           
            if params:
                users = MyUser.objects.filter(Q(personalprofile__f_name__contains=params) | Q(personalprofile__l_name__contains=params)
                                                | Q(personalprofile__surname__contains=params) | Q(email__contains=params), role='Teacher')
                context = {'users':users}
                return render(self.request, self.template_name, context)
            else:
                return redirect(self.request.get_full_path())                                                                   
                
        return redirect(self.request.get_full_path())


class GuardianListView(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/guardians_view.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        try:
            students = Students.objects.filter(school=self.request.user.school)
            users  = MyKids.objects.filter(kids__in=students).distinct()
            print(users)
            context['users'] = users
        
        except Exception:
            messages.error(self.request, 'We could not fetch Teachers from the database')
        return context
    
    def post(self, request, *args, **kwargs):
        if request.method == 'POST':

            params = request.POST.get('search')
            query = self.get_context_data().get('users')
            if params:
                users = query.filter(Q(user__personalprofile__f_name__contains=params) | Q(user__id_number__icontains=params) | Q(user__personalprofile__l_name__contains=params)
                                                | Q(user__personalprofile__surname__contains=params) | Q(user__personalprofile__phone__contains=params))
                context = {'users':users}
                return render(self.request, self.template_name, context)
            else:
                return redirect(self.request.get_full_path())                                                                   
                
        return redirect(self.request.get_full_path())

class TeachersProfile(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/teachers_profile.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        email = self.kwargs['email']
        user = MyUser.objects.get(email=email)
        my_class = StudentList.objects.filter(user=user)
        context['classes'] = my_class
        context['teacher'] = user

        return context
    
class TeachersInfo(LoginRequiredMixin,TemplateView):
    template_name = 'Supervisor/teacher_info.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        email = self.kwargs['email']
        try:
            user = MyUser.objects.get(email=email)
            my_class = StudentList.objects.filter(user=user)
    
                # get teacher profile
        
            context['classes'] = my_class
            context['teacher'] = user
        except:
            messages.error(self.request, 'We could not find user matching query!')

        return context

class GuardianView(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/guardian_view.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        email = self.kwargs['email']
        try:
            context['guardian'] = MyUser.objects.get(id_number=email)
        except MyUser.DoesNotExist:
            messages.error(self.request, 'User does not exist !!')
        


        return context
def get_week_dates(given_date):
    """
    Given a date, return a list of dictionaries containing the dates of the same week (Monday-Sunday),
    with the day name in uppercase.
    """
    # Convert string to date if necessary
    if isinstance(given_date, str):
        given_date = datetime.strptime(given_date, "%Y-%m-%d").date()

    # Get the weekday (Monday=0, Sunday=6)
    weekday_index = given_date.weekday()

    # Find the Monday of the current week
    monday = given_date - datetime.timedelta(days=weekday_index)

    # Generate the week dates
    week_dates = [
        {"date": (monday + datetime.timedelta(days=i)).strftime("%Y-%m-%d"),
         "day": (monday + datetime.timedelta(days=i)).strftime("%a").upper()}
        for i in range(7)
    ]

    return week_dates

class SchoolAttendance(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/attendance.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        date = datetime.date.today()
        context['date'] = date
        attendances = Attendance.objects.filter(date=date, class_id__school=user.school)

        # Get all students in these attendance records
        students_in_attendance = Students.objects.filter(attendance__in=attendances).distinct()
        print(students_in_attendance, 'atteb')
        context['students'] = students_in_attendance
        return context

class SupplierProfile(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/supplier_profile.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        id = self.kwargs['id']
        context['accounts'] = Accounts.objects.filter(school=self.request.user.school) 
        supplier = MyUser.objects.get(id=id)
        context['supplier'] = supplier
        invoices = Invoices.objects.filter(user__id=id)
        payments = InvoicePayments.objects.filter(user__id=id)
        # SupplierBalances.objects.create(user=supplier, balance=23750)
        # Tag each item to know the type in the template
        for invoice in invoices:
            invoice.item_type = 'invoice'
        
        for payment in payments:
            payment.item_type = 'payment'

        # Combine and sort by date
        combined = sorted(
            chain(invoices, payments),
            key=attrgetter('date'),
            reverse=True  # optional: latest first
        )
        context['transactions'] = combined

        # context['supplier'] = SupplierBalances.objects.get_or_create(user__id=id, balance=3450)
        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            if True:
                profile = self.get_context_data().get('supplier')
                amount = self.request.POST.get('amount')
                tid = self.request.POST.get('tid')
                mode = self.request.POST.get('mode')
                # date = datetime.now().strftime('%Y/%m/%d')
                balance = profile.supplierbalances.balance - int(amount)
                try:
                    account = Accounts.objects.get(id=mode, school=self.request.user.school)
                    pay = InvoicePayments.objects.create(transaction_id=tid,
                                                      mode=account.name, amount=amount, balance=balance,
                                                      user=profile, account=account,school=self.request.user.school)
                    messages.success(self.request, 'Payment processed succesfully !')
                except:
                    if mode == 'Cash':
                        pay = InvoicePayments.objects.create(transaction_id=tid,
                                                      mode="Cash", amount=amount, balance=balance,
                                                      user=profile, school=self.request.user.school)
                    else:
                        messages.error(self.request, 'We could not process this invoice payment !')

               
                
                profile.supplierbalances.balance = balance
                profile.supplierbalances.save()
                return redirect(self.request.get_full_path())
class StudentsProfile(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/students_profile.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        email = self.kwargs['email']
        # students = Students.objects.all()
        today = datetime.date.today()
        context['days'] = get_week_dates(today)[:5]
        try:
            context['term'] = 'Term 1'
            
            user  = Students.objects.get(adm_no=email)
            grade = user.academicprofile.current_class.grade
            context['grade'] =  grade
            grades = list(range(1, int(grade) + 1))
            context['grades'] = ['PG', 'PP1', 'PP2'] + grades
            print(grade)
            guardians = MyKids.objects.filter(kids=user)
            context['guardians'] = guardians
            subjects = Subject.objects.filter(grade=grade)
            context['subjects'] = subjects
            context['student'] = user
            mysubjects, obj = MySubjects.objects.get_or_create(user=user)
            context['mysubjects'] = mysubjects.name.all()
            excluded = mysubjects.name.values_list('id', flat=True)
            print(mysubjects.name.values_list('id', flat=True))
            context['foregone'] = subjects.exclude(id__in=excluded)
        except Exception as e:
            messages.error(self.request, f'We could not find a user matching your query ! {str(e)}')
        if self.request.user.role == 'Student':
            # get the current logged in user(learner) current grade and associated Subjects
            context['base_html'] = 'Users/base.html'
        elif self.request.user.role == 'Guardian':
            context['base_html'] = 'Guardian/baseg.html'
        elif self.request.user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        elif self.request.user.role in ['Supervisor', 'Finance', 'Receptionist']:
            context['base_html'] = 'Supervisor/base.html'
        return context
    
    def post(self, request, *args, **kwargs):
        grade  = self.request.POST.get('grade')
        term = self.request.POST.get('term')
        grades = self.get_context_data().get('grades')
        guardians = self.get_context_data().get('guardians')
        subjects = self.get_context_data().get('subjects')
        mysubjects = self.get_context_data().get('mysubjets')
        foregone = self.get_context_data().get('foregone')
        base_html = self.get_context_data().get('base_html')
        student = self.get_context_data().get('student')
        context = {
            'grade':grade,
            'grades':grades,
            'term':term,
            'guardians':guardians,
            'subjects':subjects,
            'mysubjects':mysubjects,
            'student':student,
            'foregone':foregone,
            'base_html':base_html,
            'def':'def'
        }

        return render(self.request, self.template_name, context)


    
class ManageStudent(UserPassesTestMixin, LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/manage_student.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs) 
        try:
            email = self.kwargs['email']
            student = Students.objects.get(adm_no=email)
            classes = Classes.objects.filter(school=self.request.user.school)
            context['classes'] = classes
            context['student'] = student
        except Students.DoesNotExist:
            email = self.kwargs['email']
            student = MyUser.objects.get(id_number=email)
            
            context['student'] = student
        except Exception as e:
            messages.error(self.request, str(e))

        return context
    
    def post(self, request, **kwargs):
        if request.method == 'POST':
            email = request.POST.get('email')
            phone = request.POST.get('phone')
            student = self.get_context_data().get('student')
            f_name = request.POST.get('f_name')
            l_name = request.POST.get('l_name')
            surname = request.POST.get('surname')
            class_id = request.POST.get('class')

            gender = request.POST.get('gender')
            try:
                profile = self.get_context_data().get('student')
                if 'update' in request.POST:
                    if phone:
                        adm = self.kwargs['email']
                        
                        profile.personalprofile.f_name = f_name
                        profile.personalprofile.surname = l_name
                        profile.personalprofile.surname = surname
                        
                    else:
                        class_id = Classes.objects.get(class_id=class_id)
                        acd_profile = AcademicProfile.objects.get(user=student)
                        acd_profile.current_class = class_id
                        acd_profile.save()
                        profile.studentprofile.f_name = f_name
                        profile.studentprofile.l_name = l_name
                        profile.studentprofile.surname = surname
                        profile.studentprofile.gender = gender
                        profile.studentprofile.save()
                    messages.info(self.request, 'Update was successfull.')
                    

                    return redirect(request.get_full_path())
                elif 'delete' in request.POST:
                    profile.is_active = False
                    profile.save()
                    messages.info(request, f'You have succesfully archived a user')
                    return redirect(self.request.get_full_path())

                elif 'purge' in request.POST:
                    messages.info(request, f'You have succesfully Deleted {user.personalprofile.get_names()} from Students Database')
                    profile.is_active = False
                    profile.save()
                    return redirect('supervisor-home')
                else:
                    
                    profile.is_active = True
                    profile.save()
                    messages.success(request, f'You have succesfully restored a user')
                    return redirect(self.request.get_full_path())
            except Exception as e:
                messages.error(self.request, str(e))
                return redirect(self.request.get_full_path())
            
    def test_func(self):
        return self.request.user.role == 'Supervisor'

                
            

class ArchivedUsers(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/archived_users.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        users = MyUser.objects.filter(is_active='False')
        context['users'] = users

        return context

    def test_func(self):
        return self.request.user.role == 'Supervisor'


            

class StudentExamProfile(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/students_exam_profile.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['base_html'] = check_role(self.request.user)
        
        id = self.kwargs['id']
        try:
            student  = Students.objects.get(adm_no=id)
            grade = self.request.session.get('grade', student.academicprofile.current_class.grade)
            term = self.request.session.get('term','Term 1')
            print(self.request.user.role)
            scores = Exam.objects.filter(user__adm_no=id, subject__grade=grade, term__term=term) 
            if scores:
                opener = scores.filter(period='OPENER')
                mid = scores.filter(period='MID')
                end = scores.filter(period='END')
                context['opener'] = opener
                context['mid'] = mid
                context['end'] = end
                context['scores'] = scores
                context['term'] = term
            context['grade'] = grade
            context['student']  = student
        except:
            messages.error(self.request, 'We could not find a student matching your query !')
        # if self.request.user.role == 'Guardian':
        #     # get the current logged in user(learner) current grade and associated Subjects
        #     context['base_html'] = 'Guardian/baseg.html'
        
        # elif self.request.user.role == 'Teacher':
        #     context['base_html'] = 'Teacher/teachers_base.html'
        # elif self.request.user.role == 'Supervisor':
        #     context['base_html'] = 'Supervisor/base.html'
        # print(self.request.user.role)
        

        
        
        context['student'] = student
        return context
    
    # def test_func(self):
    #     return self.request.user.role == 'Supervisor'
    
    def post(self, *args, **kwargs):
      
        if self.request.method == 'POST':
            selected = self.request.POST.get('grade')
            term = self.request.POST.get('term') 
            print(term)
            self.request.session['grade'] = selected
            self.request.session['term'] = term


            return redirect(self.request.get_full_path())



class StudentTaskSelect(TemplateView):
    template_name = 'Supervisor/student_task_select.html'

    def get_context_data(self, **kwargs):
        context = super(StudentTaskSelect, self).get_context_data(**kwargs)
        email = self.kwargs['email']
        try:
            user  = MyUser.objects.get(email=email)
            context['user'] = user
        except:
            messages.error(self.request, 'We could not find a student matching your query !')
        return context


class StudentTestsView(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/students_test_view.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        email = self.kwargs['email']
        context['email'] = email
        tests = StudentTest.objects.filter(user__email=email)
        class_tests = ClassTestStudentTest.objects.filter(user__email=email)
        general_tests = GeneralTest.objects.filter(user__email=email)
        if not tests and not class_tests and not general_tests:
            messages.warning(self.request, 'This user has not taken any tests')
        
        context['class_tests'] = class_tests
        context['general_tests'] = general_tests
        context['tests'] = tests
        return context


class StudentTestDetailView(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/students_test_detail.html'

    def test_func(self):
        return self.request.user.role == 'Supervisor'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        email = self.kwargs['email']
        test_id = self.kwargs['test_id']
        test_type = self.kwargs['test_type']
        try:
            if test_type == 'TopicalTest':
                test = StudentTest.objects.get(user__email=email, uuid=test_id)
                context['status'] = test.archived
            elif test_type == 'ClassTest':
                test = ClassTestStudentTest.objects.get(user__email=email, uuid=test_id)
                context['status'] = test.archived
            elif test_type == 'GeneralTest':
                test = GeneralTest.objects.get(user__email=email, uuid=test_id)
                context['status'] = test.archived
            else:
                messages.error(self.request, 'Invalid Test')
            context['test'] = test

        except :
            messages.error(self.request, 'We could not find this test')

        return context

    def post(self, *args, **kwargs):
        if self.request.method == "POST":

            try:
                if 'delete' in self.request.POST:
                    test_type = self.kwargs['test_type']
                    email = self.kwargs['email']
                    test_id = self.kwargs['test_id']
                    if test_type == 'TopicalTest':
                        test = StudentTest.objects.get(user__email=email, uuid=test_id)
                        test.archived = True
                        test.save()
                    elif test_type == 'ClassTest':
                        test = ClassTestStudentTest.objects.get(user__email=email, uuid=test_id)
                        test.archived = True
                        test.save()
                    elif test_type == 'GeneralTest':
                        test = GeneralTest.objects.get(user__email=email, uuid=test_id)
                        test.archived = True
                        test.save()
                    else:
                        messages.error(self.request, 'Invalid Test')
                elif 'restore' in self.request.POST:
                    test_type = self.kwargs['test_type']
                    email = self.kwargs['email']
                    test_id = self.kwargs['test_id']
                    if test_type == 'TopicalTest':
                        test = StudentTest.objects.get(user__email=email, uuid=test_id)
                        test.archived = False
                        test.save()
                    elif test_type == 'ClassTest':
                        test = ClassTestStudentTest.objects.get(user__email=email, uuid=test_id)
                        test.archived = False
                        test.save()
                    elif test_type == 'GeneralTest':
                        test = GeneralTest.objects.get(user__email=email, uuid=test_id)
                        test.archived = False
                        test.save()
                    else:
                        messages.error(self.request, 'Invalid Test')

            except:
                pass

            return redirect(self.request.get_full_path())
        
class CreateClass(TemplateView, LoginRequiredMixin):
    template_name = 'Supervisor/create_class.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        
        context['teachers'] = MyUser.objects.filter(role='Teacher', school=user.school)

        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == "POST":
            class_name = self.request.POST.get('name')
            grade = self.request.POST.get('grade')
            class_size = self.request.POST.get('size')
            class_teacher = self.request.POST.get('teacher')
            if class_teacher:
                class_teacher = self.get_context_data().get('teachers').get(email=class_teacher)
                try:
                    school_class = Classes.objects.create(class_name=class_name, grade=grade, class_size=class_size,
                                                            class_teacher=class_teacher, school=self.request.user.school)
                    
                    messages.success(self.request, f'{class_name} Has Been Added To Classes')
                except Exception as e:
                    messages.error(self.request, str(e))
            else:
                try:
                    school_class = Classes.objects.create(name=class_name, grade=grade,
                                                             school=self.request.user.school)
                    
                    messages.success(self.request, f'{class_name} Has Been Added To Classes')
                except Exception as e:
                    messages.error(self.request, str(e))
            return redirect(self.request.get_full_path())

            

class ClassesView(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/classes.html'

    

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        user = self.request.user
        classes = Classes.objects.filter(school=user.school).order_by('grade')

        if user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
            
        elif user.role in ['Supervisor']:
            context['base_html'] = 'Supervisor/base.html'
            
        context['classes'] = classes
        

        return context     

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            
            grade = self.request.POST.get('grade')
            classes = Classes.objects.filter(Q(grade=grade))

            context = {
                'classes':classes,
                'base_html':self.get_context_data().get('base_html'),
            }

            return render(self.request, self.template_name, context)
        else:
            return redirect(self.request.get_full_path())
    

class ClassList(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/class_list.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        class_id = self.kwargs['class_id']
        class_ins = Classes.objects.get(class_id=class_id)

        attendance_date = datetime.date.today()
        try:
            attendance = Attendance.objects.get(
                class_id=class_ins,
                date=attendance_date,
            )
            context['attendance'] = attendance
        except:
            pass
        context['class'] = class_ins
        
        students = Students.objects.filter(academicprofile__current_class=class_ins)
        context['students'] = students


        return context

    def post(self, request, **args):
        if request.method == 'POST':
            missing = self.request.POST.getlist('attendance') 
            class_id = self.get_context_data().get('class')
            attendance_date = datetime.date.today()
            attendance, created = Attendance.objects.get_or_create(
            class_id=class_id,
            date=attendance_date,
            defaults={"marked_by": self.request.user}
        )
            students = Students.objects.filter(adm_no__in=missing)
            attendance.students.clear()
            attendance.students.add(*students)
            messages.info(self.request, f'Attendance marked! {students.count()} students were missing.')

        return redirect(self.request.get_full_path())
class ClassDetail(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/class_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        class_id = self.kwargs['class_id']
        context['period'] = self.request.session.get('period', 'MID')
        try:
            class_id = Classes.objects.get(class_id=class_id)
            context['class'] = class_id
            subjects = Subject.objects.filter(grade=class_id.grade)
            context['subjects'] = subjects
            year = class_id.grade
                # print(subjects)
            term = CurrentTerm.objects.filter().first()
            if not term:
                term = Terms.objects.last()
            context['term'] = term
            context['grade'] = year
        except:
            grade = 4
            user = self.request.user
    #          user = models.ForeignKey(Students, on_delete=models.CASCADE)
            # subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
            # term = models.ForeignKey(Terms, on_delete=models.CASCADE)
            # score = models.PositiveIntegerField()
            # # points = models.PositiveIntegerField(max_length=10, default=6)
            # grade = models.CharField(max_length=100)
            # period = models.CharField(max_length=100)
            students = Students.objects.all()
            term = Terms.objects.get(id=1)
            # for gd in range(3):
            #     subjects = Subject.objects.filter(grade=grade)
                
            #     stds = students.filter(academicprofile__current_class__grade=grade)
            #     for std in stds:
            #         for sub in subjects:
            #             Exam.objects.create(user=std, subject=sub,term=term, score=random.randint(27, 100), grade=grade, period='MID')
            #     grade=grade+1

            # # for clas in range(9):
            #     for std in range(30):
            #         class1 = Classes.objects.get(grade=grade, name='Yellow', school=user.school)
            #         try:
            #             st = Students.objects.create(adm_no=random.randint(12345678, 99999999), school=user.school)
            #             acad = AcademicProfile.objects.create(user=st, current_class=class1)
                       
            #         except:
            #             st = Students.objects.create(adm_no=random.randint(12345678, 99999999), school=user.school)
            #             AcademicProfile.objects.create(user=st, current_class=class1)
            #         try:
            #             class2 = Classes.objects.get(grade=grade, name='Red', school=user.school)
            #             st = Students.objects.create(adm_no=random.randint(12345678, 99999999), school=user.school)
            #             AcademicProfile.objects.create(user=st, current_class=class2)
            #         except:
            #             class2 = Classes.objects.get(grade=grade, name='Red', school=user.school)
            #             st = Students.objects.create(adm_no=random.randint(12345678, 99999999), school=user.school)
            #             AcademicProfile.objects.create(user=st, current_class=class2)
                
            #     grade = grade+1

        if self.request.user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        elif self.request.user.role in ['Supervisor']:
            context['base_html'] = 'Supervisor/base.html'
    
        
        
        return context
    
    def post(self, request, **args):
        if request.method == 'POST':
            year = request.POST.get('year')
            term = request.POST.get('term')
            period = request.POST.get('period')
            subjects = Subject.objects.filter(grade=year)
            if self.request.user.role == 'Teacher':
                base_html = 'Teacher/teachers_base.html'
            elif self.request.user.role in ['Supervisor']:
                base_html = 'Supervisor/base.html'

            context = {
                'term':term,
                'grade':year,
                'subjects':subjects,
                'class':self.get_context_data().get('class'),
                'base_html':base_html,
                'period':period
            }


            return render(self.request, self.template_name, context)




class ClassStudentsRanking(LoginRequiredMixin, TemplateView):
    template_name='Supervisor/class_students_ranking.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        class_id = self.kwargs['class_id']
        try:
            context['period'] = 'MID'
            class_instance = Classes.objects.get(class_id=class_id)
            grade = class_instance.grade
            term = 'Term 1'
            stream = self.request.session.get('stream', False)
            if self.request.user.role == 'Teacher':
                context['base_html'] = 'Teacher/teachers_base.html'
            elif self.request.user.role in ['Supervisor']:
                context['base_html'] = 'Supervisor/base.html'
            

            context['class_id'] = class_instance
        
            scores = (
            Exam.objects
            .filter(user__academicprofile__current_class__class_id=class_id, subject__grade=grade, term__term=term)
            .values('user__studentprofile__f_name', 'user__adm_no', 'user__studentprofile__l_name', 'user__studentprofile__surname')  # Group by the user
            .annotate(total_score=Sum('score'))
            .order_by('-total_score', 'user')  # Order by total_score descending, user ascending
                )
            if scores:
                ranked_students = []
                current_rank = 0

                for key, group in groupby(scores, key=lambda student: student['total_score']):
                    score_group = list(group)
                    
                    # Assign the same rank to students with the same score
                    for student in score_group:
                        student['rank'] = current_rank + 1
                    
                    # Skip the following rank
                    current_rank += len(score_group)

                    # Append students to the result list
                    ranked_students.extend(score_group)
                    context['students'] = ranked_students
            # else:
            #     messages.info(self.request, f'{class_instance.class_name} grade {grade} {term} results not found!')
             
                
            subjects = Subject.objects.filter(grade=grade)
            context['subjects'] = subjects
            
            context['term'] = term
            context['grade'] = grade
        except Exception as e:
            messages.error(self.request, str(e))

            
        return context
    
    
    

    def post(self, request, **kwargs):
        if self.request.method == 'POST':
            grade = request.POST.get('year')
            term = request.POST.get('term')
            stream = request.POST.get('stream')
            period = self.request.POST.get('period')
            print(f'stream {stream}')
            user = self.request.user
            current_class = Classes.objects.get(class_id=self.kwargs['class_id'])
            if stream == 'stream':

           
                class_id = Classes.objects.filter(grade=current_class.grade, school=user.school)
                class_id = class_id.values_list('class_id')
                scores = (
                    Exam.objects
                    .filter(Q(user__academicprofile__current_class__class_id__in=class_id), Q(subject__grade=grade), Q(term__term=term), period=period)
                    .values('user__studentprofile__f_name','user__studentprofile__l_name','user__studentprofile__surname', 'user__adm_no', 'user__academicprofile__current_class__name')  # Group by the user
                    .annotate(total_score=Sum('score'))
                    .order_by('-total_score', 'user')  # Order by total_score descending, user ascending
                )
                

                stream  = True
                inclusive = True
            else:

                class_id = current_class
                scores = (
                Exam.objects
                .filter(Q(user__academicprofile__current_class__class_id=class_id.class_id), Q(subject__grade=grade), Q(term__term=term), period=period)
                .values('user__studentprofile__f_name','user__studentprofile__l_name','user__studentprofile__surname', 'user__adm_no', 'user__academicprofile__current_class__name')  # Group by the user
                .annotate(total_score=Sum('score'))
                .order_by('-total_score', 'user')  # Order by total_score descending, user ascending
            )
                stream = None
                inclusive = None
            ranked_students = []
            current_rank = 0

            for key, group in groupby(scores, key=lambda student: student['total_score']):
                score_group = list(group)
                
                # Assign the same rank to students with the same score
                for student in score_group:
                    student['rank'] = current_rank + 1
                
                # Skip the following rank
                current_rank += len(score_group)

                # Append students to the result list
                ranked_students.extend(score_group)
                    
            subjects = Subject.objects.filter(grade=grade)
            context = {
                'subjects':subjects,
                'students': ranked_students,
                'term':term,
                'stream':stream,
                'inclusive':inclusive,
                'schools':self.get_context_data().get('schools'),
                'grade':grade,
                'base_html':self.get_context_data().get('base_html'),
                'class_id':self.get_context_data().get('class_id'),
                
            }
            if not scores:
                messages.error(self.request, 'Results matching query were not found.')
            return render(self.request, self.template_name, context)


        return redirect(request.get_full_path())



def rank(marks_object):
        
    return marks_object

class PrintReport(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/print_card.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        email = self.kwargs['email']
        rank = self.kwargs['rank']
        grade = self.kwargs['grade']
        term = self.kwargs['term']
        results = Exam.objects.filter(user__adm_no=email, subject__grade=grade, term__term=term)
        context['results'] = results
        context['rank'] = rank
        context['student'] = Students.objects.get(adm_no=email)

        return context
    
class ClassSubjectDetail(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/class_subject_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        try:
            class_id = self.kwargs['class_id']
            subject = self.kwargs['subject']
            term = self.kwargs['term']
            context['csubject'] = Subject.objects.get(id=subject)
            class_name = Classes.objects.get(class_id=class_id)
            subs = Topic.objects.filter(subject__id=subject).order_by('order')
            context['topics'] = subs
            # period = self.request.session.get('period', 'MID')
            period = self.kwargs['period']
            try:    
                context['current'] = MyClass.objects.get(subject__id=subject, class_id__class_id=class_id)
                print('yes')
            except:
                print('no')
            context['teachers'] = MyUser.objects.filter(role="Teacher", school=self.request.user.school)
            context['class'] = class_name
            # Get the class and term objects or handle 404 errors
            
            term_instance = Terms.objects.get(id=term)

            
            context['term'] = term_instance

            # Check if exam data exists for the given class, subject, and term
            context['exam'] = MyClass.objects.filter(subject__id=subject).exists()

            # Retrieve the exam scores based on the filters
            scores = Exam.objects.filter(
                user__academicprofile__current_class__class_id=class_id,
                subject__id=subject,
                term__term=term_instance, period=period
            ).order_by('-score')

            context['tests'] = scores
            if not scores:
                messages.info(self.request, f'{class_name.grade} {class_name.name} {term_instance} {period} results not found!')
        except Exception as e:
            # messages.error(self.request, f'We could not find exams matching your query! {str(e)}:{term} ' )
            pass

    # Determine the base HTML depending on user role
        if self.request.user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        elif self.request.user.role in ['Supervisor']:
            context['base_html'] = 'Supervisor/base.html'

        # Handle no scores scenario
        

        return context
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            if 'appoint' in self.request.POST:
                new = self.request.POST.get('new')
                
                current = self.get_context_data().get('current')
                teacher = MyUser.objects.get(id_number=new)

                if current:
                    current.delete()
                class_id = self.kwargs['class_id']
                subject = self.kwargs['subject']
                claas = Classes.objects.get(class_id=class_id)
                subject = Subject.objects.get(id=subject)
                obj = MyClass.objects.create(user=teacher, subject=subject, class_id=claas)
                messages.success(self.request, 'Operation successful!')

                return redirect(self.request.get_full_path())
            else:
                period = self.request.POST.get('period')
                grade = self.request.POST.get('year')
                subject = self.kwargs['subject']
                term = self.request.POST.get('term')
                class_id = self.kwargs['class_id']
                class_instance = self.get_context_data().get('class')

                # Check if the grade does not match the current class grade
                if int(grade) != int(class_instance.grade):
                    current_year = datetime.datetime.now().year
                    selected = current_year - int(grade)
                else:
                    selected = datetime.datetime.now().year

                self.request.session['period'] = period
                try:
                    # Try to get the term based on the selected year
                    term_instance = Terms.objects.get(term=term, year=selected)
                    term = term_instance.id
                except Terms.DoesNotExist:
                    term = 100000

            return redirect('class-subject-detail', class_id=class_id, subject=subject, term=term)


class TestTaskView(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/test_type_select.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context


def parse_quiz(request):
    # Parse data
    session_quiz_data = request.session.get('quiz')
    topic = session_quiz_data['topic']
    sub_topic = session_quiz_data['subtopic']
    quiz = session_quiz_data['quiz']
    session_selection_data = request.session.get('selection_info')
    selection1 = session_selection_data['selection1']
    selection2 = session_selection_data['selection2']
    selection3 = session_selection_data['selection3']
    selection4 = session_selection_data['selection4']
    return sub_topic, topic, quiz, selection1, selection2, selection3, selection4




class ManageClassTeacher(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/class_teacher.html'

    def test_func(self) :
        return self.request.user.role == 'Supervisor'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user
        classes = Classes.objects.filter(school=user.school)
        teachers = MyUser.objects.filter(role='Teacher', school=user.school)
        context['classes'] = classes
        context['teachers'] = teachers

        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            class_id = self.request.POST.get('class')
            teacher = self.request.POST.get('user')
            teacher = MyUser.objects.get(email=teacher)
            class_instance = Classes.objects.get(class_id=class_id)
            class_instance.class_teacher = teacher
            class_instance.save()
            messages.success(self.request, f'{teacher} is now class teacher of {class_instance.name}')

            return redirect(self.request.get_full_path())



class Promote(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/promote.html'

    def test_func(self):
        return self.request.user.role == 'Supervisor'

    def get_context_data(self, **kwargs):

        context = super().get_context_data(**kwargs)
        classes = Classes.objects.all()
        context['classes'] = classes

        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            classes = self.get_context_data().get('classes')
            pwd = self.request.POST.get('pwd')
            email = self.request.user.email
            user = authenticate(self.request, username=email, password=pwd)
            if user:
                if 'promote' in self.request.POST:
                    for class_ins in classes:
                        if class_ins.grade < 9:
                            class_ins.grade = class_ins.grade + 1
                        else:
                            class_ins.status = 'Graduated'
                        class_ins.save()
                    messages.success(self.request, 'You have succesfully promoted all students to the next grade')
            


                elif 'demote' in self.request.POST:
                    for class_ins in classes:
                        if class_ins.grade < 9:
                            class_ins.grade = class_ins.grade - 1
                        else:
                            class_ins.status = 'Active'
                        class_ins.save()
                    messages.success(self.request, 'You have succesfully demmoted all students to their previous grade')
            else:
                messages.error(self.request, 'Invalid password. Please try again or contact @support')


            return redirect(self.request.get_full_path())
        
class MigrateFees(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/migrate_fees.html'

    def get_context_data(self, **kwargs):

        context = super().get_context_data(**kwargs)
        profiles = StudentsFeeAccount.objects.filter(user__is_active=True)
        context['all'] = MyUser.objects.filter(role='Student')
        context['students'] = profiles.count()
        context['balances'] = profiles.aggregate(totals=Sum('balance'))['totals']
        context['grades'] = ['pg','pp1','pp2',1,2,3,4,5,6,7,8,9  ]
        term = CurrentTerm.objects.all().first()
            
       

        return context

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            term = CurrentTerm.objects.all().first()
            grade = self.request.POST.get('grade')
            boarding = self.request.POST.get('boarding')
            gender = self.request.POST.get('gender')
            amount = self.request.POST.get('amount')
            user = self.request.user
            pwd = self.request.POST.get('pwd')
            user = authenticate(username=user.id_number, password=pwd)

            # Check if the authentication was successful
            if user is not None:
                try:
                    migration = FeeMigrations.objects.get(school=user.school,term=term.term, grade=grade, boarding=boarding, gender__in=[gender,"all"])
                    boarding = 'Boarders' if boarding == 1 else 'Dayscholars'

                    messages.error(self.request, f'Migrations for grade {grade},  {term},  {boarding}, gender : {gender} already done !!')
                except :
                    migration = FeeMigrations.objects.create(school=user.school,amount=amount,term=term.term, grade=grade, boarding=boarding, gender=gender)
                    if 'migrate' in self.request.POST:
                        if gender == "all":
                            fee_profiles = StudentsFeeAccount.objects.filter(user__is_active=True, user__school=user.school, user__academicprofile__current_class__grade=grade, user__studentprofile__is_boarder=boarding)
                        else:
                        
                            fee_profiles = StudentsFeeAccount.objects.filter(user__is_active=True, user__school=user.school, user__academicprofile__current_class__grade=grade, user__studentprofile__is_boarder=boarding, gender__icontains=gender)

                        fee_profiles.update(balance=F('balance') + (int(amount)*-1))
                        adms = fee_profiles.values_list('user__adm_no')
                        affected = Students.objects.filter(adm_no__in=adms )

                        migration.affected.add(*affected)
                        messages.success(self.request, '100 "%" fee migration')
            else:
                messages.error(self.request, 'Invalid password!')
            return redirect(self.request.get_full_path())

    def test_func(self):
        return self.request.user.role == 'Supervisor'
    
class Rollback(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/rollback.html'

    def get_context_data(self, **kwargs):

        context = super().get_context_data(**kwargs)
        id = self.kwargs['id']
        context['migration'] = FeeMigrations.objects.get(id=id)

        return context

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            lists = self.get_context_data().get('migration')
            profiles = StudentsFeeAccount.objects.filter(user__in=lists.affected.all())
            with transaction.atomic():  # Ensure the update happens in a transaction
                updated_count = profiles.update(balance=F('balance') + int(lists.amount))  # Update balance
            print(profiles.count(), (lists.amount))
            lists.delete()
            messages.success(self.request, 'Rollback was a success ')
            return redirect('migrate-fees')

    def test_func(self):
        return self.request.user.role == 'Supervisor'


class CreateNotice(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/create_notice.html'

    def test_func(self):
        return self.request.user.role == 'Supervisor'

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            
            title = self.request.POST.get('title')
            description = self.request.POST.get('description')
            pdf = self.request.FILES.get('pdf')
            if pdf:
                update = Updates.objects.create(title=title, description=description, file=pdf, school=self.request.user.school, ministry='School', created_by=self.request.user)
            else:
                update = Updates.objects.create(title=title, description=description, school=self.request.user.school, ministry='School', created_by=self.request.user)

            return redirect('notice-id', update.id)
        

class Notices(TemplateView):
    template_name = 'Supervisor/notices.html'

    def get_context_data(self, **kwargs):

        context = super().get_context_data(**kwargs)
        context['updates'] = Updates.objects.all().order_by('-date')

        if self.request.user.role == 'Student':
            # get the current logged in user(learner) current grade and associated Subjects
            context['base_html'] = 'Users/base.html'
        elif self.request.user.role == 'Guardian':
            context['base_html'] = 'Guardian/baseg.html'
        elif self.request.user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        elif self.request.user.role in ['Supervisor', 'Finance','Receptionist']:
            context['base_html'] = 'Supervisor/base.html'

        return context

class NoticeID(TemplateView):
    template_name = 'Supervisor/notice_id.html'

    def get_context_data(self, **kwargs):

        context = super().get_context_data(**kwargs)
        notice_id = self.kwargs['notice_id']
        context['notice'] = Updates.objects.get(id=notice_id)


        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            if 'delete' in self.request.POST:
                command = self.request.POST.get('command')
                if command == 'delete':
                    update = self.get_context_data().get('notice')
                    update.delete()
                    messages.error(self.request, 'You have succesfully deleted a notice update')

                    return redirect('notices')
                else:
                    messages.error(self.request, 'Invalid Command !')

                    return redirect(self.request.get_full_path())
            else:

            
                title = self.request.POST.get('title')
                description = self.request.POST.get('description')
                pdf = self.request.FILES.get('pdf')

                update = self.get_context_data().get('notice')
                update.title = title
                update.description = description
                update.file = pdf
                update.save()
                messages.success(self.request, 'Update was succesfull.')

                return redirect(self.request.get_full_path())
            

class AddActivity(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/create_activity.html'

    def test_func(self):
        return self.request.user.role == 'Teacher'

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            title = self.request.POST.get('title')
            description = self.request.POST.get('description')
            self.request.session['activity'] = {
            'title': title,
            'description': description,
        }



            return redirect('add-students')


    

class AddStudents(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/add_students.html'

    def get_context_data(self, **kwargs):

        context = super().get_context_data(**kwargs)
        context['users'] = MyUser.objects.filter(role='Student')
        context['classes'] = StudentList.objects.filter(user=self.request.user)
        students = MyUser.objects.filter(id__in=self.request.session.get('students', []))
        if students:
            context['students'] = students

        
            

        
        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            class_id = self.request.POST.get('class')
            search = self.request.POST.get('search')
            if 'add' in self.request.POST:
                students = self.request.POST.getlist('user')
                existing_students = set(self.request.session.get('students', []))
    
    # Filter out duplicate values
                new_students = list(set(students) - existing_students)
                
                # Append new values to the existing list
                updated_students = existing_students.union(new_students)
                
                # Update the session key with the combined list
                self.request.session['students'] = list(updated_students)
                context = {'users':self.get_context_data().get('users'),
                           'classes':self.get_context_data().get('classes'),
                           'students':MyUser.objects.filter(id__in=self.request.session.get('students', []))
                           
                           }
                # context['students'] = self.request.session.get('students',None)
                
                return render(self.request, self.template_name, context)
            elif 'delete' in self.request.POST:
                id_to_delete = self.request.POST.get('delete')
                if id_to_delete in self.request.session['students']:
            # Remove the id_to_delete from the list
                    self.request.session['students'].remove(id_to_delete)
                    self.request.session.modified = True 
                    context = {'users':self.get_context_data().get('users'),
                           'classes':self.get_context_data().get('classes'),
                           'students':MyUser.objects.filter(id__in=self.request.session.get('students', []))
                           
                           }

                    return render(self.request, self.template_name, context)
                else:
                    return redirect(self.request.get_full_path())

            else:
                if class_id:
                    users = MyUser.objects.filter(academicprofile__current_class__class_id=class_id)

                    context = {
                        'users':users,
                        'classes':self.get_context_data().get('classes'),
                        'students':self.get_context_data().get('students'),
                    }

                    return render(self.request, self.template_name, context)

                if search:
                    users = MyUser.objects.filter(Q(personalprofile__f_name__contains=search) | Q(personalprofile__l_name__contains=search)
                                                        | Q(personalprofile__surname__contains=search) | Q(email__contains=search) )
                    context = {'users':users,
                            'classes':self.get_context_data().get('classes'),
                            }
                    return render(self.request, self.template_name, context)
                
                else:
                    return redirect(self.request.get_full_path())


class AddFiles(TemplateView):
    template_name = 'Supervisor/add_files.html'

    def get_context_data(self, **kwargs):

        context = super().get_context_data(**kwargs)
        context['students'] = MyUser.objects.filter(id__in=self.request.session.get('students', []))
        context['activity'] = self.request.session.get('activity', [])

        if self.request.user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        elif self.request.user.role == 'Supervisor':
            context['base_html'] = 'Supervisor/base.html'


        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            uploaded_files = self.request.FILES.getlist('files')
            title = self.get_context_data().get('activity')
            description = self.get_context_data().get('activity')
            students = self.get_context_data().get('students')

            activity = ExtraCurricular.objects.create(
                user=self.request.user,
                title = title['title'],
                description = description['description']
            )
            activity.students.add(*students)

            # Save each file to the database and associate it with the activity
            for file in uploaded_files:
                file_instance = FileModel.objects.create(file=file)
                
                activity.files.add(file_instance)

            return redirect('view-activity', activity.id)



class ViewActivities(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/view_activities.html'

    def get_context_data(self, **kwargs):
        role = self.request.user.role
        context = super().get_context_data(**kwargs)
        if role == 'Teacher':
            context['template'] = 'Teacher/teachers_base.html'
        else:
            context['template'] = 'Supervisor/base.html'

        
        context['activities'] = ExtraCurricular.objects.all().order_by('-date')

        return context
    
class ViewActivity(LoginRequiredMixin, TemplateView):
    template_name = 'Supervisor/view_activity.html'

    def get_context_data(self, **kwargs):

        context = super().get_context_data(**kwargs)
        activity_id = self.kwargs['activity_id']
        activity = ExtraCurricular.objects.get(id=activity_id)
        context['activity'] = activity
        if self.request.user.role == 'Teacher':
            context['base_html'] = 'Teacher/teachers_base.html'
        elif self.request.user.role == 'Supervisor':
            context['base_html'] = 'Supervisor/base.html'
        elif self.request.user.role == 'Guardian':
            context['base_html'] = 'Guardian/baseg.html'
        elif self.request.user.role == 'Student':
            context['base_html'] = 'Users/base.html'
        



        return context

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            command = self.request.POST.get('option').lower()
            if command == 'delete':
                activity = self.get_context_data().get('activity')
                activity.delete()

                return redirect('activities')
            messages.error(self.request, 'Invalid Command')
            
            return redirect(self.request.get_full_path())
        
class ExamModes(LoginRequiredMixin, UserPassesTestMixin, TemplateView):
    template_name = 'Supervisor/enable_exam_mode.html'

    def test_func(self):
        return self.request.user.role == 'Supervisor'

    def get_context_data(self, **kwargs):

        context = super().get_context_data(**kwargs)
        mode = ExamMode.objects.filter(school=self.request.user.school).first()
        if not mode:
            mode =ExamMode.objects.create(school=self.request.user.school)
        context['mode'] = mode

        return context
    
    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            command = self.request.POST.get('action')
            mode = self.get_context_data().get('mode')
            if command == 'enable':
                period = self.request.POST.get('period')
                inp = True
                mode.status = inp
                mode.period = period
                mode.save()
            else:
                inp = False
                mode.status = inp
                mode.save()

            



            return redirect(self.request.get_full_path())
        
class AssignmentsView(TemplateView):
    template_name = 'Supervisor/assignments.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        assignments = ClassTest.objects.all().order_by('-date')
        context['assignments'] = assignments
        context['users'] = MyUser.objects.filter(role='Teacher')
        context['subjects'] = Course.objects.all()

        return context

    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            grade = self.request.POST.get('grade')
            subject = self.request.POST.get('subject')
            user = self.request.POST.get('user')
            start = self.request.POST.get('from')
            to = self.request.POST.get('to')
            status = self.request.POST.get('status')
            search = {}
            if grade:
                search['subject__grade'] = grade
            if subject:
                search['subject__course'] = subject
            if user:
                search['teacher'] = user
            if start:
                search['date__gte'] = start
            if to:
                search['date__lte'] = to
            if status:
                if status == 'active':
                    search['expiry__gt'] = datetime.datetime.now()
                else:
                    search['expiry__lt'] = datetime.datetime.now()
            tests = ClassTest.objects.filter(**search)
            context = {
                'assignments':tests,
                'users':self.get_context_data().get('users'),
                'subjects': self.get_context_data().get('subjects'),
            }
            return render(self.request, self.template_name, context)
        

class TopicReview(TemplateView):
    template_name = 'Supervisor/review.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        subject = self.kwargs['subject']
        topics = Topic.objects.filter(subject__id=subject)
        context['topics'] = topics
        print(topics)

        return context


    def post(self, *args, **kwargs):
        if self.request.method == 'POST':
            topic = self.request.POST.get('topic')
            quizes = TopicalQuizes.objects.filter(topic__id=topic)

            context = {
                'quizes':quizes.values('subtopic__name').aggregate(sm=Count('subtopic__name')),
                'topics':self.get_context_data().get('topics'),
                'filters':True,
                'subtopics':Subtopic.objects.filter(topic__id=topic)

            }

            return render(self.request, self.template_name, context)