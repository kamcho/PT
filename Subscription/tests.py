import base64
from datetime import datetime, timedelta
from requests.auth import HTTPBasicAuth
from django.utils import timezone
import requests

# from Subscription.models import MySubscription, Subscriptions


def generate_access_token():
    access_token_url = 'https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'
    consumer_key = "aSG8gGG7GWSGapToKz8ySyALUx9zIdbBr1CHldVhyOLjJsCz"
    consumer_secret = "o8qwdbzapgcvOd1lsBOkKGCL4JwMQyG9ZmKlKC7uaLIc4FsRJFbzfV10EAoL0P6u"

    # make a get request using python requests liblary
    response = requests.get(access_token_url, auth=HTTPBasicAuth(consumer_key, consumer_secret))

    # return access_token from response
    if response.status_code == 200:
        access_token = response.json()['access_token']        
        return access_token
    else:
        return None
def pullTransactions():
    
    url = 'https://api.safaricom.co.ke/pulltransactions/v1/query'

    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Bearer {generate_access_token()}'
    }
    print(parse_date()[1], generate_access_token())

    payload = {
        'ShortCode': '4161900',
        'StartDate': f'{parse_date()[0]}',
        'EndDate':   f"{parse_date()[1]}",
        'OffSetValue': '0'
    }
    

    response = requests.post(url, headers=headers, json=payload)
    # print(response)
    if response.status_code == 200:
        data = response.json()
        print(data)

        if data['ResponseCode'] == '1000':
            transactions = data['Response'][0]
            return transactions
        else:
            return None

    
    return response.json()

def register_url():
    url = 'https://api.safaricom.co.ke/pulltransactions/v1/register'
    access_token = generate_access_token()
    print(access_token)
    headers = {
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/json',
        'Authorization': f'Bearer {access_token}'
    }

    payload = {
        "ShortCode": "4161900",
        "RequestType": "Pull",
        "NominatedNumber": "254742134431",
        "CallBackURL": "https://kevinnjoroge.pythonanywhere.com"
    }

    response = requests.post(url, headers=headers, json=payload)

    print(response.text)


def parse_date():
    today = datetime.now()
    yesterday = today - timedelta(minutes=3)
    start = yesterday.strftime("%Y-%m-%d %H:%M:%S")
    now = today.strftime("%Y-%m-%d %H:%M:%S")
    return start, now




                
            
    

def generate_mpesa_password(paybill_number):
    timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
    consumer_key = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919'
    concatenated_string = f"{paybill_number}{consumer_key}{timestamp}"
    base64_encoded = base64.b64encode(concatenated_string.encode()).decode('utf-8')

    return str(base64_encoded)
def process_number(input_str):
    if input_str.startswith('0'):
        # Remove the leading '0' and replace it with '254'
        return '254' + input_str[1:]
    elif input_str.startswith('254'):
        # If it starts with '254', return the original string
        return input_str
    else:
        # If it doesn't start with either '0' or '254', return the original string
        return input_str
