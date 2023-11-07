import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double Size;
  double height;
  SmallText({
    super.key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.Size = 12,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Size,
        height: height,
      ),
    );
  }
}
