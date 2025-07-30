import 'dart:async';
import 'dart:convert';

import 'package:app/components/example_popup.dart';
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

  StationMap({
    super.key,
    required this.lat,
    required this.lng,
    required this.time,
  });

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  final mapController = MapController();
  final List<Marker> _markers = [];
  final stations = [];
  bool loading = true;
  Map parking = {};
  final popupController = PopupController();

  Future<void> _loadStationsMarkers() async {
    if (loading) {
      await getParkingCnt();
      final stationBox = Hive.box<Station>('bycle');

      for (var station in stationBox.values.indexed) {
        stations.add(station);
        _markers.add(
          Marker(
            key: ValueKey(station.$1),
            point: LatLng(station.$2.st_lat, station.$2.st_long),
            child: Tooltip(
              message: station.$2.st_name,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.lightGreen,
                child: Text(
                  parking[station.$2.st_name],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }
      loading = false;
      setState(() {}); // 마커 반영
    }
    print('stataion : $stations');
  }

  getParkingCnt() async {
    final String baseUrl = "http://127.0.0.1:8000";
    final url = Uri.parse("$baseUrl/station");
    final response = await http.get(url);
    final result = json.decode(utf8.decode(response.bodyBytes))['results'];
    parking = result;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    scheduleHourlyTask(_loadStationsMarkers);
  }

  @override
  Widget build(BuildContext context) {
    _loadStationsMarkers();
    return parking.isEmpty
        ? Center(child: CircularProgressIndicator())
        : FlutterMap(
          mapController: mapController,
          options: MapOptions(
            onTap: (_, __) => popupController.hideAllPopups(),
            initialCenter: LatLng(widget.lat, widget.lng),
            initialZoom: 14.5,
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
                                child: Icon(Icons.pedal_bike),
                              ),
                              _cardDescription(
                                context,
                                (marker.key as ValueKey).value,
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
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${st.$2.st_name}',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),

            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              '주소 : ${st.$2.st_adress.substring(6)}',
              style: const TextStyle(fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
            Text(
              '대여가능 : ${parking[st.$2.st_name]} 대',
              style: const TextStyle(fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void scheduleHourlyTask(Function callback) {
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
