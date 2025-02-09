import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpCooldownNotifier extends StateNotifier<int?> {
  OtpCooldownNotifier() : super(null); // Initially no cooldown

  int _attempts = 0; // Track OTP attempts
  Timer? _timer;

  /// Calculate cooldown time based on attempts
  int get _cooldownDuration {
    if (_attempts == 0) return 15; // First request: 15 sec
    if (_attempts == 1) return 30; // Second request: 30 sec
    return 60; // Third and above: 1 min
  }

  /// Start cooldown
  void startCooldown() {
    _attempts++; // Increase attempt count
    int cooldown = _cooldownDuration;

    state = cooldown; // Set initial countdown value
    _timer?.cancel(); // Cancel existing timer if any

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state != null && state! > 0) {
        state = state! - 1; // Decrease countdown
      } else {
        timer.cancel();
        state = null; // Cooldown finished
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Provider for managing OTP cooldown
final otpCooldownProvider = StateNotifierProvider<OtpCooldownNotifier, int?>((ref) {
  return OtpCooldownNotifier();
});
