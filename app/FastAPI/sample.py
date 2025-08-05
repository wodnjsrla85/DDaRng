# # # # Python3 샘플 코드 #


# # # import requests
# # # import json

# # # wp = {}
# # # response = requests.get('https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/226081?apikey=y7BGIJuqo5A120sJZkgGlW2zElUd0Lr9&metric=true&details=true')
# # # decoded = response.content.decode('utf-8')
# # # days = json.loads(decoded)
# # # for day in days:
# # #     wp[day['DateTime'][11:13]]={'기온':day['Temperature']['Value'],'습도':day['RelativeHumidity']}

# # # print(wp)


import joblib
# import os
import warnings
import pandas as pd
warnings.filterwarnings('ignore')


# # # # BASE_DIR = os.path.dirname(os.path.abspath(__file__))
# # # # MODEL_DIR = os.path.join(BASE_DIR,'model')
# # # # ==== 대여 평일 ====
rt4_holi = joblib.load('/Users/macbook/Documents/data/fork/DDaRng/app/FastAPI/model/cluster4_work_2.h5')

station = pd.read_csv('/Users/macbook/Documents/data/fork/DDaRng/app/assets/서대문구_대여소_정보.csv')

for i in ['ST-1491', 'ST-2208', 'ST-2216', 'ST-227','ST-30','ST-3062','ST-3140']:  
        rt4_holi.predict([[True,80.231,float(station[station['대여소_ID'] == i]['고도(m)'])]])
# len(list(station['대여소_ID'].values)) 
# len(['ST-1491', 'ST-2208', 'ST-2216', 'ST-222', 'ST-227', 'ST-2897', 'ST-30',
#        'ST-3062', 'ST-3140','ST-1190', 'ST-2205', 'ST-2206', 'ST-2210', 'ST-231', 'ST-347','ST-2213', 'ST-3051', 'ST-3113', 'ST-3139','ST-2204', 'ST-223', 'ST-349', 'ST-350','ST-232', 'ST-25', 'ST-555','ST-33', 'ST-35','ST-17'])

# missing = [x for x in list(station['대여소_ID'].values) if x not in ['ST-1491', 'ST-2208', 'ST-2216', 'ST-222', 'ST-227', 'ST-2897', 'ST-30',
#        'ST-3062', 'ST-3140' ,'ST-1190', 'ST-2205', 'ST-2206', 'ST-2210', 'ST-231', 'ST-347','ST-2213', 'ST-3051', 'ST-3113', 'ST-3139','ST-2204', 'ST-223', 'ST-349', 'ST-350','ST-232', 'ST-25', 'ST-555','ST-33', 'ST-35','ST-17']]
# print(missing)
# data ={
#     "ST-555": {
#       "반납": 7
#     },
#     "ST-43": {
#       "반납": 6
#     },
#     "ST-42": {
#       "반납": 6
#     },
#     "ST-41": {
#       "반납": 6
#     },
#     "ST-40": {
#       "반납": 6
#     },
#     "ST-39": {
#       "반납": 6
#     },
#     "ST-37": {
#       "반납": 6
#     },
#     "ST-36": {
#       "반납": 6
#     },
#     "ST-354": {
#       "반납": 6
#     },
#     "ST-352": {
#       "반납": 6
#     },
#     "ST-351": {
#       "반납": 6
#     },
#     "ST-350": {
#       "반납": 3
#     },
#     "ST-35": {
#       "반납": 9
#     },
#     "ST-349": {
#       "반납": 4
#     },
#     "ST-348": {
#       "반납": 6
#     },
#     "ST-347": {
#       "반납": 2
#     },
#     "ST-346": {
#       "반납": 6
#     },
#     "ST-345": {
#       "반납": 6
#     },
#     "ST-3349": {
#       "반납": 6
#     },
#     "ST-3347": {
#       "반납": 6
#     },
#     "ST-33": {
#       "반납": 10
#     },
#     "ST-3202": {
#       "반납": 6
#     },
#     "ST-3140": {
#       "반납": 3
#     },
#     "ST-3139": {
#       "반납": 5
#     },
#     "ST-3114": {
#       "반납": 6
#     },
#     "ST-3113": {
#       "반납": 7
#     },
#     "ST-3107": {
#       "반납": 6
#     },
#     "ST-3062": {
#       "반납": 3
#     },
#     "ST-3051": {
#       "반납": 5
#     },
#     "ST-3033": {
#       "반납": 6
#     },
#     "ST-3027": {
#       "반납": 6
#     },
#     "ST-30": {
#       "반납": 3
#     },
#     "ST-2897": {
#       "반납": 3
#     },
#     "ST-2561": {
#       "반납": 6
#     },
#     "ST-25": {
#       "반납": 7
#     },
#     "ST-233": {
#       "반납": 6
#     },
#     "ST-232": {
#       "반납": 4
#     },
#     "ST-231": {
#       "반납": 4
#     },
#     "ST-230": {
#       "반납": 6
#     },
#     "ST-228": {
#       "반납": 6
#     },
#     "ST-227": {
#       "반납": 3
#     },
#     "ST-226": {
#       "반납": 6
#     },
#     "ST-224": {
#       "반납": 6
#     },
#     "ST-223": {
#       "반납": 3
#     },
#     "ST-222": {
#       "반납": 5
#     },
#     "ST-2219": {
#       "반납": 6
#     },
#     "ST-2217": {
#       "반납": 6
#     },
#     "ST-2216": {
#       "반납": 3
#     },
#     "ST-2215": {
#       "반납": 6
#     },
#     "ST-2214": {
#       "반납": 6
#     },
#     "ST-2213": {
#       "반납": 4
#     },
#     "ST-2212": {
#       "반납": 6
#     },
#     "ST-2210": {
#       "반납": 3
#     },
#     "ST-221": {
#       "반납": 6
#     },
#     "ST-2208": {
#       "반납": 3
#     },
#     "ST-2207": {
#       "반납": 6
#     },
#     "ST-2206": {
#       "반납": 4
#     },
#     "ST-2205": {
#       "반납": 4
#     },
#     "ST-2204": {
#       "반납": 3
#     },
#     "ST-2202": {
#       "반납": 6
#     },
#     "ST-2201": {
#       "반납": 6
#     },
#     "ST-2200": {
#       "반납": 6
#     },
#     "ST-220": {
#       "반납": 6
#     },
#     "ST-2199": {
#       "반납": 6
#     },
#     "ST-2198": {
#       "반납": 6
#     },
#     "ST-2196": {
#       "반납": 6
#     },
#     "ST-2195": {
#       "반납": 6
#     },
#     "ST-2194": {
#       "반납": 6
#     },
#     "ST-219": {
#       "반납": 6
#     },
#     "ST-218": {
#       "반납": 6
#     },
#     "ST-217": {
#       "반납": 6
#     },
#     "ST-216": {
#       "반납": 6
#     },
#     "ST-17": {
#       "반납": 6
#     },
#     "ST-1493": {
#       "반납": 6
#     },
#     "ST-1491": {
#       "반납": 3
#     },
#     "ST-12": {
#       "반납": 6
#     },
#     "ST-1190": {
#       "반납": 4
#     },
#     "ST-1189": {
#       "반납": 6
#     },
#     "ST-1188": {
#       "반납": 6
#     }
#   }

