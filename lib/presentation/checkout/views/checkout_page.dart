import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/domain/entities/medicament_entity.dart';
import 'package:diary/presentation/checkout/controllers/checkout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exports.dart';
import '../widgets/animated_delvery_type.dart';
import '../widgets/delivery_schedule_type.dart';
import '../widgets/delivery_type_map.dart';
import '../widgets/payment_methods_widget.dart';
import '../widgets/payment_summary_widget.dart';

class CheckoutPage extends ConsumerWidget {
  const CheckoutPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final checkout = ref.watch(checkoutProvider);
    if (checkout != null) {
      MedicamentEntity med = checkout.medicament;
      return Material(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: Paddings.allXs,
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Center(
                      child: Text(
                        "Checkout",
                        style: TextStyles.robotoBold18,
                      ),
                    ),
                    xxxsSpacer(),
                    Row(
                      children: [
                        Text(
                          "Medicament: ",
                          style: TextStyles.robotoBold13,
                        ),
                        Expanded(
                          child: Text(
                            med.name,
                            style: TextStyles.robotoBold18,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Delivery Details",
                      style: TextStyles.robotoBold15,
                    ),
                    checkout.deliveryType == null ? xxsSpacer() : const SizedBox(),
                    const AnimatedDeliveryType(),
                    const DeliveryTypeMapWidget(),
                    xxxsSpacer(),
                    checkout.deliveryType == DeliveryType.home ? const DeliveryScheduleType() : const SizedBox(),
                    const PaymentMethodsWidget(),
                    xxxsSpacer(),
                    const PriceSumamryWidget()
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
