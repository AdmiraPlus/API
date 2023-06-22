import http.client
import json

conn = http.client.HTTPConnection("127.0.0.1", 8000)

headersList = {
 "Accept": "application/json",
 "Content-Type": "application/json; charset=UTF-8",
 "Authorization": "Bearer sfadfasdfasdfasdfdas f dasf dasf dasf das fdfas" 
}

payload = json.dumps({
	"CuitMutual": 2060202020,
	"NumeroCuenta": 202002,
	"CodigoMovimiento": "TACATA",
	"TipoMovimiento": "C",
	"NumeroMovimiento": 20020,
	"FechaMovimiento": "2023-06-22T12:40:16",
	"Importe": 350.00
})

conn.request("POST", "/GuardarMovimiento", payload, headersList)
response = conn.getresponse()
result = response.read()

print(result.decode("utf-8"))