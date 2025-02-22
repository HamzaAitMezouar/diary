import 'package:flutter/material.dart';

import '../../../core/exports.dart';
import '../../../domain/entities/medicament_entity.dart';
import 'quantity_selector.dart';

class PriceDetailsWidget extends StatelessWidget {
  const PriceDetailsWidget({
    super.key,
    required this.medicament,
  });

  final MedicamentEntity medicament;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.turquoise.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: Borders.b10),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(1.5),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: Borders.b10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Unit price",
                          style: TextStyles.montserratBold13,
                        ),
                        Text(
                          "${medicament.ppv} MAD",
                          style: TextStyles.montserratBold15,
                        ),
                      ],
                    ),
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
                          "${(medicament.selectedQuantiy * medicament.ppv).toStringAsFixed(2)} MAD",
                          style: TextStyles.montserratBold15.copyWith(color: AppColors.quickRed),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            xxxsSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: Paddings.horizontalXxxs,
                  child: Text(
                    "Select quantity",
                    style: TextStyles.montserratBold13,
                  ),
                ),
                const QuantitySelector(),
              ],
            ),
            xxxsSpacer(),
          ],
        ),
      ),
    );
  }
}
