import 'dart:developer';

import 'package:diary/core/DI/dio_provider.dart';
import 'package:diary/core/constants/app_colors.dart';
import 'package:diary/core/constants/dimensions.dart';
import 'package:diary/core/constants/paddings.dart';
import 'package:diary/core/constants/text_style.dart';
import 'package:diary/core/params/orders_params.dart';
import 'package:diary/data/models/cart_model.dart';
import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/presentation/authentication/controllers/auth_notifier.dart';
import 'package:diary/presentation/authentication/controllers/auth_state.dart';
import 'package:diary/presentation/checkout/widgets/delivery_schedule_type.dart';
import 'package:diary/presentation/medicine/controllers/position_provider/position_state.dart';
import 'package:diary/presentation/orders/controllers/order_provider.dart';
import 'package:diary/presentation/orders/controllers/orders_state.dart';
import 'package:diary/widgets/info_diaog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/routes_names.dart';
import '../../../widgets/custom_long_button.dart';
import '../../medicine/controllers/position_provider/position_provider.dart';
import '../controllers/checkout_provider.dart';

class MakeOrderButton extends ConsumerWidget {
  const MakeOrderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final position = ref.watch(positionProvider);
    final checkout = ref.watch(checkoutProvider);
    ref.listen(ordersProvider, (previous, next) {
      if (next is OrdersAddedSuccessState) {
        context.replaceNamed(RoutesNames.introPage);
        context.goNamed(RoutesNames.ordersPage);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          margin: Paddings.allXs,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Order made Successfully",
          ),
        ));
      }
    });
    bool checkIfLocationisValid() {
      log(position.toString());
      if (position is UserLocationState && checkout!.deliveryType == DeliveryType.home) return false;
      if (position is UserLocationState &&
          position.locationEntity.pharmacy != null &&
          checkout!.deliveryType == DeliveryType.pharmacy) return false;
      return true;
    }

    return CustomButton(
      onTap: () {
        ConfirmActionDialog().showActionDialog(
          context,
          "Confirm order",
          "Do you want to confirm this Order?",
          [
            xxsSpacer(),
            Consumer(builder: (context, ref, child) {
              final order = ref.watch(ordersProvider);
              return CustomButton(
                height: D.xxl,
                style: TextStyles.montserratBold15,
                backgorundColor: const Color.fromARGB(255, 21, 154, 118),
                onTap: () {
                  final authState = ref.watch(authNotifierProvider) as Authenticated;
                  final positionState = ref.watch(positionProvider) as UserLocationState;
                  ref.read(ordersProvider.notifier).addOrders(checkout!.toOrderParams(), authState.user,
                      positionState.locationEntity.latitude, positionState.locationEntity.longitude);
                },
                title: "Yes",
                isLoading: order is OrdersLoadingState,
              );
            }),
            xxsSpacer(),
          ],
        );
      },
      isDisabled: checkIfLocationisValid(),
      title: "Order your medicament",
      style: TextStyles.montserratBold15,
      backgorundColor: const Color.fromARGB(255, 21, 154, 118),
    );
  }
}
