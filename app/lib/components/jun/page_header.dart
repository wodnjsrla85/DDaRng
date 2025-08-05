// ----------------------------------------------------------------- //
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

// ----------------------------------------------------------------- //
/*
// ----------------------------------------------------------------- //
  - title         : Header of Page
  - Description   : 따릉이 예측 웹 페이지의 header component 로
  -                 이미지 위에 "Predict Leisure" 라는 문구를 띄운다.
  -                 이는 "여유를 예측하다" 라는 뜻이다.
  -                 서릉이는 서대문구 따릉이의 줄임말 이다.
  - Author        : Lee ChangJun
  - Created Date  : 2025.07.29
  - Last Modified : 2025.07.29
  - package       : responsive_framework

// ----------------------------------------------------------------- //
  [Changelog]
  - 2025.07.29 v1.0.0  : 전반적인 이미지 와 텍스트 세팅
  -                      서릉이 이미지 추가 및 반응형 구성
// ----------------------------------------------------------------- //
*/
class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      rowMainAxisAlignment: MainAxisAlignment.spaceAround,
      rowPadding: EdgeInsets.all(30.0),
      columnPadding: EdgeInsets.all(30.0),
      layout:
          ResponsiveBreakpoints.of(context).isDesktop
              ? ResponsiveRowColumnType.ROW
              : ResponsiveRowColumnType.COLUMN,
      children: [
        // ------------------------------- //
        // 서릉이 이미지
        //   ResponsiveRowColumnItem(
        //     rowFlex: 1,
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(20),
        //       child: SizedBox(
        //         width: ResponsiveValue(
        //           context,
        //           defaultValue: 350.0,
        //           conditionalValues: [
        //             Condition.smallerThan(
        //               value: 200.0, name: MOBILE
        //             ),
        //             Condition.largerThan(
        //               value: 450.0, name: TABLET
        //             )
        //           ]
        //         ).value,
        //         child: Image.asset(
        //         'images/seoreung.png',
        //       ),
        //               ),
        //     ),
        // ),
        // ------------------------------- //,
        ResponsiveRowColumnItem(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 따릉이 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/ddarng_header.jpeg',

                  width:
                      ResponsiveValue(
                        context,
                        defaultValue: 600.0,
                        conditionalValues: [
                          Condition.smallerThan(value: 500.0, name: MOBILE),
                          Condition.largerThan(value: 800.0, name: TABLET),
                        ],
                      ).value,
                  fit: BoxFit.cover,
                  color: Color.fromRGBO(255, 255, 255, 0.75),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
              // Text
              Text(
                '"Predict Leisure"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:
                      ResponsiveValue(
                        context,
                        defaultValue: 30.0,
                        conditionalValues: [
                          Condition.smallerThan(value: 20.0, name: MOBILE),
                          Condition.largerThan(value: 40.0, name: TABLET),
                        ],
                      ).value,
                  color: const Color.fromARGB(255, 47, 47, 47),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // ------------------------------- //,
      ],
    );
  }
}
