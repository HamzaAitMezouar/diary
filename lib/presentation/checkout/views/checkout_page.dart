import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/domain/entities/medicament_entity.dart';
import 'package:diary/presentation/checkout/controllers/checkout_provider.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exports.dart';
import '../widgets/animated_delvery_type.dart';
import '../widgets/delivery_schedule_type.dart';
import '../widgets/delivery_type_map.dart';
import '../widgets/make_order_button.dart';
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
      MedicamentEntity med = checkout.items.first.medicament;
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                "Checkout",
                style: TextStyles.robotoBold18,
              ),
            ),
            SliverPadding(
              padding: Paddings.horizontalXs,
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    checkout.items.length > 1
                        ? ExpansionTile(
                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                            expandedAlignment: Alignment.bottomLeft,
                            tilePadding: EdgeInsets.zero,
                            title: Text(
                              "Medicament: ",
                              style: TextStyles.robotoBold15,
                            ),
                            children: [
                              ...checkout.items.map(
                                (e) => Text(
                                  e.medicament.name,
                                  textAlign: TextAlign.start,
                                  style: TextStyles.montserratBold13,
                                ),
                              ),
                            ],
                          )
                        : Row(
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
                    const PriceSumamryWidget(),
                    xxxlSpacer(),
                    xxxlSpacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const Padding(
          padding: Paddings.horizontalXxxxs,
          child: MakeOrderButton(),
        ),
      );
    }
    return const SizedBox();
  }
}
