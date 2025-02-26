import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/presentation/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/exports.dart';

class ProductDescriptionAppBar extends ConsumerWidget {
  const ProductDescriptionAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final cart = ref.watch(cartProvider);
    return SliverAppBar(
      centerTitle: true,
      title: Text(
        "Product Description",
        style: TextStyles.robotoBold18,
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.pushNamed(RoutesNames.cartPage);
          },
          icon: Badge(
              isLabelVisible: cart?.cartItems.isNotEmpty ?? false,
              label: Text(cart?.cartItems.length.toString() ?? ""),
              child: const Icon(
                Icons.shopping_cart_outlined,
              )),
        ),
        xxsSpacer(),
      ],
    );
  }
}
