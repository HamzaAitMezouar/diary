import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exports.dart';
import '../../../domain/entities/checkout_entity.dart';
import '../../medicine/controllers/position_provider/position_provider.dart';
import '../controllers/checkout_provider.dart';
import 'deliver_type_card.dart';

class AnimatedDeliveryType extends ConsumerWidget {
  const AnimatedDeliveryType({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final checkout = ref.watch(checkoutProvider);

    return AnimatedCrossFade(
        alignment: Alignment.centerLeft,
        firstChild: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TypeOfDeliveryWidget(
              title: "Deliver at home",
              image: Assets.delivery,
              onClick: () {
                ref.read(positionProvider.notifier).getUserLocation();
                ref.read(checkoutProvider.notifier).changeDeliveryType(DeliveryType.home);
              },
            ),
            xxsSpacer(),
            TypeOfDeliveryWidget(
              title: "Pick up at the pharmacy",
              image: Assets.pickup,
              onClick: () {
                ref.read(checkoutProvider.notifier).changeDeliveryType(DeliveryType.pharmacy);
              },
            ),
          ],
        ),
        secondChild: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                if (checkout?.deliveryType == DeliveryType.home) {
                  ref.read(checkoutProvider.notifier).changeDeliveryType(DeliveryType.pharmacy);
                  return;
                }
                ref.read(positionProvider.notifier).getUserLocation();
                ref.read(checkoutProvider.notifier).changeDeliveryType(DeliveryType.home);
              },
              child: Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  padding: const EdgeInsets.symmetric(horizontal: D.xxxs, vertical: D.xxxxs),
                  decoration: BoxDecoration(
                    borderRadius: Borders.b12,
                    color: Theme.of(context).cardColor,
                  ),
                  child: Text(
                      style: TextStyles.robotoBold10,
                      checkout?.deliveryType == DeliveryType.home ? "Pick up at the pharmacy" : "Deliver at home")),
            )
          ],
        ),
        crossFadeState: checkout!.deliveryType == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: Durations.extralong1);
  }
}
