import itertools
# courses = Course.objects.using('default2').all()
        # for course in courses:
        #     cs = Course.objects.create(name=course.name, discipline=course.discipline, abbreviation=course.abbreviation)
# def add_quiz():
#     quizes = TopicalQuizes.objects.using('default2').all()

#     for quiz in quizes:
#         answers = TopicalQuizAnswers.objects.using('default2').filter(quiz=quiz)
#         # subject = Subject.objects.get(name=quiz.subject, grade=quiz.subject.grade)
#         subtopic = Subtopic.objects.get(name=quiz.subtopic.name, subject__grade=quiz.subject.grade)
#         quiz = TopicalQuizes.objects.create(id=quiz.id, subject=subtopic.subject, subtopic=subtopic, topic=subtopic.topic, quiz=quiz.quiz)
#         for answer in answers:
#             answe = TopicalQuizAnswers.objects.create(uuid=answer.uuid, quiz=quiz, choice=answer.choice, is_correct=answer.is_correct)
# subjects = Subject.objects.all()
#         topics = Topic.objects.using('default2').all()
#         subtopics = Subtopic.objects.using('default2').all()
        # for topic in topics:
        #     subject = subjects.get(name=topic.subject.name, grade=topic.subject.grade)
        #     sub = Topic.objects.create(id=topic.id, subject=subject, name=topic.name, order=topic.order, topics_count=topic.topics_count, test_size=topic.test_size, time=topic.time)
        # for subtopic in subtopics:
        #     topic = Topic.objects.get(id=subtopic.topic.id)
        #     subject = Subject.objects.get(name=subtopic.subject.name, grade=subtopic.subject.grade)
        #     su = Subtopic.objects.create(name=subtopic.name, subject=subject, topic=topic, id=subtopic.id, order=subtopic.order)
def create_topics_and_subtopics(course, subject, topics_data):
        course = Course.objects.get(name="Agriculture")
        subject_name = "Christian Religious Education"
        grade = "7"
        abbr = 'CRE'
        
        # Ensure the subject exists
        
        
        # Topics and subtopics extracted from the document
        topics_data = {
    "Introduction to Christian Religious Education": [
        "Importance of Studying Christian Religious Education"
    ],
    "Creation": [
        "Accounts of Creation",
        "Stewardship over Creation",
        "Responsibility over Plants",
        "Use of Natural Resources"
    ],
    "The Bible": [
        "Functions of the Bible",
        "Divisions of the Bible",
        "Bible Translations",
        "Leadership in Israel: Moses"
    ],
    "The Early Life of Jesus Christ": [
        "Prophecies about the Messiah",
        "The Birth and Childhood of Jesus Christ"
    ],
    "The Church": [
        "Selected Forms of Worship",
        "Role of the Church in Education and Health"
    ],
    "Christian Living Today": [
        "Human Sexuality",
        "Christian Marriage and Family",
        "Alcohol, Drugs and Substance Abuse",
        "Gambling",
        "Social Media"
    ]
}


        
        subject = Subject.objects.create(name=subject_name, grade=grade, course=course, order=1, topics=len(topics_data), abbreviation=abbr)
        orderz = 1
        for topic_name, subtopics in topics_data.items():
            topic, _ = Topic.objects.get_or_create(
                name=topic_name, subject=subject, defaults={"order": orderz, "topics_count": len(subtopics), "test_size": 10, "time": 30}
            )
            orderz = orderz+1
            for order, subtopic_name in enumerate(subtopics, start=1):
                Subtopic.objects.get_or_create(
                    subject=subject, topic=topic, name=subtopic_name,
                    defaults={"id": uuid.uuid4(), "file1": "studyFiles/file.pdf", "file2": "studyFiles/start.mp4", "order": str(order)}
                )

                
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
