import http.client
import base64

conn = http.client.HTTPConnection("127.0.0.1", 8000)


username = "leoncio"
password = "123456"
client_id = "1234567890"
client_secret = "0987654321"


credentials = f"{client_id}:{client_secret}"
base64_credentials = base64.b64encode(credentials.encode('utf-8')).decode('utf-8')


headersList = {
    "Accept": "application/json",
    "Authorization": "Basic MTIzNDU2Nzg5MDowOTg3NjU0MzIx",
    "Authorization": f"Basic {base64_credentials}",
    "Content-Type": "multipart/form-data; boundary=kljmyvW1ndjXaOEAg4vPm6RBUqO6MC5A"
}

payload = "--kljmyvW1ndjXaOEAg4vPm6RBUqO6MC5A\r\nContent-Disposition: form-data; name=\"username\"\r\n\r\nleoncio\r\n--kljmyvW1ndjXaOEAg4vPm6RBUqO6MC5A\r\nContent-Disposition: form-data; name=\"password\"\r\n\r\n123456\r\n--kljmyvW1ndjXaOEAg4vPm6RBUqO6MC5A--\r\n"

conn.request("POST", "/oauth2/token", payload, headersList)
response = conn.getresponse()
result = response.read()

print(result.decode("utf-8"))
