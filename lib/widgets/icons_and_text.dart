import 'package:ecommerce/utils/dimensions.dart';
import 'package:ecommerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconsAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;
  const IconsAndTextWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize16,
        ),
        SizedBox(
          width: 2,
        ),
        SmallText(
          text: text,
        ),
      ],
    );
  }
}
