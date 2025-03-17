import random
from collections import defaultdict

# Define constraints
DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
TIME_SLOTS = ["8:00-9:00", "9:00-9:20", "9:35-10:20", "10:20-11:00", "11:30-12:15", "12:15-1:00", "2:00-2:45", "2:45-3:30"]
BREAKS = {"9:20-9:35": "Break", "11:00-11:30": "Long Break", "1:00-2:00": "Lunch"}
SUBJECTS = ["Math", "Science", "Pre-Technical", "CRE", "Agriculture", "English", "Kiswahili", "Social Studies", "Computer", "Art"]
GRADES = ["Grade 7", "Grade 8", "Grade 9"]
TEACHERS = [f"Teacher {i+1}" for i in range(10)]

# Ensure Math and English appear daily, others max 4 times
subject_limits = {subject: 4 for subject in SUBJECTS}
subject_limits["Math"] = 5
subject_limits["English"] = 5

# Assign random teachers to subjects
subject_teachers = {subject: random.choice(TEACHERS) for subject in SUBJECTS}

def generate_timetable():
    timetable = {grade: {day: [] for day in DAYS} for grade in GRADES}
    subject_count = {grade: defaultdict(int) for grade in GRADES}
    
    for grade in GRADES:
        for day in DAYS:
            slots_filled = 0
            for slot in TIME_SLOTS:
                if slots_filled >= 8:
                    break
                
                # Handle breaks
                if slot in BREAKS:
                    timetable[grade][day].append((slot, BREAKS[slot], ""))
                    continue
                
                # Ensure Math appears before 11:00 AM
                if slot in ["8:00-9:00", "9:00-9:20", "9:35-10:20", "10:20-11:00"] and subject_count[grade]["Math"] < 5:
                    subject = "Math"
                else:
                    subject = random.choice([s for s in SUBJECTS if subject_count[grade][s] < subject_limits[s]])
                
                subject_count[grade][subject] += 1
                teacher = subject_teachers[subject]
                timetable[grade][day].append((slot, subject, teacher))
                slots_filled += 1
    
    return timetable

def print_timetable(timetable):
    for grade, schedule in timetable.items():
        print(f"\nTimetable for {grade}:")
        for day, lessons in schedule.items():
            print(f"\n{day}")
            for slot, subject, teacher in lessons:
                print(f"{slot}: {subject} ({teacher})")

timetable = generate_timetable()
print_timetable(timetable)