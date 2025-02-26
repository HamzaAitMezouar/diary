import 'package:diary/presentation/checkout/controllers/checkout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exports.dart';

class PriceSumamryWidget extends ConsumerWidget {
  const PriceSumamryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final checkout = ref.watch(checkoutProvider);
    return Banner(
      textStyle: TextStyles.robotoBold10,
      message: "${checkout!.items.length} ${checkout.items.length == 1 ? "Item" : "Items"}",
      location: BannerLocation.topEnd,
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColors.turquoise.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: Borders.b10),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ...checkout.items.map((e) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.medicament.name,
                            style: TextStyles.montserratBold13,
                          ),
                          Text(
                            "${(e.medicament.ppv * e.quantity).toStringAsFixed(2)} MAD",
                            style: TextStyles.montserratBold15,
                          ),
                        ],
                      );
                    }),
                    xxxsSpacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Delivery",
                              style: TextStyles.montserratBold13,
                            ),
                            xxxxsSpacer(),
                            const Icon(Icons.delivery_dining_rounded)
                          ],
                        ),
                        Text(
                          "${10} MAD",
                          style: TextStyles.montserratBold15.copyWith(),
                        ),
                      ],
                    ),
                    xxxsSpacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyles.montserratBold13,
                        ),
                        Text(
                          "${ref.read(checkoutProvider.notifier).totale().toStringAsFixed(2)} MAD",
                          style: TextStyles.montserratBold15.copyWith(color: AppColors.quickRed),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              xxxsSpacer(),
            ],
          ),
        ),
      ),
    );
  }
}
