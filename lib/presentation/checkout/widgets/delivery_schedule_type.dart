import 'dart:developer';
import 'dart:io';

import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
                  DateTime? time = await pickDateTime(context);
                  if (time == null) return;
                  ref.read(checkoutProvider.notifier).changeDeliveryTime(time);

                  ref.read(checkoutProvider.notifier).changeDeliveryScheduleType(Deliveryschedule.later);
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
                  Text(
                    "Deliver At:",
                    style: TextStyles.robotoBold13,
                  ),
                  xxsSpacer(),
                  Text(
                    DateFormat(
                      "d MMMM yyyy HH:mm",
                    ).format(checkout.deliveryTime!),
                    style: TextStyles.roboto13,
                  ),
                ],
              )
            : const SizedBox.shrink()
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
          margin: const EdgeInsetsDirectional.only(end: 4),
          decoration: BoxDecoration(
            color: !isActive ? Theme.of(context).cardColor.withOpacity(0.4) : null,
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
  if (Platform.isAndroid) {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(hours: 1)),
      firstDate: DateTime.now().add(const Duration(hours: 1)),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (date == null) return null;
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return date;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  } else if (Platform.isIOS) {
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
                  initialDateTime: DateTime.now().add(const Duration(hours: 1)),
                  minimumDate: DateTime.now(),
                  maximumDate: DateTime.now().add(const Duration(days: 7)),
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
