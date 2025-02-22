import 'dart:developer';
import 'dart:io';

import 'package:diary/core/constants/text_style.dart';
import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exports.dart';
import '../controllers/checkout_provider.dart';

class DeliveryScheduleType extends ConsumerWidget {
  const DeliveryScheduleType({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final checkout = ref.watch(checkoutProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Row(
            children: [
              ScheduleTypeCard(
                isActive: checkout!.deliveryschedule == Deliveryschedule.now,
                onTap: () {
                  ref.read(checkoutProvider.notifier).changeDeliveryScheduleType(Deliveryschedule.now);
                },
                subtitle: "As soon as Possible",
                title: "As soon as Possible",
              ),
              ScheduleTypeCard(
                isActive: checkout.deliveryschedule == Deliveryschedule.later,
                onTap: () async {
                  log("message");
                  if (checkout.deliveryschedule == Deliveryschedule.later) {
                    DateTime? time = await pickDateTime(context);
                    if (time == null) return;
                    ref.read(checkoutProvider.notifier).changeDeliveryTime(time);
                    return;
                  }
                  ref.read(checkoutProvider.notifier).changeDeliveryScheduleType(Deliveryschedule.later);
                  log("message");
                },
                subtitle: "Schedule a date and time",
                title: "Schedule",
              ),
            ],
          ),
        ),
        xxsSpacer(),
        (checkout.deliveryschedule == Deliveryschedule.later && checkout.deliveryTime != null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  xxsSpacer(),
                  Text(
                    "Deliver Date:",
                    style: TextStyles.robotoBold13,
                  ),
                  xxsSpacer(),
                  Text(
                    checkout.deliveryTime!.toIso8601String().replaceAll("T", " ").replaceAll(".000", ""),
                    style: TextStyles.roboto13,
                  ),
                ],
              )
            : SizedBox.shrink()
      ],
    );
  }
}

class ScheduleTypeCard extends StatelessWidget {
  const ScheduleTypeCard({
    super.key,
    required this.isActive,
    required this.onTap,
    required this.subtitle,
    required this.title,
  });

  final Function() onTap;
  final String title;
  final String subtitle;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isActive ? 10 : 8,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Durations.short2,
          padding: Paddings.horizontalXxxs,
          height: D.xl,
          margin: EdgeInsetsDirectional.only(end: 4),
          decoration: BoxDecoration(
            color: !isActive ? Theme.of(context).cardColor : null,
            borderRadius: BorderRadius.circular(8),
            gradient: !isActive
                ? null
                : LinearGradient(
                    colors: [AppColors.turquoise.withOpacity(0.8), AppColors.turquoise.withOpacity(0.4)],
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyles.robotoBold13.copyWith(color: !isActive ? null : AppColors.superDark),
                ),
              ),
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyles.roboto13.copyWith(
                    color: !isActive ? null : AppColors.superDark,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<DateTime?> pickDateTime(BuildContext context) async {
  if (!Platform.isAndroid) {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(hours: 1)),
      firstDate: DateTime.now().add(Duration(hours: 1)),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
    if (date == null) return null;
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return date;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  } else if (!Platform.isIOS) {
    DateTime? selectedDateTime = DateTime.now();
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).cardColor,
          height: 250,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: DateTime.now().add(Duration(hours: 1)),
                  minimumDate: DateTime.now(),
                  maximumDate: DateTime.now().add(Duration(days: 7)),
                  onDateTimeChanged: (DateTime dateTime) {
                    selectedDateTime = dateTime;
                  },
                ),
              ),
              CupertinoButton(
                child: Text(
                  "Done",
                  style: TextStyles.robotoBold15,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
    return selectedDateTime;
  }
  return null;
}
