import requests


def get_token():
#     kenyan_male_english_names = [
#     "James", "John", "Peter", "David", "Michael", "Samuel", "Daniel", "Charles", "Joseph", "Mark",
#     "Brian", "Andrew", "Robert", "Richard", "Thomas", "Edward", "Frank", "George", "Benjamin", "Patrick",
#     "William", "Steven", "Simon", "Alex", "Jason", "George", "Paul", "Henry", "Kenneth", "Douglas",
#     "Victor", "Martin", "Jason", "Clifford", "Brian", "Emmanuel", "Arthur", "Ian", "Samuel", "Terry", 
#     "Simon", "Joshua", "Kennedy", "Elvis", "Reginald", "Oscar", "Caleb", "Francis", "Chris", "Timothy",
#     "Norman", "Luke", "Roy", "Philip", "Bernard", "Gilbert", "Maxwell", "Joseph", "Dennis", "Leonard",
#     "Louis", "Dominic", "Allan", "Morgan", "Ruben", "Zachary", "Solomon", "Chester", "Henry", "Oscar",
#     "Christopher", "Stanley", "Luther", "Felix", "Harold", "Ralph", "Jack", "Clement", "Graham", "Raymond",
#     "Sidney", "Wayne", "Alfred", "Julian", "Victor", "Jeremiah", "Abraham", "Harry", "Nathaniel", "Douglas",
#     "Russell", "Bernie", "Leon", "Ronald", "Walter", "Roger", "Everett", "Calvin", "Leonard", "Adam",
#     "Moses", "Ken", "Lawrence", "Elliot", "Eugene", "Marty", "Leroy", "Gordon", "Herman", "Samuel"
# ]

# # 2. Kenyan Male Traditional/Tribal Names
#         kenyan_male_tribal_names = [
#         "Baraka", "Chumo", "Gikonyo", "Nyambura", "Kamau", "Mutuma", "Wairimu", "Ochieng", "Otieno", "Achieng",
#         "Ndegwa", "Mwangi", "Karanja", "Mutinda", "Mugo", "Wambui", "Njiru", "Kibet", "Biko", "Njoroge",
#         "Odhiambo", "Kipkorir", "Cheruiyot", "Kiplagat", "Linet", "Mumbi", "Mwiti", "Kivumbi", "Ndiritu",
#         "Tumo", "Kungu", "Gatimu", "Kato", "Mwendwa", "Gichuki", "Kimani", "Makori", "Ruto", "Maina",
#         "Gathuku", "Muthui", "Kariuki", "Wachira", "Waweru", "Mburu", "Ngugi", "Kimutai", "Kimutai",
#         "Gichuru", "Murage", "Mutheki", "Mwaura", "Kambura", "Njiru", "Kamau", "Kegode", "Kipkemboi", 
#         "Sang", "Gichina", "Okoth", "Angu", "Hassan", "Kariuki", "Kimuyu", "Barongo", "Kitili", "Murimi", 
#         "Mwaniki", "Omondi", "Ndege", "Mose", "Nyakundi", "Kiptanui", "Miriam", "Kiseu", "Kitheka", "Kilel",
#         "Mumbi", "Ndung'u", "Kimweru", "Baratou", "Juma", "Makau", "Wanjiru", "Gatonga", "Sihanya", "Njiru",
#         "Ngacha", "Barasa", "Juma", "Lusweti", "Serem", "Eldoret", "Kapchanga", "Mutai", "Karanja", "Mithamo"
#     ]

#     # 3. Kenyan Female English Names
#         kenyan_female_english_names = [
#         "Mary", "Sarah", "Jane", "Elizabeth", "Lucy", "Anne", "Grace", "Ruth", "Patricia", "Deborah", 
#         "Catherine", "Rebecca", "Jennifer", "Margaret", "Susan", "Hannah", "Caroline", "Rachel", "Eunice", 
#         "Alice", "Angela", "Linda", "Naomi", "Betty", "Vivian", "Rosalind", "Emily", "Irene", "Sandra", 
#         "Gloria", "Dorothy", "Barbara", "Sarah", "Esther", "Lillian", "Sharon", "Martha", "Julia", "Vera", 
#         "Clara", "Monica", "Selina", "Stephanie", "Patricia", "Louise", "Winnie", "Cheryl", "Cynthia", "Joan",
#         "Evelyn", "Carla", "Michelle", "Lily", "Jessica", "Pamela", "Diana", "Beatrice", "Nelly", "Maureen", 
#         "Hazel", "Theresa", "Fiona", "Katherine", "Sophie", "Christine", "Grace", "Florence", "Sylvia", 
#         "Vivian", "Doreen", "Gertrude", "Sally", "Emily", "Helen", "Sheryl", "Olivia", "Yvonne", "Michele", 
#         "Tina", "Judy", "Linda", "Tanya", "Kirsten", "Felicity", "Megan", "Melanie", "Janet", "Stephanie", 
#         "Leah", "Gail", "Natalie", "Monique", "Tanya", "Barbara", "Veronica", "Charlotte", "Sally", "Joanna",
#         "Isabel", "Maggie", "Victoria", "Tracy", "Geraldine", "Liza", "Anita", "Lorna", "Emma"
#     ]

