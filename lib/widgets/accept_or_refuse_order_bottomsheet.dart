import 'dart:developer';

import 'package:diary/core/DI/socket_provider.dart';
import 'package:diary/core/exports.dart';
import 'package:diary/core/extensions/conntext_extension.dart';
import 'package:diary/widgets/markers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../data/models/order_model.dart';
import '../presentation/map/controller/map_style_notifier.dart';
import 'custom_long_button.dart';

class AcceptOrRefuseOrderBottomSheet {
  call(
    BuildContext? context,
    OrderModel order,
  ) {
    if (context == null) return;

    double totale =
        order.cartItems.fold(0.0, (sum, item) => sum + item.quantity.toDouble() * item.medicament.ppv.toDouble());
    showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: context.height * .9,
          padding: Paddings.horizontalXs,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            children: [
              xsSpacer(),
              ExpansionTile(
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.bottomLeft,
                tilePadding: EdgeInsets.zero,
                title: Text(
                  "Medicament: ",
                  style: TextStyles.robotoBold15,
                ),
                children: [
                  ...order.cartItems.map(
                    (e) => Text(
                      e.medicament.name,
                      textAlign: TextAlign.start,
                      style: TextStyles.montserratBold13,
                    ),
                  ),
                ],
              ),
              xxsSpacer(),
              LocationAndAdressinMap(
                address: order.deliveryAddress,
                lang: order.deliveryLng,
                lat: order.deliveryLat,
              ),
              xxsSpacer(),
              Card(
                margin: EdgeInsets.zero,
                color: AppColors.turquoise.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: Borders.b10),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ...order.cartItems.map((e) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.medicament.name,
                                    style: TextStyles.montserratBold13,
                                  ),
                                  Text(
                                    "${(e.medicament.ppv * e.quantity).toStringAsFixed(2)} MAD",
                                    style: TextStyles.montserratBold15,
                                  ),
                                ],
                              );
                            }),
                            xxxsSpacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Delivery",
                                      style: TextStyles.montserratBold13,
                                    ),
                                    xxxxsSpacer(),
                                    const Icon(Icons.delivery_dining_rounded)
                                  ],
                                ),
                                Text(
                                  "${order.deliveryFee} MAD",
                                  style: TextStyles.montserratBold15.copyWith(),
                                ),
                              ],
                            ),
                            xxxsSpacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyles.montserratBold13,
                                ),
                                Text(
                                  "${(totale + order.deliveryFee).toStringAsFixed(2)} MAD",
                                  style: TextStyles.montserratBold15.copyWith(color: AppColors.quickRed),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      xxxsSpacer(),
                      Consumer(builder: (context, ref, child) {
                        return CustomButton(
                            onTap: () {
                              context.pop();
                              ref
                                  .read(socketProvider)
                                  .acceptOrder(orderId: order.id!, userId: order.userId, pharmacyId: 1);
                              //
                            },
                            title: "Accept");
                      }),
                      xxsSpacer(),
                      CustomButton(
                          onTap: () {
                            context.pop();
                          },
                          title: "Refuse"),
                      xlSpacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LocationAndAdressinMap extends ConsumerStatefulWidget {
  const LocationAndAdressinMap({super.key, required this.address, required this.lang, required this.lat, this.height});
  final double lat;
  final double lang;
  final String address;
  final double? height;
  @override
  ConsumerState<LocationAndAdressinMap> createState() => _LocationAndAdressinMapState();
}

class _LocationAndAdressinMapState extends ConsumerState<LocationAndAdressinMap> {
  List<Marker> markers = [];
  addMarker() async {
    final myMarker = await CustomMarkers.createMarker("assets/images/splash.png");
    markers.addAll([
      Marker(
        markerId: const MarkerId('order_address'),
        position: LatLng(widget.lat, widget.lang),
        icon: myMarker,
        zIndex: 7,
        infoWindow: InfoWindow(
          title: widget.address,
        ),
      ),
    ]);
    locateToAddressPositon();
    setState(() {});
  }

  GoogleMapController? _mapController;

  locateToAddressPositon() {
    LatLng ltl = LatLng(widget.lat, widget.lang);
    _mapController?.animateCamera(CameraUpdate.newLatLng(ltl));
  }

  @override
  void initState() {
    super.initState();
    addMarker();
  }

  @override
  Widget build(BuildContext context) {
    final mapStyle = ref.watch(mapStyleProvider);
    return Column(
      children: [
        SizedBox(
          height: widget.height ?? D.xxxxxl * 1.7,
          child: ClipRRect(
            borderRadius: Borders.b12,
            child: GoogleMap(
                style: mapStyle,
                compassEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapToolbarEnabled: false,
                zoomControlsEnabled: true,
                initialCameraPosition: CameraPosition(target: LatLng(widget.lat, widget.lang)),
                minMaxZoomPreference: const MinMaxZoomPreference(10, 35),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                onCameraMove: (position) {
                  // _lastCameraPosition = CameraPosition(target: LatLng(loc.latitude, loc.longitude));
                },
                markers: markers.toSet()),
          ),
        ),
        xxsSpacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Address :",
              style: TextStyles.robotoBold13,
            ),
            Expanded(
              child: Text(
                widget.address,
                style: TextStyles.roboto13,
              ),
            ),
          ],
        )
      ],
    );
  }
}
