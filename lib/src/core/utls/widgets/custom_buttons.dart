
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyCustomizedElevatedButton extends StatelessWidget {
  const MyCustomizedElevatedButton({
    super.key,
   required this.onPressed,
    required this.text,
  });
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          HexColor('#7737ff'),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
