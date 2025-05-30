import uuid

from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType
from django.db import models
from SubjectList.models import Topic, Subject, Subtopic
# from Supervisor.models import KnecQuizzes, KnecQuizAnswers

from Teacher.models import MyClass
from Users.models import Classes, MyUser, Students


class TopicalQuizes(models.Model):
    id = models.UUIDField(default=uuid.uuid4, primary_key=True)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    file = models.FileField(null=True, upload_to='question_files/')
    subtopic = models.ForeignKey(Subtopic, on_delete=models.CASCADE)
    topic = models.ForeignKey(Topic, on_delete=models.CASCADE)
    quiz = models.TextField(max_length=500)
    # is_approved = models.BooleanField(default=False)

    def __str__(self):
        return str(self.id)
    
    # class Meta:
    #     db_table = 'exams_topicalquizes'  # Custom table name
    #     managed = False


class TopicalQuizAnswers(models.Model):
    uuid = models.UUIDField(default=uuid.uuid4, unique=True)
    quiz = models.ForeignKey(TopicalQuizes, on_delete=models.CASCADE)
    choice = models.CharField(max_length=600)
    is_correct = models.BooleanField(default=False)

    # class Meta:
    #     db_table = 'exams_topicalquizanswers'  # Custom table name
    #     managed = False

    def __str__(self):
        return str(self.id)




class Explanation(models.Model):
    quiz = models.ForeignKey(TopicalQuizes, on_delete=models.CASCADE)
    explanation = models.TextField(max_length=10000)

    def __str__(self):
        return str(self.quiz)

class UniqueUUIDField(models.UUIDField):
    def __init__(self, *args, **kwargs):
        kwargs.setdefault('default', uuid.uuid4)
        kwargs.setdefault('unique', True)
        super().__init__(*args, **kwargs)


class BaseTest(models.Model):
    type_choices = (
        ('Topical', 'Topical'),
        ('General', 'General'),
        ('Retake', 'Retake'),
        ('KNEC', 'KNEC')
    )
    user = models.ForeignKey(Students, on_delete=models.CASCADE)
    uuid = UniqueUUIDField()
    date = models.DateTimeField(auto_now=True)
    marks = models.IntegerField(default=0)
    exam_type = models.CharField(max_length=10, default='Topical', choices=type_choices)
    test_size = models.PositiveIntegerField(default=15)
    duration = models.PositiveIntegerField(default=15)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    quiz = models.ManyToManyField(TopicalQuizes)

    class Meta:
        # db_table = 'exams_basetest'  # Custom table name
        # managed = False
        abstract=True


class StudentTest(BaseTest):
    topic = models.ForeignKey(Topic, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.user)
    
    # class Meta:
    #     db_table = 'exams_studenttest'  # Custom table name
    #     managed = False


def generate_uuid():
    return uuid.uuid4()


class GeneralTest(BaseTest):
    is_done = models.BooleanField(default=False)


    def __str__(self):
        return str(self.user)
    
    # class Meta:
    #     db_table = 'exams_generaltest'  # Custom table name
    #     managed = False





class BaseGroupTest(models.Model):
    uuid = UniqueUUIDField(primary_key=True)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    test_size = models.PositiveIntegerField()
    duration = models.PositiveIntegerField(default='15')
    date = models.DateTimeField()
    teacher = models.ForeignKey(MyUser, on_delete=models.CASCADE)
    expiry = models.DateField(null=True)

    class Meta:
        # db_table = 'exams_basegrouptest'  # Custom table name
        # managed = False
        abstract=True


# class KNECGradeExams(BaseGroupTest):
#     grade = models.CharField(max_length=2)
#     term = models.CharField(max_length=100, default='2')
#     year = models.CharField(max_length=6, default='2023')
#     quiz = models.ManyToManyField(KnecQuizzes)


#     def __str__(self):
#         return str(self.uuid)
 

# class StudentKNECExams(BaseTest):
#     user = models.ForeignKey(MyUser, on_delete=models.CASCADE)
#     test = models.ForeignKey(KNECGradeExams, on_delete=models.CASCADE)
#     uuid = models.CharField(max_length=100, default=uuid.uuid4)
#     date = models.DateTimeField(auto_now=True)
#     marks = models.CharField(max_length=100, default='0')
#     finished = models.BooleanField(default=False)

#     def __str__(self):
#         return str(self.user)

#     class Meta:
#         unique_together = ('user', 'uuid')





class ClassTest(BaseGroupTest):
    # MultipleObjectsReturned = None
    class_id = models.ForeignKey(Classes,  on_delete=models.CASCADE)
    quiz = models.ManyToManyField(TopicalQuizes)


    def __str__(self):
        return str(self.uuid)
    
    # class Meta:
    #     db_table = 'exams_classtest'  # Custom table name
    #     managed = False


class ClassTestStudentTest(models.Model):
    user = models.ForeignKey(Students, on_delete=models.CASCADE)
    test = models.ForeignKey(ClassTest, on_delete=models.CASCADE)
    uuid = models.CharField(max_length=100, default=uuid.uuid4)
    date = models.DateTimeField(auto_now=True)
    marks = models.IntegerField(default=0)
    is_done = models.BooleanField(default=False)
    finished = models.BooleanField()

    def __str__(self):
        return str(self.user)

    class Meta:
        unique_together = ('user', 'uuid')
        db_table = 'exams_classteststudenttest'  # Custom table name
        # managed = False


class StudentsAnswers(models.Model):
    user = models.ForeignKey(Students, on_delete=models.CASCADE)
    uuid = models.UUIDField(default=uuid.uuid4)
    quiz = models.ForeignKey(TopicalQuizes, on_delete=models.CASCADE)
    selection = models.ForeignKey(TopicalQuizAnswers, on_delete=models.CASCADE)
    test_content_type = models.ForeignKey(ContentType, on_delete=models.SET_NULL, null=True)
    test_object_id = models.UUIDField()  # Use editable=False
    test = GenericForeignKey('test_content_type', 'test_object_id')
    is_correct = models.BooleanField(default=False)

    def __str__(self):
        return str(self.quiz)

    class Meta:
        unique_together = ('user', 'uuid')
        # db_table = 'exams_studentsanswers'  # Custom table name
        # managed = False


# class StudentsKnecAnswers(models.Model):
#     user = models.ForeignKey(MyUser, on_delete=models.CASCADE)
#     uuid = models.UUIDField(default=uuid.uuid4)
#     quiz = models.ForeignKey(KnecQuizzes, on_delete=models.CASCADE)
#     selection = models.ForeignKey(KnecQuizAnswers, on_delete=models.CASCADE)

#     test = models.ForeignKey(StudentKNECExams, on_delete=models.CASCADE)
#     is_correct = models.BooleanField(default=False)

#     def __str__(self):
#         return str(self.user)

#     class Meta:
#         managed = False