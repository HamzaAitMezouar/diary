import 'package:diary/presentation/authentication/controllers/auth_notifier.dart';
import 'package:diary/presentation/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/exports.dart';
import '../../../core/routes/routes_names.dart';
import '../../../domain/entities/checkout_entity.dart';
import '../../../widgets/custom_long_button.dart';
import '../../authentication/controllers/auth_state.dart';
import '../../authentication/views/authentication.dart';
import '../../checkout/controllers/checkout_provider.dart';

class GoToCheckoutButton extends ConsumerWidget {
  const GoToCheckoutButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authNotifierProvider);
    final cart = ref.watch(cartProvider);
    return CustomButton(
      style: TextStyles.robotoBold13.copyWith(
        color: AppColors.white.withOpacity(0.9),
      ),
      backgorundColor: const Color.fromARGB(255, 9, 120, 90),
      onTap: () {
        if (authState is Authenticated) {
          Future.delayed(Duration.zero).then(
            (value) => ref.read(checkoutProvider.notifier).selectCheckout(
                  CheckoutEntity(items: cart!.cartItems),
                ),
          );
          context.pushNamed(RoutesNames.checkoutPgae);
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
    );
  }
}
