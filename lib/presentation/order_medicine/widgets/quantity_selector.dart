import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/exports.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuanityButton(
          onClick: () {},
          child: Icon(CupertinoIcons.minus),
        ),
        xxxsSpacer(),
        Text(
          "1",
          style: TextStyles.robotoBold13.copyWith(fontSize: 15),
        ),
        xxxsSpacer(),
        QuanityButton(
          onClick: () {},
          child: Icon(CupertinoIcons.add),
        ),
        xxxsSpacer(),
      ],
    );
  }
}

class QuanityButton extends StatelessWidget {
  const QuanityButton({
    super.key,
    required this.child,
    required this.onClick,
  });
  final Function() onClick;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.turquoise,
          ),
          child: Center(child: child)),
    );
  }
}
