import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:diary/core/params/orders_params.dart';
import 'package:diary/presentation/orders/controllers/orders_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ordersProvider = StateNotifierProvider<LocatioNotifier, OrdersState>(
  (ref) => LocatioNotifier(ref),
);

class LocatioNotifier extends StateNotifier<OrdersState> {
  Ref ref;
  LocatioNotifier(this.ref) : super(InitOrdersState([])) {
    getOrders();
  }

  Future<void> getOrders() async {
    state = OrdersLoadingState(state.orders);
    final res = await ref.read(getOrderUseCase)();
    state = await res.fold((l) => OrdersLoadingErrorState(state.orders, l.errorMessage), (r) async {
      return OrdersLoadedState(r);
    });
  }

  Future<void> addOrders(OrdersParams params) async {
    state = OrdersLoadingState(state.orders);
    final res = await ref.read(addOrderUseCase)(params);
    state = await res.fold((l) => OrdersAddingErrorState(state.orders, l.errorMessage), (r) async {
      return OrdersAddedSuccessState(r);
    });
  }
}
