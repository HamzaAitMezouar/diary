import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:diary/data/models/cart_model.dart';
import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/presentation/checkout/widgets/delivery_schedule_type.dart';

class OrdersParams {
  final List<CartItemModel> items;
  final String paymentMethod;
  final DeliveryDetails deliveryDetails;

  OrdersParams({
    required this.items,
    required this.paymentMethod,
    required this.deliveryDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((item) => item.toJson()).toList(), // Convert list of items
      "paymentType": paymentMethod,
      "deliveryDetails": deliveryDetails.toJson(), // Convert DeliveryDetails
    };
  }
}

class DeliveryDetails {
  final String address;
  final double lat;
  final double lang;
  final DeliveryType type;
  final Deliveryschedule schedule;
  final DateTime? date;

  DeliveryDetails({
    required this.address,
    required this.lat,
    required this.lang,
    required this.type,
    required this.schedule,
    this.date,
  });

  Map<String, dynamic> toJson() {
    log(lat.toString());
    return {
      "address": address,
      "lat": lat,
      "lang": lang,
      "type": type.name, // Convert enum to string
      "schedule": schedule.name, // Convert enum to string
      "date": date?.toIso8601String(), // Convert DateTime to string or null
    };
  }
}
