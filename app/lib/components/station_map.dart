import 'dart:async';
import 'dart:convert';

import 'package:app/components/example_popup.dart';
import 'package:app/model/data_info.dart';
import 'package:app/model/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class StationMap extends StatefulWidget {
  double lat;
  double lng;
  int time;
  double discomfort;

  StationMap({
    super.key,
    required this.lat,
    required this.lng,
    required this.time,
    required this.discomfort,
  });

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  final mapController = MapController();
  final List<Marker> _markers = [];
  final stations = [];
  Map parking = {};
  Map predParking = {};
  int index = 0;
  final popupController = PopupController();
  int selectime = 0;

  Future<void> _loadStationsMarkers(int time) async {
    await getParkingCnt();
    final stationBox = Hive.box<Station>('bycle');
    for (var station in stationBox.values) {
      stations.add(station);
      _markers.add(
        Marker(
          key: ValueKey('$index'),
          point: LatLng(station.st_lat, station.st_long),
          child: Tooltip(
            message: station.st_name,
            child: CircleAvatar(
              radius: 18,
              backgroundColor:
                  int.parse(parking[station.st_name]) == 0
                      ? Colors.grey
                      : Colors.lightGreen,
              child: Text(
                parking[station.st_name],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      );
      index += 1;

      if (!mounted) return;
      setState(() {
        // 업데이트
      }); // 마커 반영
    }
  }

  Future<void> _loadPredStationsMarkers(int time) async {
    await getParkingCnt();

    if (DateTime.now().weekday >= 1 && DateTime.now().weekday <= 5) {
      if (time < DateTime.now().hour && DateTime.now().weekday + 1 > 5) {
        await getPredParkingCntHoli();
      } else {
        await getPredParkingCntWork();
      }
    } else {
      if (time < DateTime.now().hour && DateTime.now().weekday + 1 == 8) {
        await getPredParkingCntWork();
      } else {
        await getPredParkingCntHoli();
      }
    }

    final stationBox = Hive.box<Station>('bycle');
    for (var station in stationBox.values) {
      stations.add(station);
      _markers.add(
        Marker(
          key: ValueKey('$index'),
          point: LatLng(station.st_lat, station.st_long),
          child: Tooltip(
            message: station.st_name,
            child: CircleAvatar(
              radius: 18,
              backgroundColor:
                  int.parse(predParking[station.st_name]['대여가능'].toString()) ==
                          0
                      ? Colors.grey
                      : Colors.lightGreen,
              child: Text(
                '${int.parse(predParking[station.st_name]['대여가능'].toString()) < 0 ? 0 : predParking[station.st_name]['대여가능']}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      );
      index += 1;

      if (!mounted) return;
      setState(() {
        // 업데이트
      }); // 마커 반영
    }
  }

  getParkingCnt() async {
    final String baseUrl = "http://127.0.0.1:8000";
    final url = Uri.parse("$baseUrl/stationNow");
    final response = await http.get(url);
    final result = json.decode(utf8.decode(response.bodyBytes))['results'];
    parking = result;
    if (!mounted) return;
    setState(() {
      // 업데이트
    });
  }

  getPredParkingCntWork() async {
    final String baseUrl = "http://127.0.0.1:8000";
    final url = Uri.parse("$baseUrl/stationPred/work");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        DataInfo(
          time: selectime,
          discomfort: widget.discomfort,
          nowbc: parking,
        ).toMap(),
      ),
    );
    final result = json.decode(utf8.decode(response.bodyBytes))['results'];
    predParking = result;
    if (!mounted) return;
    setState(() {
      // 업데이트
    });
  }

  getPredParkingCntHoli() async {
    final String baseUrl = "http://127.0.0.1:8000";
    final url = Uri.parse("$baseUrl/stationPred/holi");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        DataInfo(
          time: selectime,
          discomfort: widget.discomfort,
          nowbc: parking,
        ).toMap(),
      ),
    );
    final result = json.decode(utf8.decode(response.bodyBytes))['results'];
    predParking = result;
    if (!mounted) return;
    setState(() {
      // 업데이트
    });
  }

  _load() {
    if (selectime == DateTime.now().hour) {
      _loadStationsMarkers(selectime);
    } else {
      _loadPredStationsMarkers(selectime);
    }
    if (!mounted) return;
    setState(() {
      // 업데이트
    });
  }

  @override
  void initState() {
    super.initState();
    selectime = widget.time;
    scheduleHourlyTask(_load);
  }

  @override
  void didUpdateWidget(covariant StationMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lat != widget.lat || oldWidget.lng != widget.lng) {
      mapController.move(LatLng(widget.lat, widget.lng), 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(selectime);
    return parking.isEmpty
        ? Center(child: CircularProgressIndicator())
        : FlutterMap(
          mapController: mapController,
          options: MapOptions(
            onTap: (_, __) => popupController.hideAllPopups(),
            initialCenter: LatLng(widget.lat, widget.lng),
            initialZoom: 14.7,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.app',
            ),
            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                markers: _markers,
                popupController: popupController,
                popupDisplayOptions: PopupDisplayOptions(
                  builder:
                      (BuildContext context, Marker marker) => Card(
                        child: InkWell(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 10,
                                ),
                                child: Icon(Icons.pedal_bike, size: 40),
                              ),
                              _cardDescription(
                                context,
                                int.parse((marker.key as ValueKey).value),
                              ),
                            ],
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ],
        );
  }

  Widget _cardDescription(BuildContext context, int idx) {
    final st = stations[idx];
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${st.st_name}',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),

            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              '주소 : ${st.st_adress.substring(6)}',
              style: const TextStyle(fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
            widget.time != DateTime.now().hour
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '예상 대여 수 : ${predParking[st.st_name]['대여']} 대',
                      style: const TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '예상 반납 수 : ${predParking[st.st_name]['반납']} 대',
                      style: const TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
                : SizedBox(),
            Text(
              '대여가능 : ${widget.time == DateTime.now().hour
                  ? parking[st.st_name]
                  : int.parse(predParking[st.st_name]['대여가능'].toString()) < 0
                  ? 0
                  : predParking[st.st_name]['대여가능']} 대',
              style: const TextStyle(fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void scheduleHourlyTask(Function callback) {
    callback();

    final now = DateTime.now();
    final nextHour = DateTime(now.year, now.month, now.day, now.hour + 1);
    final durationUntilNextHour = nextHour.difference(now);

    Timer(durationUntilNextHour, () {
      callback();
      Timer.periodic(Duration(hours: 1), (timer) {
        callback();
      });
    });
  }
}
