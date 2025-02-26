import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary/presentation/cart/controllers/cart_notifier.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:diary/widgets/info_diaog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/exports.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../domain/entities/medicament_entity.dart';

class CartItemWidget extends ConsumerWidget {
  const CartItemWidget({
    super.key,
    required this.med,
    required this.cartItem,
  });

  final MedicamentEntity med;
  final CartItemEntity cartItem;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: Paddings.horizontalXs,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: med.imageUrl ?? "",
                height: D.xxl,
                width: D.xxl,
                fit: BoxFit.cover,
                errorWidget: (_, err, child) {
                  return Image.asset(Assets.placeholder);
                },
              ),
              xsSpacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      med.name,
                      maxLines: 1,
                      style: TextStyles.montserratBold18,
                    ),
                    xxxxsSpacer(),
                    Text(
                      med.manufacturer.toString(),
                      maxLines: 1,
                      style: TextStyles.roboto13,
                    ),
                    Text(
                      med.presentation.toString(),
                      maxLines: 1,
                      style: TextStyles.roboto13,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      height: D.lg,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!)),
                      width: D.xxxxxl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (cartItem.quantity == 1) return;
                              ref
                                  .read(cartProvider.notifier)
                                  .updateMedicamentQuantityInCart(cartItem.id!, cartItem.quantity - 1);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: D.md,
                              child: Text(
                                "-",
                                maxLines: 1,
                                style: TextStyles.montserratBold15,
                              ),
                            ),
                          ),
                          Text(
                            cartItem.quantity.toString(),
                            maxLines: 1,
                            style: TextStyles.montserratBold13,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (cartItem.quantity == 20) return;
                              ref
                                  .read(cartProvider.notifier)
                                  .updateMedicamentQuantityInCart(cartItem.id!, cartItem.quantity + 1);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: D.md,
                              child: Text(
                                "+",
                                maxLines: 1,
                                style: TextStyles.montserratBold15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ConfirmActionDialog()
                            .showActionDialog(context, "Delete item from cart", "Do you want to delete this item", [
                          CustomButton(
                            onTap: () {
                              ref.read(cartProvider.notifier).removeMedicamentFromCart(cartItem.id!);
                              context.pop();
                            },
                            title: "Yes",
                            forgroundColor: AppColors.white,
                            style: TextStyles.montserratBold15,
                            backgorundColor: AppColors.red,
                          )
                        ]);
                      },
                      child: const Icon(
                        CupertinoIcons.delete,
                        color: AppColors.red,
                      ),
                    ),
                    xxlSpacer(),
                    Text(
                      "${(med.ppv * cartItem.quantity).toStringAsFixed(2)} MAD",
                      style: TextStyles.montserratBold15.copyWith(color: AppColors.turquoise),
                    )
                  ],
                ),
              )
            ],
          ),
          xxxsSpacer(),
          const Divider(
            endIndent: 5,
            indent: 5,
            thickness: 0.2,
          ),
        ],
      ),
    );
  }
}
