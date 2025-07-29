import 'package:app/model/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latlong2/latlong.dart';

class StationMap extends StatefulWidget {
  double lat;
  double lng;
  StationMap({super.key, required this.lat, required this.lng});

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  final mapController = MapController();
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStationsMarkers();
    });
  }

  Future<void> _loadStationsMarkers() async {
    final stationBox = Hive.box<Station>('bycle');
    for (var station in stationBox.values) {
      _markers.add(
        Marker(
          point: LatLng(station.st_lat, station.st_long),
          child: Tooltip(
            message: station.st_name,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.lightGreen,
              child: Icon(Icons.pedal_bike, color: Colors.white),
            ),
          ),
        ),
      );
    }
    setState(() {}); // 마커 반영
  }

  @override
  Widget build(BuildContext context) {
    _loadStationsMarkers();
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onTap: (tapPosition, point) {},
        initialCenter: LatLng(widget.lat, widget.lng),
        initialZoom: 14.5,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: _markers),
      ],
    );
  }
}
