import 'package:flutter/material.dart';

import '../../../core/exports.dart';

class WeekDaysHistory extends StatefulWidget {
  const WeekDaysHistory({
    super.key,
  });

  @override
  State<WeekDaysHistory> createState() => _WeekDaysHistoryState();
}

class _WeekDaysHistoryState extends State<WeekDaysHistory> {
  List<String> days = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...List.generate(
          7,
          (index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    days[index],
                    style: TextStyles.robotoBold10,
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: D.xs,
                      minWidth: D.xs,
                      maxHeight: D.sm,
                      maxWidth: D.sm,
                    ),
                    margin: const EdgeInsets.only(right: D.xxxxs),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(D.xxxxs), color: AppColors.grey),
                  ),
                ],
              )).toList()
    ]);
  }
}
