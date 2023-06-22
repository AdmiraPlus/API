import json

datos = """
{
    "nombre": "Leoncio",
    "apellido": "Barrios",
    "fecha_nacimiento": "1968-02-22",
    "estatura": 1.90,
    "hijos": ["Leonardo", "Leonela"]	
}
"""

#miDic = jason.loads(datos)
miDic = json.loads(datos)

#print(miDic)
print(miDic.get("nombre"))
print(miDic["apellido"])
#print("hijo(a): " + miDic["hijos"][0])
print(miDic["hijos"])
print(type(miDic))

print("-------------------------------")
lenguajes = {
    'back': ["Python", "C#", "Java", "PHP", "GO"],
    'front': ["JavaScript", "HTML", "CSS"],
    'estado': False
}



miJson = json.dumps(lenguajes, indent='\t')
print(miJson)

print(type(miJson))
