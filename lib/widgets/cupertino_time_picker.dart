import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/exports.dart';

class AppCupertinoTimePicker {
  static Future<TimeOfDay?> showCupertinoTimePicker(BuildContext context) async {
    TimeOfDay? selectedTime;

    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: D.xxxxxxl * 2.5,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            // Done Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  child: const Text("Done", style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    Navigator.pop(context, selectedTime);
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm, // Hours & Minutes
                onTimerDurationChanged: (Duration duration) {
                  selectedTime = TimeOfDay(
                    hour: duration.inHours,
                    minute: duration.inMinutes.remainder(60),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    return selectedTime; // Returns the selected time
  }
}
