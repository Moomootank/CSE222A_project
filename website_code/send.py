import requests
import time

duration = 10
start = time.time()
while time.time() < start + duration:
    requests.get("http://54.201.234.182:5000")
