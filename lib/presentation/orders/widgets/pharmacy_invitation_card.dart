import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:diary/core/exports.dart';
import 'package:diary/presentation/medicine/controllers/position_provider/position_provider.dart';
import 'package:diary/presentation/medicine/controllers/position_provider/position_state.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helpers/calculate_distance_between_two_locations.dart';
import '../../../domain/entities/pharmacy_order.dart';
import '../controllers/pharmacies_request.dart';

class PharmacyInvitationCard extends ConsumerWidget {
  const PharmacyInvitationCard({
    super.key,
    required this.op,
  });

  final PharmacyOrderEntity op;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: D.xs, vertical: D.xxs),
      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: Borders.b12),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: Borders.b12,
                  child: Image.asset(
                    Assets.pharmacyPlaceholder,
                    height: D.xxxxl,
                    width: D.xxxxl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              xxsSpacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      op.pharmcay.name,
                      maxLines: 2,
                      style: TextStyles.montserratBold18,
                    ),
                    Text(
                      op.pharmcay.address.toString(),
                      maxLines: 1,
                      style: TextStyles.robotoBold10,
                    ),
                    Text(
                      op.order.subtotal.toString() + " MAD",
                      maxLines: 1,
                      style: TextStyles.robotoBold10.copyWith(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                ),
              ),
              Text(
                _distance(op),
                style: TextStyles.montserratBold13,
              ),
              xxxsSpacer()
            ],
          ),
          xxxsSpacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                onTap: () {
                  ref.watch(pharmacyNotifierProvider.notifier).accept(op, context);
                },
                title: "Accept",
                height: D.xlg,
                backgorundColor: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
              CustomButton(
                onTap: () {
                  ref.watch(pharmacyNotifierProvider.notifier).decline(
                        op,
                      );
                },
                title: "Decline",
                height: D.xlg,
                backgorundColor: Theme.of(context).colorScheme.error.withOpacity(0.8),
              ),
            ],
          ),
          xxxsSpacer(),
        ],
      ),
    );
  }

  String _distance(PharmacyOrderEntity op) {
    int distance = CalculateDistanceHelper()(
            op.pharmcay.latitude, op.pharmcay.longitude, op.order.deliveryLat, op.order.deliveryLng)
        .toInt();
    return (distance > 20000 || distance == 0)
        ? op.pharmcay.city
        : (distance >= 1000 && distance < 2000)
            ? "${(distance / 1000).toDouble().toStringAsFixed(1)} Km"
            : (distance >= 1000 && distance < 20000)
                ? "${distance ~/ 1000} km"
                : "${distance.toInt().toString()} m";
  }
}
