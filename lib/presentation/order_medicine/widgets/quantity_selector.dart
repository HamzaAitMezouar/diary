import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exports.dart';
import '../controller/selected_medecine_provider.dart';

class QuantitySelector extends ConsumerWidget {
  const QuantitySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final medicament = ref.watch(selectedMedicineProvider);

    return Row(
      children: [
        QuanityButton(
          color: medicament?.selectedQuantiy == 1 ? AppColors.grey : null,
          onClick: medicament?.selectedQuantiy == 1
              ? null
              : () {
                  ref.read(selectedMedicineProvider.notifier).changeQuantity(medicament!.selectedQuantiy - 1);
                },
          child: Icon(CupertinoIcons.minus),
        ),
        xxxsSpacer(),
        Text(
          medicament!.selectedQuantiy.toString(),
          style: TextStyles.robotoBold13.copyWith(fontSize: 15),
        ),
        xxxsSpacer(),
        QuanityButton(
          color: medicament.selectedQuantiy == 20 ? AppColors.grey : null,
          onClick: medicament.selectedQuantiy == 20
              ? null
              : () {
                  ref.read(selectedMedicineProvider.notifier).changeQuantity(medicament.selectedQuantiy + 1);
                },
          child: Icon(CupertinoIcons.add),
        ),
        xxxsSpacer(),
      ],
    );
  }
}

class QuanityButton extends StatelessWidget {
  const QuanityButton({
    super.key,
    required this.child,
    required this.onClick,
    this.color,
  });
  final Function()? onClick;
  final Widget child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color ?? AppColors.turquoise,
          ),
          child: Center(child: child)),
    );
  }
}
