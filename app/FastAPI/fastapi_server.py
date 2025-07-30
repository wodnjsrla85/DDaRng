from fastapi import FastAPI
import requests
import json
import pandas as pd
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles


ip = "127.0.0.1"
app = FastAPI()


# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'], # 모든 도메인 허용
    allow_credentials = True,
    allow_methods = ['*'], # 모든 http method 허용
    allow_headers=['*'], # 모든 헤더 허용
)



@app.get('/station')
async def station():
    station = pd.read_csv('assets/서대문구_대여소_위치정보.csv')
    stationIds = list(station.대여소_ID.values)

    API_KEY = "4761675542696262373853794b6a4e"
    results = []

    for st in stationIds:
        url = f"http://openapi.seoul.go.kr:8088/{API_KEY}/json/bikeList/1/1/{st}"
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            # 데이터 예시 출력
            for row in data['rentBikeStatus']['row']:
                results.append({row['stationId'] : row['parkingBikeTotCnt']})
    
        else:
            print("API 요청 실패:", response.status_code)

    merged = {}
    for d in results:
        merged.update(d)
    return {'results' : merged}

app.mount("/", StaticFiles(directory="build/web/", html=True), name="flutter_web")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app,host=ip,port=8000,limit_max_requests=1024*1024*10)