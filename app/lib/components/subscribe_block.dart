import 'package:flutter/material.dart';

class SubscribeBlock extends StatelessWidget {
  const SubscribeBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Want to learn more? \nSubscribe to our newsletter',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            ),
            onPressed: () {
              //
            },
            child: Text('SUBSCRRIBE'),
          ),
        ),
      ],
    );
  }
}
