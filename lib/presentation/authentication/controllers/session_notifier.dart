import 'package:diary/core/DI/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionNotifier extends StateNotifier<bool> {
  Ref ref;

  SessionNotifier(this.ref) : super(false);

  Future<void> sessionExpired() async {
    state = true;
  }

  Future<void> resetSession() async {
    await ref.watch(secureStorageHelperProvider).clearTokens();
    state = false;
  }
}

// Riverpod Provider
final sessionProvider = StateNotifierProvider<SessionNotifier, bool>((ref) {
  return SessionNotifier(ref);
});
