import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../core/exports.dart';
import '../controllers/phone_number_provider.dart';

class PhoneNumberTextField extends ConsumerWidget {
  const PhoneNumberTextField({super.key});

  @override
  Widget build(BuildContext context, ref) {
    PhoneNumber phoneNumber = ref.watch(phoneNumberProvider);

    return Padding(
      padding: Paddings.horizontalXxs,
      child: Container(
        height: D.xxl,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: Borders.b20,
          color: AppColors.tibbleGrauBg,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: D.xs),
          child: InternationalPhoneNumberInput(
            textStyle: TextStyles.montserrat13,
            countries: const ["MA"],
            selectorTextStyle: TextStyles.montserrat13,
            onInputChanged: (PhoneNumber number) {
              ref.read(phoneNumberProvider.notifier).state = number;
            },
            autoFocus: false,
            ignoreBlank: true,
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
              useBottomSheetSafeArea: true,
              leadingPadding: 0,
              trailingSpace: false,
            ),
            textFieldController: TextEditingController(),
            countrySelectorScrollControlled: false,
            selectorButtonOnErrorPadding: 0.0,
            spaceBetweenSelectorAndTextField: 0.0,
            keyboardType: const TextInputType.numberWithOptions(),
            inputBorder: InputBorder.none,
            cursorColor: AppColors.white,
            hintText: "Enter your Phone Number",
            inputDecoration: InputDecoration(
              labelStyle: TextStyles.montserrat13,
              prefixStyle: TextStyles.montserrat13,
              suffixStyle: TextStyles.montserrat13,
              helperStyle: TextStyles.montserrat13,
              hintStyle: TextStyles.montserrat13,
              counterStyle: TextStyles.montserrat13,
              floatingLabelStyle: TextStyles.montserrat13,
              isCollapsed: true,
              hintText: "Enter your Phone Number",
              contentPadding: const EdgeInsets.only(left: D.sm),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              isDense: true,
            ),
            onSaved: (PhoneNumber number) {},
          ),
        ),
      ),
    );
  }
}
