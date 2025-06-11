import 'package:flutter/material.dart';
import '../theme/app_text_style.dart';

class RowTimeDegree extends StatelessWidget {
  const RowTimeDegree({
    super.key,
    required this.text,
    required this.image,
    required this.timeOrTemp,
    this.color,
  });

  final String text;
  final String timeOrTemp;
  final String image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          scale: 8,
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: AppTextStyle.w300.copyWith(color: color),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              timeOrTemp,
              style: AppTextStyle.w700,
            ),
          ],
        ),
      ],
    );
  }
}
