import 'package:flutter/material.dart';

import '../../../core/exports.dart';

class ProductDescriptionAppBar extends StatelessWidget {
  const ProductDescriptionAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      title: Text(
        "Product Description",
        style: TextStyles.robotoBold18,
      ),
      actions: [
        const Icon(
          Icons.shopping_cart_outlined,
        ),
        xxsSpacer(),
      ],
    );
  }
}
