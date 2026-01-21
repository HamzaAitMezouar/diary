import 'package:diary/core/exports.dart';
import 'package:diary/presentation/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/cart_item_widget.dart';
import '../widgets/go_to_checkout_button.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartState = ref.watch(cartProvider);
    return (cartState == null || cartState.cartItems.isEmpty)
        ? const Scaffold(
            body: Text("Empty"),
          )
        : Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text(
                    "You have ${cartState.cartItems.length} items in your cart",
                    style: TextStyles.robotoBold15,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    endIndent: 5,
                    indent: 5,
                    thickness: 0.2,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: cartState.cartItems.length,
                    (context, index) {
                      final cartItem = cartState.cartItems[index];
                      final med = cartItem.medicament;
                      double totale = 0;
                      totale = totale + med.ppv * cartItem.quantity;
                      return CartItemWidget(med: med, cartItem: cartItem);
                    },
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: D.sm, vertical: D.xs),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyles.montserratBold15,
                        ),
                        Text(
                          "${ref.watch(cartProvider.notifier).totale().toStringAsFixed(2)} MAD",
                          style: TextStyles.montserratBold15,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: const GoToCheckoutButton());
  }
}
