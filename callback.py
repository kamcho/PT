
import time
import requests


url = "https://www.mwalimuprivate.com/Subscriptions/process-payments"
import urllib.request

def call_url():
    try:
        
        
        headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    # Add other necessary headers here
}
        response = requests.get(url, headers=headers)
        print(response.text)
            
    except requests.exceptions.RequestException as e:
        pass



while True:
    # call_url()
    dt = urllib.request.urlopen(url) 
   
    print('called', dt)
    time.sleep(5)  
