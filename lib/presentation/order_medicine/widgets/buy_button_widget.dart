import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/presentation/authentication/controllers/auth_state.dart';
import 'package:diary/presentation/authentication/views/authentication.dart';
import 'package:diary/presentation/checkout/controllers/checkout_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/exports.dart';
import '../../../widgets/custom_long_button.dart';
import '../../authentication/controllers/auth_notifier.dart';
import '../../checkout/views/checkout_page.dart';
import '../../medicine/controllers/location_provider/location_provider.dart';
import '../../medicine/controllers/location_provider/location_state.dart';
import '../controller/selected_medecine_provider.dart';

class BuyWidget extends ConsumerWidget {
  const BuyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authNotifierProvider);
    final medicament = ref.watch(selectedMedicineProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Text("Location:"),
          ],
        ),
        CustomButton(
          style: TextStyles.robotoBold13.copyWith(
            color: AppColors.white.withOpacity(0.9),
          ),
          backgorundColor: const Color.fromARGB(255, 9, 120, 90),
          onTap: () {
            if (authState is Authenticated) {
              Future.delayed(Duration.zero).then(
                (value) => ref.read(checkoutProvider.notifier).selectCheckout(
                      CheckoutEntity(medicament: medicament!),
                    ),
              );
              context.goNamed(RoutesNames.checkoutPgae);
              return;
            }
            showBarModalBottomSheet(
                context: context,
                builder: (context) {
                  return const AuthenticationScreen();
                });
          },
          title: "Buy now",
          height: D.xl,
        )
      ],
    );
  }
}
