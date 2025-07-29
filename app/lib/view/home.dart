import 'package:app/components/jun/page_header.dart';
import 'package:app/components/jun/page_tail.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(),
        PageTail()
      ],
    );
  }
}
