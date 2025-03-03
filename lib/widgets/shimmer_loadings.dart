import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/exports.dart';

class ShimmerCarLoading extends StatelessWidget {
  const ShimmerCarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.tibbleGrauBg,
        highlightColor: AppColors.sofGrey,
        child: Container(
          height: D.xxl,
          decoration: BoxDecoration(
            borderRadius: Borders.b12,
            color: AppColors.activeButtonColor,
          ),
        ));
  }
}
