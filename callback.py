
import time
import requests


url = "https://www.mwalimuprivate.com/Subscriptions/process-payments/"
# url = "http://127.0.0.1:8000/Subscriptions/process-payments"
import urllib.request

def call_url():
    try:

        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            # Add other necessary headers here
        }
        response = requests.get(url, headers=headers)
        
            
    except Exception as e:
        pass



while True:
    headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            # Add other necessary headers here
        }
    request = urllib.request.Request(url, headers=headers)
    dt = urllib.request.urlopen(request, timeout=30)
    print(dt.status)
    time.sleep(15)  
