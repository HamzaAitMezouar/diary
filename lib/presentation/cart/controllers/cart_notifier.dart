import 'dart:developer';

import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:diary/domain/entities/cart_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<CartEntity> {
  Ref ref;
  CartNotifier(this.ref) : super(CartEntity(id: 0, userId: "")) {
    getCart();
  }

  void getCart() async {
    final res = await ref.watch(getCartUsecasesProvider)();
    res.fold((l) => log(l.errorMessage), (r) => state = r);
  }

  void addMedicamentToCart(CartItemEntity cartItemEntity) async {
    final res = await ref.watch(addMedicamentToCartUsecasesProvider)(cartItemEntity);
    res.fold((l) => log(l.errorMessage.toString()), (r) {
      state = r;
    });
  }

  void removeMedicamentFromCart(int id) async {
    final res = await ref.watch(removemredicamentFromCartUsecasesProvider)(id);
    res.fold((l) => null, (r) => state = r);
  }

  void updateMedicamentQuantityInCart(int id, int quantity) async {
    final res = await ref.watch(updateCartMedicamentQuantityUsecasesProvider)(id, quantity);
    res.fold((l) => null, (r) => state = r);
  }

  void clearCart() async {
    final res = await ref.watch(clearCartUsecasesProvider)();
    res.fold((l) => null, (r) => state = r);
  }

  double totale() => state.cartItems.fold(0, (sum, item) => sum + item.quantity * item.medicament.ppv);
}

final cartProvider = StateNotifierProvider<CartNotifier, CartEntity?>(
  (ref) => CartNotifier(ref),
);
