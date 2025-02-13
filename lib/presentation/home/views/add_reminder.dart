import 'dart:math';

import 'package:diary/core/exports.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:diary/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
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
                      hintText: "Enter your Medicine name*",
                      controller: TextEditingController(text: addReminderProvider.medicineName)),
                ),
                Padding(
                  padding: Paddings.horizontalXs,
                  child: Text(
                    "How many time you take the medicine per day?* ",
                    style: TextStyles.robotoBold13,
                  ),
                ),
                xxxsSpacer(),
                IntakeNumber(),
                xxxsSpacer(),
                Text(
                    textAlign: TextAlign.center,
                    addReminderProvider.intakeCount == 1
                        ? "I take this medicine one time a day"
                        : "I take this medicine ${addReminderProvider.intakeCount} times a day",
                    style: TextStyles.robotoBold13),
                xxxsSpacer(),
                Padding(
                  padding: Paddings.horizontalXs,
                  child: Text("I take this medicine at: ", style: TextStyles.robotoBold13),
                ),
                Wrap(alignment: WrapAlignment.center, direction: Axis.horizontal, children: [
                  ...List.generate(
                      addReminderProvider.intakeCount,
                      (index) => TextButton.icon(
                          icon: Icon(Icons.access_time),
                          onPressed: () {
                            ref.read(medicineReminderProvider.notifier).updateIntakeTime(index, context);
                          },
                          label: Text(addReminderProvider.intakeTimes[index].format(context))))
                ]),
                Padding(
                  padding: Paddings.horizontalXs,
                  child: Text(
                    "You can add a specific note:",
                    style: TextStyles.robotoBold13,
                  ),
                ),
                Padding(
                  padding: Paddings.allXs,
                  child: CustomTextField(
                      isParagraph: true,
                      hintText: "Note",
                      maxLine: 5,
                      maxLength: 500,
                      controller: TextEditingController(text: addReminderProvider.note)),
                ),
                CustomButton(
                    backgorundColor: AppColors.error,
                    disableColor: AppColors.grauVollfarbe,
                    isDisabled: (addReminderProvider.medicineName.isEmpty && addReminderProvider.intakeCount == 0),
                    onTap: () {},
                    title: "Confirm reminder"),
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
