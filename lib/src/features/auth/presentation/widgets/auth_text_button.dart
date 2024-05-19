
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultTextButton extends StatelessWidget {
  const DefaultTextButton({
    super.key,
    required this.onPressed,
    required this.txt,
  });
  final void Function() onPressed;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        txt,
        style: TextStyle(
          color: HexColor('ffea30'),
          fontSize: 17,
        ),
      ),
    );
  }
}