import 'package:flutter/material.dart';

class StationMap extends StatefulWidget {
  String stationName;
  String stationAdress;
  double lat;
  double lng;
  StationMap({
    super.key,
    required this.stationName,
    required this.stationAdress,
    required this.lat,
    required this.lng,
  });

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
