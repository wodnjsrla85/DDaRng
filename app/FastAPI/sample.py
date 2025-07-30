# # Python3 샘플 코드 #


# import requests
# import json

# wp = {}
# response = requests.get('https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/226081?apikey=y7BGIJuqo5A120sJZkgGlW2zElUd0Lr9&metric=true&details=true')
# decoded = response.content.decode('utf-8')
# days = json.loads(decoded)
# for day in days:
#     wp[day['DateTime'][11:13]]={'기온':day['Temperature']['Value'],'습도':day['RelativeHumidity']}

# print(wp)
