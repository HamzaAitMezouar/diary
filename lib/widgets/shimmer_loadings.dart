import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/exports.dart';

class ShimmerCarLoading extends StatelessWidget {
  const ShimmerCarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
            baseColor: AppColors.tibbleGrauBg,
            highlightColor: AppColors.sofGrey,
            child: Container(
              height: D.xxxxl,
              decoration: BoxDecoration(
                borderRadius: Borders.b12,
                color: AppColors.activeButtonColor,
              ),
            )),
        Shimmer.fromColors(
            baseColor: AppColors.tibbleGrauBg,
            highlightColor: AppColors.sofGrey,
            child: Container(
              height: 15,
              width: 100,
              color: Colors.red,
            ))
      ],
    );
  }
}
