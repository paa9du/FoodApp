import 'package:ecommerce/utils/dimensions.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double Size;
  TextOverflow overFlow;
  BigText(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.Size = 0,
      this.overFlow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: Size == 0 ? Dimensions.font20 : Size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
