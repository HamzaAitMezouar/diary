import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/DI/socket_provider.dart';
import '../../../core/services/socket_io_service.dart';
import '../../../domain/entities/pharmacy_order.dart';
import '../../authentication/controllers/auth_notifier.dart';
import '../../authentication/controllers/auth_state.dart';

class PharmacyNotifier extends StateNotifier<List<PharmacyOrderEntity>> {
  final SocketService socketService;

  PharmacyNotifier(this.socketService) : super([]) {
    _listenToPharmacyStream();
  }

  void _listenToPharmacyStream() {
    socketService.pharmacyStream.listen((pharmacy) {
      try {
        PharmacyOrderEntity pharmacyOrderEntity = PharmacyOrderEntity.fromJson(pharmacy);

        if (!state.any((oP) => oP.pharmcay.id == pharmacyOrderEntity.pharmcay.id)) {
          state = {...state, pharmacyOrderEntity}.toList(); // Append without duplicates
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }

  @override
  void dispose() {
    log("DISPOSE ORDERS");
    socketService.disconnect();
    state = []; // Clear the state
    super.dispose();
  }

  void decline(PharmacyOrderEntity op) {
    state = state.where((element) => element.pharmcay.id != op.pharmcay.id).toList();
  }

  accept() {}
}

final pharmacyNotifierProvider = StateNotifierProvider.autoDispose<PharmacyNotifier, List<PharmacyOrderEntity>>(
  (ref) {
    final socketService = ref.watch(socketProvider);
    return PharmacyNotifier(socketService);
  },
);
