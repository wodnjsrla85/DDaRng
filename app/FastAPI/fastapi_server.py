from fastapi import FastAPI
import requests
import json
import pandas as pd
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
import joblib
import os
import warnings
warnings.filterwarnings('ignore')


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


class Info(BaseModel):
    time : int
    discomfort : float
    nowbc : dict

rent_holi_ratio ={
    0: 0.646240,
    1: 0.673074,
    2: 0.653853,
    3: 0.669808,
    4: 0.776281,
    5: 0.753081,
    6: 0.704565,
    7: 0.730374,
    8: 0.639410,
    9: 0.629777,
    10: 0.702021,
    11: 0.696651,
    12: 0.700800,
    13: 0.722793,
    14: 0.710172,
    15: 0.651107,
    16: 0.627251,
    17: 0.659845,
    18: 0.634077,
    19: 0.557763,
    20: 0.511323,
    21: 0.514257,
    22: 0.556566,
    23: 0.507450
}

rent_work_ratio = {
    0: 0.671059,
    1: 0.713937,
    2: 0.643526,
    3: 0.704117,
    4: 0.816171,
    5: 0.747944,
    6: 0.696141,
    7: 0.726840,
    8: 0.638048,
    9: 0.614604,
    10: 0.679627,
    11: 0.668448,
    12: 0.692553,
    13: 0.681589,
    14: 0.704924,
    15: 0.618317,
    16: 0.601657,
    17: 0.651024,
    18: 0.633505,
    19: 0.542156,
    20: 0.486195,
    21: 0.490561,
    22: 0.537776,
    23: 0.496143
}

rt_holi_ratio = {
    0: 0.600077,
    1: 0.616087,
    2: 0.653454,
    3: 0.648507,
    4: 0.722913,
    5: 0.772156,
    6: 0.921183,
    7: 0.780354,
    8: 0.656139,
    9: 0.740277,
    10: 0.705153,
    11: 0.798691,
    12: 0.729692,
    13: 0.713546,
    14: 0.722214,
    15: 0.730238,
    16: 0.652842,
    17: 0.691001,
    18: 0.619638,
    19: 0.629386,
    20: 0.622292,
    21: 0.593741,
    22: 0.604279,
    23: 0.649227
}

rt_work_ratio ={
    0: 0.653090,
    1: 0.695836,
    2: 0.661368,
    3: 0.750938,
    4: 0.647713,
    5: 0.793001,
    6: 0.717660,
    7: 0.607232,
    8: 0.620203,
    9: 0.520633,
    10: 0.571684,
    11: 0.682850,
    12: 0.673320,
    13: 0.649918,
    14: 0.690899,
    15: 0.643458,
    16: 0.662818,
    17: 0.653031,
    18: 0.571738,
    19: 0.542680,
    20: 0.498116,
    21: 0.499785,
    22: 0.516931,
    23: 0.516971
}


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_DIR = os.path.join(BASE_DIR,'model')
# ==== 대여 평일 ====
rent4_work = joblib.load(os.path.join(MODEL_DIR,'cluster4_work.h5'))
rent5_work = joblib.load(os.path.join(MODEL_DIR,'cluster5_work.h5'))
rent6_work = joblib.load(os.path.join(MODEL_DIR,'cluster6_work.h5'))
rent7_work = joblib.load(os.path.join(MODEL_DIR,'cluster7_work.h5'))
rent8_work = joblib.load(os.path.join(MODEL_DIR,'cluster8_work.h5'))
rent9_work = joblib.load(os.path.join(MODEL_DIR,'cluster9_work.h5'))

# ==== 대여 주말 ====
rent4_holi = joblib.load(os.path.join(MODEL_DIR,'cluster4_holi.h5'))
rent5_holi = joblib.load(os.path.join(MODEL_DIR,'cluster5_holi.h5'))
rent6_holi = joblib.load(os.path.join(MODEL_DIR,'cluster6_holi.h5'))
rent7_holi = joblib.load(os.path.join(MODEL_DIR,'cluster7_holi.h5'))
rent8_holi = joblib.load(os.path.join(MODEL_DIR,'cluster8_holi.h5'))
rent9_holi = joblib.load(os.path.join(MODEL_DIR,'cluster9_holi.h5'))

# ==== 반납 평일 ====
rt4_work = joblib.load(os.path.join(MODEL_DIR,'end_cluster4_3_work_rf.h5'))
rt5_work = joblib.load(os.path.join(MODEL_DIR,'end_cluster5_3_work_rf.h5'))
rt6_work = joblib.load(os.path.join(MODEL_DIR,'end_cluster6_3_work_rf.h5'))
rt7_work = joblib.load(os.path.join(MODEL_DIR,'end_cluster7_2_work_rf.h5'))
rt8_work = joblib.load(os.path.join(MODEL_DIR,'end_cluster8_2_work_rf.h5'))
rt9_work = joblib.load(os.path.join(MODEL_DIR,'end_cluster9_3_work_rf.h5'))
rt10_work = joblib.load(os.path.join(MODEL_DIR,'end_cluster10_3_work_rf.h5'))