#     # 4. Kenyan Female Traditional Names
#         kenyan_female_tribal_names = [
#     "Nyambura", "Wambui", "Akinyi", "Omondi", "Muthoni", "Njeri", "Akoth", "Kemunto", "Imani", "Achieng",
#     "Kendi", "Gikonyo", "Kariuki", "Kendi", "Nabwire", "Nyang'au", "Muthui", "Wangui", "Mumbi", "Nabirye",
#     "Njoki", "Miriam", "Ndeke", "Kendi", "Murugi", "Nduku", "Chebet", "Nduku", "Munira", "Gathoni", 
#     "Kendi", "Wangechi", "Chania", "Ochieng", "Kendi", "Asiimwe", "Mugure", "Chege", "Muthama", "Aserio",
#     "Murage", "Nyawira", "Mutheu", "Ngina", "Muna", "Wambui", "Gikonyo", "Njeri", "Oluoch", "Odera", 
#     "Kamau", "Akello", "Anyango", "Oluoch", "Akinyi", "Chumah", "Wairimu", "Nyakundi", "Wangui", "Eunice",
#     "Owino", "Mbula", "Akinyi", "Wangari", "Kamuya", "Mumbi", "Kasule", "Ochieng", "Wambua", "Naisula",
#     "Githinji", "Kariuki", "Koki", "Mwenesi", "Kibaru", "Njeri", "Sihanya", "Kina", "Nyawira", "Mboha",
#     "Maruge", "Mwangi", "Shiro", "Kendi", "Nduati", "Ndung'u", "Gathoni", "Mau", "Chavuma", "Kamara",
#     "Njuguna", "Auma", "Munira", "Kisilu", "Kisia", "Wairimu", "Kahaki", "Muthiora", "Kamara", "Munene"
# ]

#         students = Students.objects.all()
#         combined = kenyan_male_tribal_names + kenyan_female_tribal_names[0:10]
#         for grade in range(9):
#             graded = Students.objects.filter(academicprofile__current_class__grade=grade+1)
#             rand_pc = random.randint(45, 55)
#             pc = round((graded.count()*rand_pc)/100)
#             excluded = graded[:pc].values_list('id')
#             for st in graded[:pc]:
#                 profile = StudentProfile.objects.create(user=st,gender='Male', f_name=random.choice(kenyan_male_english_names), l_name=random.choice(kenyan_male_tribal_names), surname=random.choice(combined))
#             for stu in graded.exclude(id__in=excluded):
#                 profile = StudentProfile.objects.create(user=stu,gender='Female', f_name=random.choice(kenyan_female_english_names), l_name=random.choice(kenyan_female_tribal_names), surname=random.choice(combined))
    
# Replace 'your_api_key_here', 'your_merchant_code_here', and 'your_consumer_secret_here' with actual values
    api_key = '94g4l74GEt4qgDSWGdMw+jxGQnwO8v6gYyTNOslM7LQ0mGQUyRtlGE6O8O2AajeFrd6KSVR32fRRMFoYZYpkIQ=='
    merchant_code = '9401576880'
    consumer_secret = 'h907DIcM26cQUh3z2c7OxzgHKO98rT'

    # Define the endpoint URLs for test and live environments
    test_url = 'https://uat.finserve.africa/authentication/api/v3/authenticate/merchant'
    live_url = 'https://api.finserve.africa/authentication/api/v3/authenticate/merchant'

    # Define the headers required for the request
    headers = {
        'Content-Type': 'application/json',
        'Api-Key': api_key
    }

    # Define the request body containing merchantCode and consumerSecret
    data = {
        'merchantCode': merchant_code,
        'consumerSecret': consumer_secret
    }

    try:
        # Make the HTTP POST request to the authentication endpoint
        response = requests.post(test_url, headers=headers, json=data)

        # Check if the request was successful (status code 200)
        if response.status_code == 200:
            # Parse the JSON response to extract the access token
            token_data = response.json()
            access_token = token_data['accessToken']
            
            return access_token
        else:
            print(f"Error: {response.status_code} - {response.text}")
    except Exception as e:
        print(f"An error occurred: {e}")
# get_token()
# Replace 'your_api_key_here' and 'your_transaction_reference_here' with actual values
def get_transaction():
    api_key = '94g4l74GEt4qgDSWGdMw+jxGQnwO8v6gYyTNOslM7LQ0mGQUyRtlGE6O8O2AajeFrd6KSVR32fRRMFoYZYpkIQ=='
    transaction_reference = '10120120098767'

    endpoint = f'https://uat.finserve.africa/v3-apis/transaction-api/v3.0/transactions/details/{transaction_reference}'
    token = get_token()
    # print(token)
    
    headers = {
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    }

    try:
        response = requests.get(endpoint, headers=headers)
        if response.status_code == 200:
            transaction_details = response.json()
            print(transaction_details)
        else:
            print(f"Error: {response.status_code} - {response.text}")
    except Exception as e:
        print(f"An error occurred: {e}")

get_transaction()