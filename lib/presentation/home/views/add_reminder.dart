import 'dart:math';

import 'package:diary/core/exports.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:diary/widgets/custom_text_field.dart';
import 'package:diary/widgets/loading_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/add_reminder_provider/add_reminder_provider.dart';
import '../controller/add_reminder_provider/add_reminder_state.dart';

class AddReminderPage extends ConsumerWidget {
  const AddReminderPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final addReminderProvider = ref.watch(medicineReminderProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medicine Reminder",
          style: TextStyles.montserratBold18,
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(D.xxl, D.xmd),
                  padding: EdgeInsets.all(0),
                  backgroundColor: AppColors.turquoise,
                  foregroundColor: AppColors.white),
              onPressed: (addReminderProvider.medicineName.isEmpty && addReminderProvider.intakeCount == 0)
                  ? null
                  : () {
                      ref.read(medicineReminderProvider.notifier).addReminder();
                    },
              child: addReminderProvider is MedicineReminderLoading
                  ? CupertinoActivityIndicator()
                  : Text(
                      "Save",
                      style: TextStyles.roboto13,
                    )),
          xxxsSpacer(),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                xsSpacer(),
                Padding(
                  padding: Paddings.allXs,
                  child: CustomTextField(
                      hintText: "Enter your Medicine name*",
                      onChanged: (p0) {
                        ref.read(medicineReminderProvider.notifier).onChange(p0);
                      },
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
                Wrap(spacing: D.xxxs, alignment: WrapAlignment.center, direction: Axis.horizontal, children: [
                  ...List.generate(
                      addReminderProvider.intakeCount,
                      (index) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: Borders.b12),
                              minimumSize: Size(D.xxl, D.xlg),
                              maximumSize: Size(D.xxxxxl, D.xxl),
                              padding: EdgeInsets.zero,
                              backgroundColor: AppColors.turquoise,
                              foregroundColor: AppColors.white),
                          onPressed: () {
                            ref.read(medicineReminderProvider.notifier).updateIntakeTime(index, context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time),
                              xxxxxsSpacer(),
                              Text(addReminderProvider.intakeTimes[index].format(context)),
                            ],
                          )))
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
                      color: Theme.of(context).scaffoldBackgroundColor,
                      controller: TextEditingController(text: addReminderProvider.note)),
                ),
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
        selectedColor: AppColors.white,
        fillColor: AppColors.turquoise,
        borderRadius: Borders.b12,
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
