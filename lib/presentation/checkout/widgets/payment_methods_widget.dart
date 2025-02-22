import 'package:diary/core/exports.dart';
import 'package:flutter/material.dart';

class PaymentMethodsWidget extends StatelessWidget {
  const PaymentMethodsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        xxsSpacer(),
        Text(
          "Payment methods: ",
          style: TextStyles.robotoBold18,
        )
      ],
    );
  }
}
