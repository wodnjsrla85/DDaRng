import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class PageTopHeader extends StatelessWidget {
  const PageTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 2),
        Row(
          children: [
            SizedBox(width: 10),
// 이미지 : 서대문구
            GestureDetector(
              onTap: () {
              final win = web.window;
              win.open('https://www.sdm.go.kr/index.do', '_blank');
              },
              child: Image.asset(
                'images/seodemoon.png',
                height: 50,
              ),
            ),
            SizedBox(width: 10),
// 이미지 : 따릉이
            GestureDetector(
              onTap: () {
              final win = web.window;
              win.open('https://www.bikeseoul.com/', '_blank');
              },
              child: Image.asset(
                'images/dda.png',
                height: 50,
              ),
            ),
            SizedBox(width: 10),
// 이미지 : 더조은
            GestureDetector(
              onTap: () {
              final win = web.window;
              win.open('https://www.tjoeun.co.kr/?gad_source=1&gad_campaignid=1420329562&gbraid=0AAAAADC6VfwnOBUklwZqK_h7Qw2r9hYlq&gclid=Cj0KCQjw4qHEBhCDARIsALYKFNMFldJov8E5Egr1KYCDicDRoj9NsBzK89uCfXKqdZ3Cc9B93re4HfUaArEzEALw_wcB', '_blank');
              },
              child: Image.asset(
                'images/dujoeun.png',
                height: 50,
              ),
            ),
            SizedBox(width: 300),
// 이용권 구매
            TextButton(
              onPressed: () {
                final win = web.window;
                win.open('https://www.bikeseoul.com/app/ticket/member/buyTicketList.do', '_blank');
              }, 
              child: Text(
                '이용권 구매',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(width: 20),
// 공지사항
            TextButton(
              onPressed: () {
                final win = web.window;
                win.open('https://www.bikeseoul.com/customer/notice/noticeList.do', '_blank');
              }, 
              child: Text(
                '공지사항',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(width: 20),
// 안전수칙
            TextButton(
              onPressed: () {
                final win = web.window;
                win.open('https://www.bikeseoul.com/customer/faq/faqList.do', '_blank');
              }, 
              child: Text(
                '안전수칙',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        Divider(thickness: 2),
      ],
    );
  }
}