import 'package:diary/core/exports.dart';
import 'package:flutter/material.dart';

class SettingsLoading extends StatelessWidget {
  const SettingsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Assets.settings,
        height: D.xl,
        width: D.xl,
        fit: BoxFit.cover,
      ),
    );
  }
}
