import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';

class MyCustomizedElevatedButton extends StatelessWidget {
  const MyCustomizedElevatedButton({
    super.key,
    required this.onPressed,
    this.isFilled = true,
    required this.text,
  });
  final Function() onPressed;
  final String text;
  final bool? isFilled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              side: BorderSide(
                color: isFilled! ? mainColor : Colors.white,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          backgroundColor: MaterialStatePropertyAll(
            isFilled! ? mainColor : backgroundColor,
          ),
          // padding: const MaterialStatePropertyAll(
          //   EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          // ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isFilled! ? Colors.black : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class MyCustomizedElevatedButtonSmall extends StatelessWidget {
  const MyCustomizedElevatedButtonSmall({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
  });
  final Function() onPressed;
  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          backgroundColor ?? mainColor,
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
