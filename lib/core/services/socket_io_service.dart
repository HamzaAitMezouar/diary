import 'dart:async';
import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket _socket;
  final StreamController<Map<String, dynamic>> _pharmacyStreamController = StreamController.broadcast();

  SocketService(String serverUrl) {
    _socket = io.io(
      serverUrl,
      io.OptionBuilder()
          .setTransports(['websocket']) // Use WebSockets
          .disableAutoConnect() // Manually control connection
          .build(),
    );
  }

  void connect(String userId) {
    _socket.connect();
    _socket.onConnect((_) {
      log("Connected to WebSocket!");
      _socket.emit("registerUser", userId); // Register user ID
    });

    _socket.onDisconnect((_) => log("Disconnected from WebSocket!"));
    _socket.on("pharmacy_accepted", (data) {
      log("Pharmacy accepted: $data");
      _pharmacyStreamController.add(Map<String, dynamic>.from(data));
    });
  }

  void listOfPharmacies() {
    // Listen for pharmacy accepting the order
    _socket.on("pharmacy_accepted", (data) {
      log("Pharmacy accepted: $data");
      _pharmacyStreamController.add(Map<String, dynamic>.from(data));
    });
  }

  void disconnect() {
    _socket.disconnect();
  }

  void emitOrderCreated({
    required String userId,
    required double latitude,
    required double longitude,
    required int orderId,
  }) {
    connect(userId); // Ensure connection
    _socket.emit("order", {
      "userId": userId,
      "latitude": latitude,
      "longitude": longitude,
      "orderId": orderId,
    });
  }

  void acceptOrder({
    required int orderId,
    required String userId,
    required int pharmacyId,
  }) {
    connect(userId); // Ensure connection
    _socket.emit("pharmacy_accept", {"orderId": orderId, "userId": userId, "pharmacyId": pharmacyId});
  }

  Stream<Map<String, dynamic>> get pharmacyStream => _pharmacyStreamController.stream;

  io.Socket get socket => _socket;
}
