import 'package:flutter/material.dart';

import '../../../core/exports.dart';

class TypeOfDeliveryWidget extends StatelessWidget {
  const TypeOfDeliveryWidget({super.key, required this.image, required this.onClick, required this.title});
  final String image;
  final String title;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: D.xxxxxxl,
        width: D.xxxxxxl,
        decoration: BoxDecoration(
            borderRadius: Borders.b12,
            color: const Color.fromARGB(255, 234, 235, 238),
            border: Border.all(color: Colors.transparent, width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(image),
              height: D.xxl,
              width: D.xxl,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.robotoBold10,
            )
          ],
        ),
      ),
    );
  }
}
