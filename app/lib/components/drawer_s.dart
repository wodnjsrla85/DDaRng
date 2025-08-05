import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class DrawerS extends StatelessWidget {
  const DrawerS({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        // 이용권 구매
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              final win = web.window;
              win.open(
                'https://www.bikeseoul.com/app/ticket/member/buyTicketList.do',
                '_blank',
              );
            },
            child: Text(
              '이용권 구매',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        // 공지사항
        Divider(thickness: 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              final win = web.window;
              win.open(
                'https://www.bikeseoul.com/customer/notice/noticeList.do',
                '_blank',
              );
            },
            child: Text(
              '공지사항',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Divider(thickness: 2),
        // 안전수칙
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              final win = web.window;
              win.open(
                'https://www.bikeseoul.com/customer/faq/faqList.do',
                '_blank',
              );
            },
            child: Text(
              '안전수칙',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Divider(thickness: 2),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                final win = web.window;
                win.open('https://www.bikeseoul.com/', '_blank');
              },
              child: Image.asset('images/dda.png', height: 100),
            ),
            SizedBox(width: 30),
          ],
        ),
      ],
    );
  }
}
