import 'package:flutter/material.dart';

import '../core/exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.backgorundColor,
      this.forgroundColor,
      this.isLoading,
      this.loadingColor,
      this.style,
      this.height,
      this.border,
      this.icon});
  final Function() onTap;
  final String title;
  final Color? backgorundColor;
  final Color? forgroundColor;
  final TextStyle? style;
  final bool? isLoading;
  final Color? loadingColor;
  final Widget? icon;
  final double? height;
  final BorderRadius? border;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading == true ? null : onTap,
      child: Container(
        margin: Paddings.horizontalXxs,
        alignment: Alignment.center,
        height: height ?? D.xxxl,
        decoration: BoxDecoration(
          borderRadius: border ?? Borders.b12,
          color: backgorundColor ?? AppColors.tibbleGrauBg,
          border: Border.all(color: backgorundColor ?? AppColors.tibbleGrauBg),
        ),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : icon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: D.xs),
                        child: icon!,
                      ),
                      Text(title, style: style),
                      SizedBox(
                        width: D.xs,
                      )
                    ],
                  )
                : Padding(
                    padding: Paddings.horizontalXxs,
                    child: Text(title, style: style),
                  ),
      ),
    );
  }
}
