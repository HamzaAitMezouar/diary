import 'package:dio/dio.dart';

// abstract class CartRemoteDatasource {
//   Future<Response> addMedicament(String medicamentId, int quantity);
//   Future<Response> removeMedicament(String medicamentId);
//   Future<Response> updateMedicamentQuantity(String medicamentId, int quantity);
// }

class CartRemoteDatasource {
  final Dio dio;

  CartRemoteDatasource(this.dio);

  Future<Response> addMedicament(String medicamentId, int quantity) async {
    try {
      return await dio.post(
        '/cart/add',
        data: {'medicamentId': medicamentId, 'quantity': quantity},
      );
    } catch (e) {
      throw Exception('Failed to add medicament: \$e');
    }
  }

  Future<Response> removeMedicament(String medicamentId) async {
    try {
      return await dio.post(
        '/cart/remove',
        data: {'medicamentId': medicamentId},
      );
    } catch (e) {
      throw Exception('Failed to remove medicament: \$e');
    }
  }

  Future<Response> updateMedicamentQuantity(String medicamentId, int quantity) async {
    try {
      return await dio.post(
        '/cart/update-quantity',
        data: {'medicamentId': medicamentId, 'quantity': quantity},
      );
    } catch (e) {
      throw Exception('Failed to update quantity: \$e');
    }
  }

  Future<Response> clearCart() async {
    try {
      return await dio.post('/cart/clear');
    } catch (e) {
      throw Exception('Failed to clear cart: \$e');
    }
  }

  Future<Response> getCart() async {
    try {
      return await dio.get('/cart');
    } catch (e) {
      throw Exception('Failed to fetch cart: \$e');
    }
  }
}
