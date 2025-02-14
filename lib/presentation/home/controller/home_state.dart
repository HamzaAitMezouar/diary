import 'package:diary/domain/entities/reminder_entity.dart';
import 'package:flutter/material.dart';

/// 📌 Base State Model
abstract class HomeState {
  const HomeState();
}

/// 📌 Loading State
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// 📌 Error State
class HomeError extends HomeState {
  final String errorMessage;
  const HomeError(this.errorMessage);
}

/// 📌 Loaded State (Holds the list of reminders)
class HomeLoaded extends HomeState {
  final List<ReminderEntity> reminders;
  const HomeLoaded(this.reminders);
}