# ==== 반납 주말 ====
rt6_holi = joblib.load(os.path.join(MODEL_DIR,'end_cluster6_3_holi_rf.h5'))
rt7_holi = joblib.load(os.path.join(MODEL_DIR,'end_cluster7_2_holi_rf.h5'))
rt8_holi = joblib.load(os.path.join(MODEL_DIR,'end_cluster8_2_holi_rf.h5'))
rt9_holi = joblib.load(os.path.join(MODEL_DIR,'end_cluster9_2_holi_rf.h5'))
rt10_holi = joblib.load(os.path.join(MODEL_DIR,'end_cluster10_2_holi_rf.h5'))



@app.get('/stationNow')
async def stationNow():
    station = pd.read_csv('assets/서대문구_대여소_정보.csv')
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


@app.post('/stationPred/work')
async def stationPredWork(info : Info):
    pred_rent =0
    pred_rt = 0
    results = {}
    station = pd.read_csv('assets/서대문구_대여소_정보.csv')
    stationIds = list(station.대여소_ID.values)
    for st in stationIds:
        if st in ['ST-1491', 'ST-2208', 'ST-2216', 'ST-227','ST-30','ST-3062','ST-3140']:
            if info.time in [7,8,18,19]:
                pred_rent = rent4_work.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent4_work.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-1190', 'ST-2205', 'ST-2206', 'ST-2210', 'ST-222','ST-231', 'ST-2897', 'ST-3139', 'ST-347']:
            if info.time in [7,8,18]:
                pred_rent = rent5_work.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent5_work.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-2213', 'ST-3051', 'ST-3113', 'ST-349']:
            if info.time in [7,8,18]:
                pred_rent = rent6_work.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent6_work.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-2204', 'ST-223', 'ST-350']:
            if info.time == 8:
                pred_rent = rent7_work.predict([[False,True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            elif info.time in [7,18,19]:
                pred_rent = rent7_work.predict([[True,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent7_work.predict([[False,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-232', 'ST-25', 'ST-33','ST-35', 'ST-555']:
            if info.time == 8:
                pred_rent = rent8_work.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent8_work.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-17']:
            if info.time in [8,18,19]:
                pred_rent = rent9_work.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent9_work.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        

        if st in ['ST-1491', 'ST-2208', 'ST-2216', 'ST-222', 'ST-227', 'ST-2897', 'ST-30','ST-3062', 'ST-3140']:
            if info.time == 18:
                pred_rt = rt4_work.predict([[True,True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            elif info.time in [17, 19]:
                pred_rt = rt4_work.predict([[True,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt4_work.predict([[False,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-1190', 'ST-2205', 'ST-2206', 'ST-2210', 'ST-231', 'ST-347']:
            if info.time == 18:
                pred_rt = rt5_work.predict([[True,True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            elif info.time in [17,19,20,21]:
                pred_rt = rt5_work.predict([[True,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt5_work.predict([[False,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in  ['ST-2213', 'ST-3051', 'ST-3113', 'ST-3139']:
            if info.time == 8:
                pred_rt = rt6_work.predict([[True,True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            elif info.time == 8:
                pred_rt = rt6_work.predict([[True,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt6_work.predict([[False,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in  ['ST-2204', 'ST-223', 'ST-349', 'ST-350']:
            if info.time == 18:
                pred_rt = rt7_work.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt7_work.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-232', 'ST-25', 'ST-555']:
            if info.time in [7,8,18]:
                pred_rt = rt8_work.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt8_work.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-33', 'ST-35']:
            if info.time == 18:
                pred_rt = rt9_work.predict([[True,True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            elif info.time in [16,19,20,21]:
                pred_rt = rt9_work.predict([[True,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt9_work.predict([[False,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-17']:
            if info.time == 18:
                pred_rt = rt10_work.predict([[True,True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            elif info.time in [7,8,17,19,20,21]:
                pred_rt = rt10_work.predict([[True,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt10_work.predict([[False,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        results[st] = {'대여':int(pred_rent*rent_holi_ratio[info.time]), '반납':int(pred_rt*rt_holi_ratio[info.time]), '대여가능':int((int(info.nowbc[st])-(pred_rent*rent_holi_ratio[info.time])+(pred_rt*rt_holi_ratio[info.time])))}

    return {'results' : results}



@app.post('/stationPred/holi')
async def stationPredHoil(info : Info):
    pred_rent =0
    pred_rt = 0
    results = {}
    station = pd.read_csv('assets/서대문구_대여소_정보.csv')
    stationIds = list(station.대여소_ID.values)
    for st in stationIds:
        if st in ['ST-1491', 'ST-2208', 'ST-2216', 'ST-227','ST-30','ST-3062','ST-3140']:
            if info.time in [12,13,14,15,16,17,18,19,20,21]:
                pred_rent = rent4_holi.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent4_holi.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-1190', 'ST-2205', 'ST-2206', 'ST-2210', 'ST-222','ST-231', 'ST-2897', 'ST-3139', 'ST-347']:
            if info.time in [12,13,14,15,16,17,18,19]:
                pred_rent = rent5_holi.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent5_holi.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-2213', 'ST-3051', 'ST-3113', 'ST-349']:
            if info.time in [15,16,17,18 ]:
                pred_rent = rent6_holi.predict([[False,True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            elif info.time in [10,11,12,13,14,19,20,21]:
                pred_rent = rent6_holi.predict([[True,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent6_holi.predict([[False,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-2204', 'ST-223', 'ST-350']:
            if info.time in[15,16,17,18]:
                pred_rent = rent7_holi.predict([[False,True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            elif info.time in [12,13,14,19,20,21]:
                pred_rent = rent7_holi.predict([[True,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent7_holi.predict([[False,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-232', 'ST-25', 'ST-33','ST-35', 'ST-555']:
            if info.time in [12,13,14,15,16,17,18,19,20,21]:
                pred_rent = rent8_holi.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent8_holi.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-17']:
            if info.time in [13,14,15,16,17,18,19,20,21,22]:
                pred_rent = rent9_holi.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rent = rent9_holi.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        

        if st in ['ST-1491', 'ST-2208', 'ST-2216', 'ST-222', 'ST-227', 'ST-2897', 'ST-30','ST-3062', 'ST-3140']:
            pred_rt = 0
        elif st in ['ST-1190', 'ST-2205', 'ST-2206', 'ST-2210', 'ST-231', 'ST-347']:
            pred_rt = 0
        elif st in  ['ST-2213', 'ST-3051', 'ST-3113', 'ST-3139']:
            if info.time in [14,15,16,17,18]:
                pred_rt = rt6_holi.predict([[True,True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            elif info.time in [10,11,12,13,19,20,21,22]:
                pred_rt = rt6_holi.predict([[True,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt6_holi.predict([[False,False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in  ['ST-2204', 'ST-223', 'ST-349', 'ST-350']:
            if info.time in [range(14,22+1)]:
                pred_rt = rt7_holi.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt7_holi.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-232', 'ST-25', 'ST-555']:
            if info.time in [range(14,22+1)]:
                pred_rt = rt8_holi.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt8_holi.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-33', 'ST-35']:
            if info.time in [range(16,22+1)]:
                pred_rt = rt9_holi.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt9_holi.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        elif st in ['ST-17']:
            if info.time in [range(15,22+1)]:
                pred_rt = rt10_holi.predict([[True,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
            else:
                pred_rt = rt10_holi.predict([[False,info.discomfort,float(station[station['대여소_ID'] == st]['고도(m)'])]])
        results[st] = {'대여':int(pred_rent*rent_holi_ratio[info.time]), '반납':int(pred_rt*rt_holi_ratio[info.time]), '대여가능':int((int(info.nowbc[st])-(pred_rent*rent_holi_ratio[info.time])+(pred_rt*rt_holi_ratio[info.time])))}
    return {'results' : results}


@app.get('/weather')
async def weather():
    key ='yX7431tBp2yMenmGqV9ydyCI5NKR8vAv'
    wp = {}
    response = requests.get(f'https://dataservice.accuweather.com/currentconditions/v1/226081?apikey={key}&metric=true&details=true')
    if response.status_code == 200:
        decoded = response.content.decode('utf-8')
        day = json.loads(decoded)[0]
        discomfort = 0.81 * day['Temperature']['Metric']['Value'] + 0.01 * day['RelativeHumidity'] * (0.99 * day['Temperature']['Metric']['Value'] - 14.3) + 46.3
        wp[int(day['LocalObservationDateTime'][11:13])]=round(discomfort,5)
    else:
        print("API 요청 실패:", response.status_code)
    
    response = requests.get(f'https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/226081?apikey={key}&metric=true&details=true')
    if response.status_code == 200:
        decoded = response.content.decode('utf-8')
        days = json.loads(decoded)
    
        for day in days:
            
            discomfort = 0.81 * day['Temperature']['Value'] + 0.01 * day['RelativeHumidity'] * (0.99 * day['Temperature']['Value'] - 14.3) + 46.3
            wp[int(day['DateTime'][11:13])]=round(discomfort,5)

    else:
        print("API 요청 실패:", response.status_code)

    print(wp)
    return {'results' : wp}


app.mount("/", StaticFiles(directory="build/web", html=True), name="flutter_web")



if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app,host=ip,port=8000,limit_max_requests=1024*1024*10)

