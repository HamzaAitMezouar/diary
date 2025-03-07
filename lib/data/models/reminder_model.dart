import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/entities/reminder_entity.dart';
import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

ReminderModel reminderModelFromJson(String str) => ReminderModel.fromJson(json.decode(str));

String reminderModelToJson(ReminderModel data) => json.encode(data.toJson());

@HiveType(typeId: 0, adapterName: 'ReminderModelAdapter')
class ReminderModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String medicineName;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final List<String> dosage;
  @HiveField(4)
  final String? notes;
  @HiveField(5)
  final bool isCompleted;
  @HiveField(6)
  final String icon;
  @HiveField(7)
  final List<DateTime> consumationDates;
  ReminderModel(
      {this.id,
      required this.medicineName,
      required this.time,
      required this.dosage,
      this.notes,
      this.isCompleted = false,
      required this.consumationDates,
      required this.icon});

  ReminderModel copyWith({bool? isCompleted, DateTime? consumationDate}) {
    return ReminderModel(
      icon: icon,
      id: id,
      medicineName: medicineName,
      isCompleted: isCompleted ?? this.isCompleted,
      time: time,
      dosage: dosage,
      consumationDates: consumationDate == null ? consumationDates : [...consumationDates, consumationDate],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicineName': medicineName,
      'time': time.toIso8601String(),
      'dosage': dosage,
      'notes': notes,
      'isCompleted': isCompleted,
      "consumationDates": consumationDates.map((e) => e.toIso8601String()).toList(),
      "icon": icon,
    };
  }

  // Convert Map to ReminderModel
  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'],
      medicineName: json['medicineName'],
      time: DateTime.parse(json['time']),
      dosage: json['dosage'],
      notes: json['notes'],
      isCompleted: json['isCompleted'] ?? false,
      consumationDates: json["consumationDates"].map((e) => DateTime.parse(e)).toList(),
      icon: json["icon"],
    );
  }

  List<TimeOfDay> convertStringListToTimeOfDayList(List<String> timeStrings) {
    return timeStrings.map((time) {
      final parts = time.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    }).toList();
  }

  // Convert Model to Entity
  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id,
      medicineName: medicineName,
      time: time,
      dosage: convertStringListToTimeOfDayList(dosage),
      notes: notes,
      isCompleted: isCompleted,
      consumationDates: consumationDates,
      icon: icon,
    );
  }
}
