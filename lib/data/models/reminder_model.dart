import '../../domain/entities/reminder_entity.dart';

class ReminderModel extends ReminderEntity {
  ReminderModel({
    required super.id,
    required super.medicineName,
    required super.time,
    required super.dosage,
    super.notes,
    super.isCompleted,
  });

  // Convert ReminderModel to a Map (for JSON or local storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicineName': medicineName,
      'time': time.toIso8601String(),
      'dosage': dosage,
      'notes': notes,
      'isCompleted': isCompleted,
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
    );
  }

  // Convert Model to Entity
  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id,
      medicineName: medicineName,
      time: time,
      dosage: dosage,
      notes: notes,
      isCompleted: isCompleted,
    );
  }
}
