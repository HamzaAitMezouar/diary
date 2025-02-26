import 'package:diary/presentation/orders/controllers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final orders = ref.watch(ordersProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList.builder(
              itemCount: orders.orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(orders.orders[index].totalAmount.toString()),
                  trailing: Text(orders.orders[index].status.name.toString()),
                );
              })
        ],
      ),
    );
  }
}
