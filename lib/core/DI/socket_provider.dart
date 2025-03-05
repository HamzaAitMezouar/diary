import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/socket_io_service.dart';

final socketProvider = Provider<SocketService>((ref) {
  log("CONNECT SUCKET");
  return SocketService("http://192.168.1.108:3040");
});

final orderControllerProvider = Provider<OrderController>((ref) {
  final socketService = ref.read(socketProvider);
  return OrderController(socketService);
});

class OrderController {
  final SocketService _socketService;

  OrderController(this._socketService);

  void placeOrder({
    required String userId,
    required double latitude,
    required double longitude,
    required int orderId,
  }) {
    _socketService.emitOrderCreated(
      userId: userId,
      latitude: latitude,
      longitude: longitude,
      orderId: orderId,
    );
  }
}
