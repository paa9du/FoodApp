import 'package:ecommerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icons_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          Size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  color: Colors.greenAccent,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "4.5"),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "128"),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "Comments"),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconsAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Non-Veg",
                iconColor: Colors.redAccent),
            IconsAndTextWidget(
                icon: Icons.location_on,
                text: "1.9Kms",
                iconColor: Colors.greenAccent),
            IconsAndTextWidget(
                icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: Colors.red)
          ],
        ),
      ],
    );
  }
}
