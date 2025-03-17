import itertools
# def add_quiz():
#     quizes = TopicalQuizes.objects.using('default2').all()

#     for quiz in quizes:
#         answers = TopicalQuizAnswers.objects.using('default2').filter(quiz=quiz)
#         # subject = Subject.objects.get(name=quiz.subject, grade=quiz.subject.grade)
#         subtopic = Subtopic.objects.get(name=quiz.subtopic.name, subject__grade=quiz.subject.grade)
#         quiz = TopicalQuizes.objects.create(id=quiz.id, subject=subtopic.subject, subtopic=subtopic, topic=subtopic.topic,quiz=quiz)
#         for answer in answers:
#             answe = TopicalQuizAnswers.objects.create(uuid=answer.uuid, quiz=quiz, choice=answer.choice, is_correct=answer.is_correct)

def add_subject():
    subjects = Subject.objects.all()
    courses = Course.objects.all()
    for course in courses:
        cs = Course.objects.using('default2').create(name=course.name, discipline=course.discipline, abbreviation=course.abbreviation)
    for subject in subjects:
        sub = Subject.objects.using('default2').create() 

def generate_timetable(teachers, classes, time_slots):
    timetable = {}

    for time_slot in time_slots:
        timetable[time_slot] = {}

        # Use itertools.cycle to cycle through teachers in a round-robin fashion
        teacher_cycle = itertools.cycle(teachers)

        for _class in classes:
            teacher = next(teacher_cycle)
            timetable[time_slot][_class] = teacher

    return timetable

def print_timetable(timetable):
    for time_slot, class_assignments in timetable.items():
        print(f"\nTime Slot: {time_slot}")
        for _class, teacher in class_assignments.items():
            print(f"Class {_class}: Teacher {teacher}")

if __name__ == "__main__":
    # Example data
    teachers = ["Teacher1", "Teacher2", "Teacher3", "Teacher4", "Teacher5"]
    classes = range(1, 11)
    time_slots = ["9:00 AM", "10:00 AM", "11:00 AM", "1:00 PM", "2:00 PM"]

    # Generate timetable
    timetable = generate_timetable(teachers, classes, time_slots)

    # Print the generated timetable
    print_timetable(timetable)
