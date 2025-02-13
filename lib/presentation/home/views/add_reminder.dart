import 'package:diary/core/exports.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:diary/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../controller/add_reminder_provider/add_reminder_provider.dart';
import '../controller/add_reminder_provider/add_reminder_state.dart';
import '../widgets/medicine_type_drop_down.dart';

class AddReminderPage extends ConsumerStatefulWidget {
  const AddReminderPage({super.key});

  @override
  ConsumerState<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends ConsumerState<AddReminderPage> {
  TextEditingController nameController = TextEditingController(), noteController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addReminderProvider = ref.watch(medicineReminderProvider);
    nameController.text = addReminderProvider.medicineName;
    DateTime now = DateTime.now();
    ref.listen<MedicineReminderState>(medicineReminderProvider, (_, state) {
      if (state is MedicineReminderDone) {
        Navigator.pop(context);
        ref.read(medicineReminderProvider.notifier).initalize();
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Medicine Reminder",
          style: TextStyles.montserratBold18,
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(D.xxl, D.xmd),
                padding: const EdgeInsets.all(0),
              ),
              onPressed: (addReminderProvider.medicineName.isEmpty || addReminderProvider.intakeCount == 0)
                  ? null
                  : () {
                      ref.read(medicineReminderProvider.notifier).addReminder();
                    },
              child: addReminderProvider is MedicineReminderLoading
                  ? const CupertinoActivityIndicator()
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
                xxsSpacer(),
                Padding(
                  padding: Paddings.horizontalXs,
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "${now.day},",
                            style: TextStyles.montserratBold22
                                .copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),
                            children: [
                              TextSpan(
                                  text: " ${DateFormat('MMMM').format(now)}, ${now.year},",
                                  style: TextStyles.montserrat13),
                              TextSpan(text: " ${now.hour}:${now.minute},", style: TextStyles.montserrat13),
                            ],
                          ),
                        ),
                      ),
                      const DropdownWithWrap(),
                    ],
                  ),
                ),
                Padding(
                  padding: Paddings.horizontalXs,
                  child: Text(
                    "Medicine name*",
                    style: TextStyles.robotoBold13,
                  ),
                ),
                xxxxsSpacer(),
                Padding(
                  padding: Paddings.horizontalXs,
                  child: CustomTextField(
                      style: TextStyles.robotoBold18,
                      hintText: "Ex: Paracitamol",
                      onChanged: (p0) {
                        ref.read(medicineReminderProvider.notifier).onChange(p0);
                      },
                      controller: nameController),
                ),
                xxsSpacer(),
                Padding(
                  padding: Paddings.horizontalXs,
                  child: Row(
                    children: [
                      Text(
                        "Medicine intake* ",
                        style: TextStyles.robotoBold13,
                      ),
                      xxxxsSpacer(),
                      const Icon(Icons.warning)
                    ],
                  ),
                ),
                xxsSpacer(),
                const IntakeNumber(),
                xxsSpacer(),
                addReminderProvider.intakeCount == 0
                    ? const SizedBox()
                    : Text(
                        textAlign: TextAlign.center,
                        addReminderProvider.intakeCount == 1
                            ? "I take this medicine one time a day"
                            : "I take this medicine ${addReminderProvider.intakeCount} times a day",
                        style: TextStyles.robotoBold13),
                xxxsSpacer(),
                addReminderProvider.intakeCount == 0
                    ? const SizedBox()
                    : Padding(
                        padding: Paddings.horizontalXs,
                        child: Text("I take this medicine at: ", style: TextStyles.robotoBold13),
                      ),
                Wrap(alignment: WrapAlignment.center, direction: Axis.horizontal, children: [
                  ...List.generate(
                      addReminderProvider.intakeCount,
                      (index) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                              side: BorderSide(color: Theme.of(context).cardColor, width: 1),
                              minimumSize: const Size(D.xxl, D.xlg),
                              maximumSize: const Size(D.xxxxxl, D.xxl),
                              padding: EdgeInsets.zero,
                              backgroundColor: AppColors.turquoise,
                              foregroundColor: AppColors.white),
                          onPressed: () {
                            ref.read(medicineReminderProvider.notifier).updateIntakeTime(index, context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.access_time),
                              xxxxxsSpacer(),
                              Text(addReminderProvider.intakeTimes[index].format(context)),
                            ],
                          )))
                ]),
                Padding(
                  padding: Paddings.horizontalXs,
                  child: Text(
                    "Notes:",
                    style: TextStyles.robotoBold13,
                  ),
                ),
                Padding(
                  padding: Paddings.allXs,
                  child: CustomTextField(
                    isParagraph: true,
                    hintText: "Enter a note",
                    maxLine: 5,
                    maxLength: 500,
                    onChanged: (p0) {
                      ref.read(medicineReminderProvider.notifier).onNoteChange(p0);
                    },
                    controller: noteController,
                  ),
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
