import requests

y = '{"text": "sddsdd"}'
url = "http://45.79.67.127:1337/parse/"
print requests.post(url + "/classes/Message", data=y, headers={'X-Parse-Client-Key': '', 'X-Parse-Application-Id': 'CodePath-Parse', 'Content-Type': 'application/json'}).content
