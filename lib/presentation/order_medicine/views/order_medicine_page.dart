import 'dart:developer';

import 'package:diary/core/exports.dart';
import 'package:diary/domain/entities/cart_entity.dart';
import 'package:diary/presentation/cart/controllers/cart_notifier.dart';
import 'package:diary/presentation/order_medicine/controller/selected_medecine_provider.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/buy_button_widget.dart';
import '../widgets/circular_buttons.dart';
import '../widgets/price_details.dart';
import '../widgets/product_appbar.dart';

class OrderMedicinePage extends ConsumerWidget {
  const OrderMedicinePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final medicament = ref.watch(selectedMedicineProvider);
    return medicament == null
        ? const Scaffold(
            body: Center(
              child: Text("ERROR"),
            ),
          )
        : Scaffold(
            body: CustomScrollView(
              slivers: [
                const ProductDescriptionAppBar(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: D.xxxxxxl * 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [Image.network(medicament.imageUrl ?? ""), const LikeButton(), const ShareButton()],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: Paddings.allXs,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          '${medicament.name} / ${medicament.presentation}',
                          style: TextStyles.montserratBold18,
                        ),
                        xxxxxsSpacer(),
                        Text(
                          medicament.manufacturer ?? "",
                          style:
                              TextStyles.robotoBold10.copyWith(color: Theme.of(context).primaryColor.withOpacity(0.8)),
                        ),
                        PriceDetailsWidget(medicament: medicament),
                        const Divider(
                          height: D.xmd,
                          thickness: 0.2,
                        ),
                        xxxsSpacer(),
                        const BuyWidget(),
                        const Divider(
                          height: D.xmd,
                          thickness: 0.2,
                        ),
                        Text(
                          "Description",
                          style: TextStyles.robotoBold13,
                        ),
                        xxxsSpacer(),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                          style: TextStyles.roboto13,
                        ),
                        xxxxlSpacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              height: D.xxxxl + 5,
              child: Card(
                surfaceTintColor: AppColors.transparent,
                color: Theme.of(context).scaffoldBackgroundColor,
                elevation: 3,
                child: Padding(
                  padding: Paddings.allXxs,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "2 items",
                            style: TextStyles.robotoBold13.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "selected",
                            textAlign: TextAlign.end,
                            style: TextStyles.roboto13.copyWith(fontSize: 10, height: 0.5),
                          )
                        ],
                      ),
                      CustomButton(
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.white.withOpacity(0.9),
                          ),
                          style: TextStyles.robotoBold13.copyWith(
                            color: AppColors.white.withOpacity(0.9),
                          ),
                          backgorundColor: const Color.fromARGB(255, 9, 120, 90),
                          onTap: () {
                            ref.read(cartProvider.notifier).addMedicamentToCart(
                                  CartItemEntity(
                                      id: medicament.id!, medicament: medicament, quantity: medicament.selectedQuantiy),
                                );
                          },
                          title: " Add To Cart")
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
