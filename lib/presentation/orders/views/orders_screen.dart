import 'dart:developer';

import 'package:diary/core/DI/socket_provider.dart';
import 'package:diary/core/constants/app_colors.dart';
import 'package:diary/core/extensions/conntext_extension.dart';
import 'package:diary/presentation/authentication/controllers/auth_notifier.dart';
import 'package:diary/presentation/authentication/controllers/auth_state.dart';
import 'package:diary/presentation/orders/controllers/order_provider.dart';
import 'package:diary/presentation/orders/controllers/orders_state.dart';
import 'package:diary/widgets/accept_or_refuse_order_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/pharmacies_request.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({
    super.key,
  });

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final pharmacies = ref.watch(pharmacyNotifierProvider);
    final orders = ref.watch(ordersProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(orders.orders.last.deliveryLat.toString()),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              LocationAndAdressinMap(
                address: orders.orders.last.deliveryAddress,
                lang: orders.orders.last.deliveryLat,
                lat: orders.orders.last.deliveryLng,
                height: context.height,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            top: 10,
            right: 0,
            left: 0,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
              child: ListView.builder(
                itemCount: pharmacies.length,
                itemBuilder: (_, index) => ListTile(title: Text(pharmacies[index].toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
