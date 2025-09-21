import 'package:flutter/material.dart';
import '../theming/styles.dart';

class CustomPrice extends StatelessWidget {
  const CustomPrice({super.key, required this.price});

  final int price;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: 'EGP ',
        style: TextStylesManager.font14BlackRegular,
        children: [
          TextSpan(text: '$price', style: TextStylesManager.font16BlackMedium),
        ],
      ),
    );
  }
}
