import 'dart:math';

import 'package:diary/core/exports.dart';
import 'package:diary/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/add_reminder_provider/add_reminder_provider.dart';

class AddReminderPage extends ConsumerWidget {
  const AddReminderPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final addReminderProvider = ref.watch(medicineReminderProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                xxxxlSpacer(),
                Text(
                  "Here you can add a reminder",
                  textAlign: TextAlign.center,
                  style: TextStyles.montserratBold30,
                ),
                xsSpacer(),
                Padding(
                  padding: Paddings.allXs,
                  child: CustomTextField(
                      hintText: "Enter your Medicine name",
                      controller: TextEditingController(text: addReminderProvider.medicineName)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    xsSpacer(),
                    Text(
                      "How many time you take the medicine per day? ",
                      style: TextStyles.roboto13,
                    ),
                  ],
                ),
                xxxsSpacer(),
                IntakeNumber(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntakeNumber extends ConsumerWidget {
  const IntakeNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final addReminderProvider = ref.watch(medicineReminderProvider);
    List<int> toggleButtons = [
      1,
      2,
      3,
      4,
      5,
      6,
    ];
    int intakeCount = addReminderProvider.intakeCount;
    return Center(
      child: ToggleButtons(
        textStyle: TextStyles.montserrat13,
        isSelected: toggleButtons.map((e) => e == intakeCount).toList(),
        onPressed: (index) {
          ref.read(medicineReminderProvider.notifier).setIntakeCount(toggleButtons[index]);
        },
        children: toggleButtons.map((e) => Text(e.toString())).toList(),
      ),
    );
  }
}
