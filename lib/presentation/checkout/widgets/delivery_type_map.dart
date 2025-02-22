import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/presentation/checkout/widgets/map_and_address_card.dart';
import 'package:diary/presentation/checkout/widgets/nearest_pharmacy_map.dart';
import 'package:diary/presentation/medicine/controllers/location_provider/position_state.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/exports.dart';
import '../../../widgets/info_diaog.dart';
import '../../medicine/controllers/location_provider/position_provider.dart';
import '../controllers/checkout_provider.dart';

class DeliveryTypeMapWidget extends ConsumerWidget {
  const DeliveryTypeMapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final checkout = ref.watch(checkoutProvider);

    return AnimatedContainer(
        transformAlignment: Alignment.topCenter,
        duration: Durations.extralong1,
        height: checkout?.deliveryType == null ? 0 : D.xxxxxxl * 2,
        width: double.infinity,
        child: checkout?.deliveryType == DeliveryType.home
            ? const UserLocationMap()
            : checkout?.deliveryType == DeliveryType.pharmacy
                ? const NearestPharmacyMap()
                : const SizedBox());
  }
}

class UserLocationMap extends ConsumerStatefulWidget {
  const UserLocationMap({
    super.key,
  });

  @override
  ConsumerState<UserLocationMap> createState() => _UserLocationMapState();
}

class _UserLocationMapState extends ConsumerState<UserLocationMap> {
  @override
  Widget build(BuildContext context) {
    final position = ref.watch(positionProvider);

    if (position is UserLocationState) return const MapAddressCard();
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  AdaptiveDialogScreen()(
                      context,
                      "You did not allow location, you can choose the delivery location from map",
                      "Choose location from map");
                },
                icon: const Icon(Icons.info)),
            Expanded(
              child: CustomButton(
                height: D.xxl,
                onTap: () {
                  context.goNamed(RoutesNames.mapSearchPage);
                },
                title: "Enter Your Desired Location",
                style: TextStyles.montserratBold15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
