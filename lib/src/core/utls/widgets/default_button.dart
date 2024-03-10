
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.txt,
    required this.onPressed,
    this.backgoungColor,
    this.textColor = Colors.white,
    this.width = 170,
  });

  final Color? textColor;
  final double width;
  final String txt;
  final Color? backgoungColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 60.0,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgoungColor,
          borderRadius: BorderRadius.circular(80),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              backgoungColor ?? HexColor('#7737ff'),
            ),
          ),
          // height: 60,

          child: Text(
            txt,
            style: TextStyle(
              height: 0.0,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
