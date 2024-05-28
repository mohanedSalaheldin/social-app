import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.txt,
    required this.onPressed,
    this.backgoungColor,
    this.textColor = Colors.black,
    this.width,
  });

  final Color? textColor;
  final double? width;
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
        decoration: BoxDecoration(
          color: backgoungColor,
          borderRadius: BorderRadius.circular(80),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding:
                const MaterialStatePropertyAll(EdgeInsetsDirectional.symmetric(
              horizontal: 40.0,
              vertical: 5,
            )),
            backgroundColor: MaterialStatePropertyAll(
              backgoungColor ?? mainColor,
            ),
          ),
          // height: 60,

          child: Text(
            txt,
            style: TextStyle(
              height: 0.0,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
