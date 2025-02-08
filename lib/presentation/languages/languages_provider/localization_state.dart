import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationState extends Equatable {
  final Locale locale;
  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate<dynamic>> localizationsDelegates;
  const LocalizationState({
    required this.locale,
    this.supportedLocales = supportedLocalesList,
    this.localizationsDelegates = localizationsDelegatesList,
  });
  LocalizationState copyWith({Locale? locale}) => LocalizationState(locale: locale ?? this.locale);
  @override
  List<Object?> get props => [locale];
}

const List<Locale> supportedLocalesList = [
  Locale('en'),
  Locale('fr'),
  Locale('ar'),
];

const List<LocalizationsDelegate<dynamic>> localizationsDelegatesList = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
