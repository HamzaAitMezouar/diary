import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/DI/socket_provider.dart';
import '../../../core/services/socket_io_service.dart';
import '../../authentication/controllers/auth_notifier.dart';
import '../../authentication/controllers/auth_state.dart';

class PharmacyNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final SocketService socketService;

  PharmacyNotifier(this.socketService) : super([]) {
    _listenToPharmacyStream();
  }

  void _listenToPharmacyStream() {
    socketService.pharmacyStream.listen((pharmacy) {
      if (!state.contains(pharmacy)) {
        state = [...state, pharmacy]; // Append without duplicates
      }
    });
  }
}

final pharmacyNotifierProvider = StateNotifierProvider<PharmacyNotifier, List<Map<String, dynamic>>>((ref) {
  final socketService = ref.watch(socketProvider);
  return PharmacyNotifier(socketService);
});
