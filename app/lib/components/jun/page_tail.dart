// ----------------------------------------------------------------- //
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web/web.dart' as web;

// ----------------------------------------------------------------- //
/*
// ----------------------------------------------------------------- //
  - title         : Tail of Page
  - Description   : 따릉이 예측 웹 페이지의 tail component 로
  -                 이미지와 함께 문구를 띄우고 ontap 을 통해
  -                 따릉이 공식 홈페이지로 이동한다.
  - Author        : Lee ChangJun
  - Created Date  : 2025.07.29
  - Last Modified : 2025.07.29
  - package       : responsive_framework, web

// ----------------------------------------------------------------- //
  [Changelog]
  - 2025.07.29 v1.0.0  : 전반적인 이미지 와 텍스트 세팅 및 url 연결
// ----------------------------------------------------------------- //
*/
class PageTail extends StatelessWidget {
  const PageTail({super.key});
  // ----------------------------------------------------------------- //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 따릉이 홈페이지 이동
      onTap: () {
        final win = web.window;
        win.open('https://www.bikeseoul.com/', '_blank');
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 따릉이 이미지
          Image.asset(
            'images/ddarng_home_page.png',
            width: MediaQuery.of(context).size.width,
            height: 150,
            fit: BoxFit.cover,
            color: Color.fromRGBO(255, 255, 255, 0.7),
            colorBlendMode: BlendMode.modulate,
          ),
          // Text
          Text(
            'Go To Page',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:
                  ResponsiveValue(
                    context,
                    defaultValue: 30.0,
                    conditionalValues: [
                      Condition.smallerThan(value: 20.0, name: MOBILE),
                      Condition.largerThan(value: 50.0, name: TABLET),
                    ],
                  ).value,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
