import 'package:diary/core/exports.dart';
import 'package:diary/presentation/order_medicine/controller/selected_medecine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Product Description",
                style: TextStyles.robotoBold18,
              ),
              actions: [
                const Icon(Icons.card_membership),
                xxxsSpacer(),
              ],
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: D.xxxxxxl * 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(medicament.imageUrl ?? ""),
                        const Positioned(
                            right: D.xxxs,
                            top: D.xmd,
                            height: D.xl,
                            width: D.xl,
                            child: CircularButton(
                              child: Icon(Icons.favorite_border),
                            )),
                        const Positioned(
                            right: D.xxxs,
                            top: D.xxxxl + 2,
                            height: D.xl,
                            width: D.xl,
                            child: CircularButton(
                              child: Icon(Icons.share_outlined),
                            ))
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: Paddings.allXs,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          medicament.name,
                          style: TextStyles.montserratBold18,
                        ),
                        xxxxxsSpacer(),
                        Text(
                          medicament.manufacturer ?? "",
                          style:
                              TextStyles.robotoBold10.copyWith(color: Theme.of(context).primaryColor.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: Borders.b50),
        elevation: 5,
        child: Center(child: Padding(padding: Paddings.allXxxxs, child: child)));
  }
}
