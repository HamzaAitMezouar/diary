import 'package:diary/core/exports.dart';
import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../controllers/checkout_provider.dart';

class PaymentMethodsWidget extends ConsumerWidget {
  const PaymentMethodsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final checkout = ref.watch(checkoutProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        xxsSpacer(),
        Text(
          "Payment methods: ",
          style: TextStyles.robotoBold18,
        ),
        xxxsSpacer(),
        PaymentTile(
          icon: CupertinoIcons.money_dollar,
          isSelected: checkout!.paymentType == PaymentType.cash,
          onTap: () {
            ref.read(checkoutProvider.notifier).changePaymentType(PaymentType.cash);
          },
          title: 'Pay With Cash',
        ),
        xxxsSpacer(),
        PaymentTile(
          icon: Icons.credit_card,
          isSelected: checkout.paymentType == PaymentType.card,
          onTap: () {
            ref.read(checkoutProvider.notifier).changePaymentType(PaymentType.card);
            showBarModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          height: 50,
                          backgorundColor: Theme.of(context).scaffoldBackgroundColor,
                          onTap: () {},
                          title: "Add a card",
                          // ignore: prefer_const_constructors
                          icon: Icon(Icons.credit_card),
                        ),
                      ],
                    ),
                  );
                });
          },
          title: 'Pay With Card',
        ),
      ],
    );
  }
}

class PaymentTile extends StatelessWidget {
  const PaymentTile(
      {super.key, required this.icon, required this.isSelected, required this.onTap, required this.title});
  final String title;
  final IconData icon;
  final Function() onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? AppColors.turquoise.withOpacity(0.9) : AppColors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: Borders.b12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: D.xxs, vertical: D.xxs),
          child: Row(
            children: [
              Icon(icon, color: !isSelected ? Theme.of(context).scaffoldBackgroundColor : null),
              xxxsSpacer(),
              Text(
                title,
                style: TextStyles.montserratBold13.copyWith(
                  color: !isSelected ? Theme.of(context).scaffoldBackgroundColor : null,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 10,
                color: !isSelected ? Theme.of(context).scaffoldBackgroundColor : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
