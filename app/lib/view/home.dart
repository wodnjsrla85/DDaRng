// -------------------------------------------------------------------------------- //
import 'package:app/components/jun/page_header.dart';
import 'package:app/components/jun/page_tail.dart';
import 'package:app/components/jun/page_top_header.dart';
import 'package:app/components/station_map.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web/web.dart' as web;

// -------------------------------------------------------------------------------- //
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int time = DateTime.now().hour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ------------------------------------ AppBar ------------------------------------ //
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        // drawer : mobile size
        leading: ResponsiveVisibility(
          hiddenConditions: [
            Condition.largerThan(
              value: false,
              name: TABLET,
            ), // 테블릿 보다 작으면 보여준다.
          ],
          child: IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.menu),
          ),
        ),
        // appbar 중단
        title: ResponsiveVisibility(
          hiddenConditions: [
            Condition.largerThan(
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
              GestureDetector(
                onTap: () {
                  final win = web.window;
                  win.open('https://www.bikeseoul.com/', '_blank');
                },
                child: Image.asset('images/dda.png', height: 50),
              ),
              SizedBox(width: 10),
              // 이미지 : 더조은
              GestureDetector(
                onTap: () {
                  final win = web.window;
                  win.open(
                    'https://www.tjoeun.co.kr/?gad_source=1&gad_campaignid=1420329562&gbraid=0AAAAADC6VfwnOBUklwZqK_h7Qw2r9hYlq&gclid=Cj0KCQjw4qHEBhCDARIsALYKFNMFldJov8E5Egr1KYCDicDRoj9NsBzK89uCfXKqdZ3Cc9B93re4HfUaArEzEALw_wcB',
                    '_blank',
                  );
                },
                child: Image.asset('images/dujoeun.png', height: 50),
              ),
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
                  Condition.largerThan(
                    value: true,
                    name: MOBILE,
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
            // page header
            PageHeader(),
            // flutter map
            SizedBox(
              height: 550,
              width: 850,
              child: StationMap(lat: 37.57675136, lng: 126.9265, time: time),
            ),
            // page tail
            SizedBox(height: 100),
            PageTail(),
            SizedBox(height: 150),
          ],
        ),
      ),
      // -------------------------------------------------------------------------------- //
    );
  }
}

// http://openapi.seoul.go.kr:8088/(인증키)/json/bikeList/1/5/
