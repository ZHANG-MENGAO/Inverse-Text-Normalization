import requests
import json

url = "http://localhost:5000/api/normalize"

data = {
    "content": ["zero one two three", "three two one zero", "input3"]
}

headers = {
    "Content-Type": "application/json"
}

response = requests.post(url, data=json.dumps(data), headers=headers)

# Check if the request was successful
if response.status_code == 200:
    result = response.json()
    print(result)
else:
    print(f"Error {response.status_code}: {response.text}")