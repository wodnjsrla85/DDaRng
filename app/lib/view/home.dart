// -------------------------------------------------------------------------------- //
import 'dart:async';
import 'dart:convert';

import 'package:app/components/choice.dart';
import 'package:app/components/drawer_s.dart';
import 'package:app/components/jun/page_header.dart';
import 'package:app/components/jun/page_top_header.dart';
import 'package:app/components/jun/select_time.dart';
import 'package:app/components/station_map.dart';
import 'package:app/model/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web/web.dart' as web;
import 'package:http/http.dart' as http;

// -------------------------------------------------------------------------------- //
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedHour = DateTime.now().hour;
  Map discomfort = {};
  String selecstation = '';
  final stationBox = Hive.box<Station>('bycle');
  double lat = 37.56575136;
  double lng = 126.9465;

  @override
  void initState() {
    super.initState();
    scheduleHourlyTask(_load);
  }

  _load() async {
    await getDiscomfort();
    setState(() {});
  }

  void scheduleHourlyTask(Function callback) {
    callback();

    final now = DateTime.now();
    final nextHour = DateTime(now.year, now.month, now.day, now.hour + 1, 153);
    final durationUntilNextHour = nextHour.difference(now);

    Timer(durationUntilNextHour, () {
      callback();
      _selectedHour = DateTime.now().hour;
      Timer.periodic(Duration(hours: 1), (timer) {
        callback();
        _selectedHour = DateTime.now().hour;
      });
    });
  }

  getDiscomfort() async {
    final String baseUrl = "http://127.0.0.1:8000";
    final url = Uri.parse("$baseUrl/weather");
    final response = await http.get(url);
    final result = json.decode(utf8.decode(response.bodyBytes))['results'];
    discomfort = result;
    setState(() {
      // 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTabletOrLarger = ResponsiveBreakpoints.of(
      context,
    ).largerThan(TABLET);

    return Scaffold(
      drawer: Drawer(backgroundColor: Colors.white, child: DrawerS()),

      backgroundColor: Colors.white,
      // ------------------------------------ AppBar ------------------------------------ //
      appBar:
          isTabletOrLarger
              ? null // 👉 태블릿보다 크면 AppBar 숨기기
              : AppBar(
                scrolledUnderElevation: 0.0,
                backgroundColor: Colors.white,
                centerTitle: true,
                // drawer : TABLET size
                leading: ResponsiveVisibility(
                  hiddenConditions: [
                    Condition.largerThan(
                      landscapeValue: false,
                      value: false,
                      name: TABLET,
                    ), // 테블릿 보다 작으면 보여준다.
                  ],
                  child: Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(Icons.menu),
                      );
                    },
                  ),
                ),
                // appbar 중단
                title: ResponsiveVisibility(
                  hiddenConditions: [
                    Condition.largerThan(
                      landscapeValue: false,
                      value: false,
                      name: TABLET,
                    ), // 테블릿 보다 작으면 보여준다.
                  ],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 이미지 : 서대문구
                      GestureDetector(
                        onTap: () {
                          final win = web.window;
                          win.open('https://www.sdm.go.kr/index.do', '_blank');
                        },
                        child: Image.asset('images/seodemoon.png', height: 50),
                      ),
                      SizedBox(width: 10),
                      // 이미지 : 따릉이
                    ],
                  ),
                ),
              ),
      // -------------------------------------------------------------------------------- //

      // -------------------------------------- Body ------------------------------------ //
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // page top header
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ResponsiveVisibility(
                hiddenConditions: [
                  Condition.smallerThan(
                    value: false,
                    name: DESKTOP,
                  ), // 모바일 보다 크면 보여준다.
                ],
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Divider(thickness: 2),
                    ),
                    PageTopHeader(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Divider(thickness: 2),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: 80,
                    child: Image.asset('images/seoreung.png'),
                  ),
                ),
                SizedBox(width: 10),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: SizedBox(
                    width: 200,
                    child: SelectTime(
                      selectedHour: _selectedHour,
                      onHourChanged: (newHour) {
                        _selectedHour = newHour;
                        if (!mounted) return;
                        setState(() {
                          // state 변경
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Choice(
                  select: selecstation,
                  onChanged: (value) {
                    selecstation = value;
                    lat =
                        stationBox.values
                            .where((e) => e.st_name == selecstation)
                            .first
                            .st_lat;
                    lng =
                        stationBox.values
                            .where((e) => e.st_name == selecstation)
                            .first
                            .st_long;
                    if (!mounted) return;
                    setState(() {});
                  },
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 50),

            // flutter map
            SizedBox(
              height: 550,
              width: isTabletOrLarger ? 850 : 450,
              child:
                  discomfort.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : StationMap(
                        key: ValueKey(_selectedHour),
                        lat: lat,
                        lng: lng,
                        time: _selectedHour,
                        discomfort: discomfort[_selectedHour.toString()],
                      ),
            ),

            SizedBox(height: 50),
            // page header
            PageHeader(),

            SizedBox(height: 50),
          ],
        ),
      ),
      // -------------------------------------------------------------------------------- //
    );
  }
}
