import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/exports.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? text;
  final bool isPassword;
  final bool isNumber;
  final bool isUsername;
  final bool? autocorrect;
  final String hintText;
  final Color? color;
  final int? maxLength;
  final String? prefixIcon;
  final bool isNext;
  final bool isExpanded;
  final TextAlignVertical? textAlignVertical;
  final Color? textInputColor;
  final Color? hintTextColor;
  final TextStyle? style;
  final Widget? suffix;
  final TextInputType? textInputType;
  final int? maxLine;
  final bool? autofocus;
  final double? height;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;

  const CustomTextField({
    super.key,
    required this.controller,
    this.text,
    this.isPassword = false,
    this.isNumber = false,
    this.isUsername = false,
    this.autocorrect,
    required this.hintText,
    this.color,
    this.maxLength,
    this.prefixIcon,
    this.isNext = false,
    this.isExpanded = false,
    this.textAlignVertical,
    this.textInputColor,
    this.hintTextColor,
    this.style,
    this.suffix,
    this.textInputType,
    this.maxLine,
    this.autofocus,
    this.height,
    this.onChanged,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 57,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color ?? AppColors.tibbleGrauBg,
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          style: style ?? TextStyles.montserratBold15,
          maxLength: maxLength,
          maxLines: maxLine ?? 1,
          keyboardType: textInputType ??
              (isUsername
                  ? TextInputType.text
                  : isNumber
                      ? TextInputType.number
                      : TextInputType.name),
          autofocus: autofocus ?? true,
          autocorrect: autocorrect ?? true,
          expands: isExpanded,
          textAlign: TextAlign.left,
          textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
          onChanged: onChanged,
          onFieldSubmitted: onSubmit,
          textInputAction: isNext ? TextInputAction.next : TextInputAction.done,
          obscureText: isPassword,
          decoration: InputDecoration(
            suffixIcon: suffix,
            prefixIcon: prefixIcon != null ? Image.asset(prefixIcon!, scale: 1) : null,
            isCollapsed: true,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(left: D.sm),
            hintStyle: TextStyles.montserrat15,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            isDense: true,
          ),
        ),
      ),
    );
  }
}
