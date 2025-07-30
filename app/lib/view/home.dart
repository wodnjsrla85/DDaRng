import 'package:app/components/jun/page_header.dart';
import 'package:app/components/jun/page_tail.dart';
import 'package:app/components/station_map.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int time = DateTime.now().hour;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PageHeader(),
          SizedBox(
            height: 450,
            width: 600,
            child: StationMap(lat: 37.57675136, lng: 126.9265, time: time),
          ),
          SizedBox(height: 30),
          SizedBox(width: 600, height: 150, child: PageTail()),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
