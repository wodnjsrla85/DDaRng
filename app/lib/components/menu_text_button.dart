import 'package:flutter/material.dart';

class MenuTextButton extends StatelessWidget {
  final String text;
  const MenuTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        //
      },
      child: Text(text),
    );
  }
}
