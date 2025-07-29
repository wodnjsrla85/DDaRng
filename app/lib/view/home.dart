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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(),
        PageTail(),

        SizedBox(
          height: 450,
          width: 600,
          child: StationMap(lat: 37.57675136, lng: 126.9265),
        ),
      ],
    );
  }
}

// http://openapi.seoul.go.kr:8088/(인증키)/json/bikeList/1/5/
