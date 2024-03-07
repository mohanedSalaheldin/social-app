import 'package:flutter/material.dart';

class HorizentalGab extends StatelessWidget {
  const HorizentalGab({super.key, this.value = 15});
  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value,
    );
  }
}

class VerticalGab extends StatelessWidget {
  const VerticalGab({super.key, this.value = 15});
  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
    );
  }
}
