import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/domain/entities/medicament_entity.dart';
import 'package:diary/presentation/medicine/controllers/medicaments_categories_controller/categories_provider.dart';
import 'package:diary/presentation/medicine/controllers/medicaments_categories_controller/categories_state.dart';
import 'package:diary/presentation/medicine/controllers/medicaments_controller/medicament_provider.dart';
import 'package:diary/presentation/medicine/controllers/medicaments_controller/medicaments_state.dart';
import 'package:diary/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/exports.dart';
import '../../order_medicine/controller/selected_medecine_provider.dart';

class MedicineScreen extends ConsumerWidget {
  const MedicineScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        body: SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(medicamentProvider.notifier).loadMedicament();
          ref.read(categoryProvider.notifier).loadCategory();
          return;
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: Paddings.horizontalXs,
              sliver: SliverToBoxAdapter(
                  child: CustomTextField(
                controller: TextEditingController(),
                hintText: "Search",
                suffix: Icon(Icons.search),
              )),
            ),
            SliverToBoxAdapter(
              child: xsSpacer(),
            ),
            CategoriesPage(),
            SliverToBoxAdapter(
              child: xsSpacer(),
            ),
            MedicamentsPage()
          ],
        ),
      ),
    ));
  }
}

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final categoryState = ref.watch(categoryProvider);

    if (categoryState is CategoryLaoding) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: D.xxxxxl,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    if (categoryState is CategoryLoaded) {
      return SliverGrid.builder(
        itemCount: categoryState.categories.length,
        itemBuilder: (context, index) {
          return Container(
            height: D.xxxxxxl,
            width: D.xxxxxxl,
            decoration: BoxDecoration(
              borderRadius: Borders.b10,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(categoryState.categories[index].imageUrl ?? ""),
              ),
            ),
            margin: Paddings.horizontalXs,
            padding: Paddings.horizontalXs,
            child: Column(
              children: [
                Container(
                  height: D.xxxxxl,
                  width: D.xxxxxl,
                  decoration: BoxDecoration(
                    borderRadius: Borders.b10,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(categoryState.categories[index].imageUrl ?? ""),
                    ),
                  ),
                ),
                Container(
                  padding: Paddings.allXxxs,
                  decoration: BoxDecoration(borderRadius: Borders.b12),
                  child: Text(
                    categoryState.categories[index].name,
                    style: TextStyles.montserratBold13,
                  ),
                )
              ],
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
      );
    }
    return SliverToBoxAdapter(
        child: SizedBox(
      child: Text("Error"),
    ));
  }
}

class MedicamentsPage extends ConsumerWidget {
  const MedicamentsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final medicamentsState = ref.watch(medicamentProvider);

    if (medicamentsState is MedicamentLaoding) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: D.xxxxxl,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    if (medicamentsState is MedicamentLoaded) {
      return SliverList(
          delegate: SliverChildBuilderDelegate(
        childCount: medicamentsState.medicaments.length,
        (context, index) => MedicamentCard(medicament: medicamentsState.medicaments[index]),
      ));
    }
    if (medicamentsState is MedicamentError)
      return SliverToBoxAdapter(
          child: SizedBox(
        child: Text(medicamentsState.errorMessage),
      ));
    return SliverToBoxAdapter(
        child: SizedBox(
      child: Text("Error"),
    ));
  }
}

class MedicamentCard extends ConsumerWidget {
  const MedicamentCard({
    super.key,
    required this.medicament,
  });

  final MedicamentEntity medicament;

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedMedicineProvider.notifier).selectMedicine(medicament);
        context.goNamed(RoutesNames.orderMedicine);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: D.xs, vertical: D.xxxxs),
        decoration: BoxDecoration(
          borderRadius: Borders.b12,
          color: Theme.of(context).cardColor,
        ),
        padding: Paddings.allXxxxs,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleImageWidget(medicament: medicament),
            xsSpacer(),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  xsSpacer(),
                  Text(
                    medicament.manufacturer ?? "",
                    maxLines: 1,
                    style: TextStyles.roboto13.copyWith(fontSize: 10),
                  ),
                  Text(medicament.name,
                      overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyles.montserratBold13),
                  xxxsSpacer(),
                  Text(
                    medicament.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyles.roboto13.copyWith(fontSize: 10),
                  ),
                  xxsSpacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        medicament.ppv.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        maxLines: 3,
                        style: TextStyles.robotoBold13.copyWith(color: AppColors.black),
                      ),
                      xxxsSpacer(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ArticleImageWidget extends StatelessWidget {
  const ArticleImageWidget({
    super.key,
    required this.medicament,
  });

  final MedicamentEntity medicament;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Borders.b12,
      child: Image.network(
        medicament.imageUrl ?? "",
        height: D.xxxxxl * 1.8,
        width: D.xxxxxl * 1.8,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          return loadingProgress == null
              ? child
              : SizedBox(
                  height: D.xxxxxl * 1.8,
                  width: D.xxxxxl * 1.8,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: D.xxxxxl * 1.8,
            width: D.xxxxxl * 1.8,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Assets.placeholder), fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