# len(data)
# # # for i in ['ST-12', 'ST-1491', 'ST-2208', 'ST-2216', 'ST-227','ST-30','ST-3062','ST-3140']:  
# # #     round(float(rt4_holi.predict([[True,False,80.231,float(station[station['대여소_ID'] == i]['고도(m)'])]])))

# # # import pandas as pd

# # # for i in ['ST-12', 'ST-1491', 'ST-2208', 'ST-2216', 'ST-227','ST-30','ST-3062','ST-3140']: 
# # # float(station[station['대여소_ID'] == 'ST-12']['고도(m)'])

# #         if st in ['ST-1491', 'ST-2208', 'ST-2216', 'ST-222', 'ST-227', 'ST-2897', 'ST-30','ST-3062', 'ST-3140']:
# #             if info.time == 18:
# #                 pred_rt = int(np.round(rt4_holi.predict([[True,True,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             elif info.time in [17, 19]:
# #                 pred_rt = int(np.round(rt4_holi.predict([[True,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             else:
# #                 pred_rt = int(np.round(rt4_holi.predict([[False,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #         elif st in ['ST-1190', 'ST-2205', 'ST-2206', 'ST-2210', 'ST-231', 'ST-347']:
# #             if info.time == 18:
# #                 pred_rt = int(np.round(rt5_holi.predict([[True,True,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             elif info.time in [17,19,20,21]:
# #                 pred_rt = int(np.round(rt5_holi.predict([[True,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             else:
# #                 pred_rt = int(np.round(rt5_holi.predict([[False,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #         elif st in  ['ST-2213', 'ST-3051', 'ST-3113', 'ST-3139']:
# #             if info.time == 8:
# #                 pred_rt = int(np.round(rt6_holi.predict([[True,True,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             elif info.time == 8:
# #                 pred_rt = int(np.round(rt6_holi.predict([[True,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             else:
# #                 pred_rt = int(np.round(rt6_holi.predict([[False,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #         elif st in  ['ST-2204', 'ST-223', 'ST-349', 'ST-350']:
# #             if info.time == 18:
# #                 pred_rt = int(np.round(rt7_holi.predict([[True,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             else:
# #                 pred_rt = int(np.round(rt7_holi.predict([[False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #         elif st in ['ST-232', 'ST-25', 'ST-555']:
# #             if info.time in [7,8,18]:
# #                 pred_rt = int(np.round(rt8_holi.predict([[True,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             else:
# #                 pred_rt = int(np.round(rt8_holi.predict([[False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #         elif st in ['ST-33', 'ST-35']:
# #             if info.time == 18:
# #                 pred_rt = int(np.round(rt9_holi.predict([[True,True,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             elif info.time in [16,19,20,21,22]:
# #                 pred_rt = int(np.round(rt9_holi.predict([[True,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             else:
# #                 pred_rt = int(np.round(rt9_holi.predict([[False,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #         else:
# #             if info.time == 18:
# #                 pred_rt = int(np.round(rt10_holi.predict([[True,True,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             elif info.time in [7,8,17,19,20,21]:
# #                 pred_rt = int(np.round(rt10_holi.predict([[True,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))
# #             else:
# #                 pred_rt = int(np.round(rt10_holi.predict([[False,False,info.discomfort,int(station[station['대여소_ID'] == st]['고도(m)'])]])))


