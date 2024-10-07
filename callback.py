
import time
import requests

from Subscription.tests import pullTransactions

url = "https://www.mwalimuprivate.com/Subscriptions/process-payments"

def call_url():
    try:
        transactions = pullTransactions()
        if transactions:
            response = requests.get(url)
            print(response)
            
    except requests.exceptions.RequestException as e:
        pass



while True:
    call_url()
    print('called')
    time.sleep(45)  
