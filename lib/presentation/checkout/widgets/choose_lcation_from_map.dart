import 'dart:developer';
import 'dart:io';

import 'package:diary/core/constants/app_colors.dart';
import 'package:diary/core/constants/paddings.dart';
import 'package:diary/domain/entities/location_entity.dart';
import 'package:diary/presentation/checkout/controllers/checkout_provider.dart';
import 'package:diary/presentation/medicine/controllers/location_provider/position_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../map/controller/map_style_notifier.dart';
import '../../medicine/controllers/location_provider/position_provider.dart';

class MapLocationPicker extends ConsumerStatefulWidget {
  const MapLocationPicker({
    super.key,
    this.latLng,
  });

  @override
  ConsumerState<MapLocationPicker> createState() => _MapLocationPickerState();
  final LatLng? latLng;
}

class _MapLocationPickerState extends ConsumerState<MapLocationPicker> {
  late GoogleMapController _mapController;
  LatLng _selectedLocation = const LatLng(37.7749, -122.4194); // Default: San Francisco
  String _address = "Enter address or move the marker";

  final DraggableScrollableController _sheetController = DraggableScrollableController();
  final TextEditingController _textController = TextEditingController();

  void _expandBottomSheet() {
    _sheetController.animateTo(
      1.0, // Fully open (1.0 = full screen height)
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void didChangeDependencies() {
    _getCurrentLocation();
    super.didChangeDependencies();
  }

  @override
  initState() {
    super.initState();
  }

  Future<void> _getCurrentLocation() async {
    if (widget.latLng != null) {
      _selectedLocation = widget.latLng!;
      _updateAddress(widget.latLng!);
      _mapController.animateCamera(CameraUpdate.newLatLng(widget.latLng!));
      setState(() {});

      return;
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
    });

    _updateAddress(_selectedLocation);
    _mapController.animateCamera(CameraUpdate.newLatLng(_selectedLocation));
  }

  // 📌 Reverse Geocoding (LatLng → Address)
  Future<void> _updateAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _address = "${place.street}, ${place.locality}, ${place.country}";
          _selectedLocation = position;
        });
      }
      _mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            position.latitude,
            position.longitude,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _address = "Failed to get address";
      });
    }
  }

  // // 📌 Geocoding (Address → LatLng)
  // Future<void> _updateLocationFromAddress() async {
  //   try {
  //     List<Location> locations = await locationFromAddress(_address);
  //     if (locations.isNotEmpty) {
  //       LatLng newPosition = LatLng(locations.first.latitude, locations.first.longitude);
  //       setState(() {
  //         _selectedLocation = newPosition;
  //       });
  //       _mapController.animateCamera(CameraUpdate.newLatLng(newPosition));
  //     }
  //   } catch (e) {
  //     //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final mapStyle = ref.watch(mapStyleProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        surfaceTintColor: AppColors.transparent,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      body: Stack(
        children: [
          // 📌 Google Map
          GoogleMap(
            style: mapStyle,
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: {
              Marker(
                markerId: const MarkerId("selected_location"),
                position: _selectedLocation,
                draggable: true,
                onDragEnd: (newPosition) {
                  setState(() {
                    _selectedLocation = newPosition;
                  });
                  _updateAddress(newPosition);
                },
              ),
            },
            onTap: (newPosition) {
              setState(() {
                _selectedLocation = newPosition;
              });
              _updateAddress(newPosition);
            },
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.15,
              controller: _sheetController,
              minChildSize: 0.15,
              maxChildSize: 0.2,
              builder: (context, scrollController) {
                return Container(
                  alignment: Alignment.topCenter,
                  padding: Paddings.allXs,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [const Icon(Icons.location_pin, color: Colors.red), Expanded(child: Text(_address))],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(checkoutProvider.notifier).changeDeliveryAdress(LocationEntity(
                              latitude: _selectedLocation.latitude,
                              longitude: _selectedLocation.longitude,
                              address: _address));
                          Navigator.pop(context);
                        },
                        child: const Text("Confirm Location"),
                      ),
                    ],
                  ),
                );
              })
          // 📌 Permanent Bottom Sheet
          // DraggableScrollableSheet(
          //   controller: _sheetController,
          //   initialChildSize: 0.3, // 30% of screen height
          //   minChildSize: 0.3,
          //   maxChildSize: 1,
          //   builder: (context, scrollController) {
          //     return Container(
          //       padding: const EdgeInsets.all(16),
          //       child: ListView(
          //         controller: scrollController,
          //         children: [
          //           TextField(
          //             decoration: InputDecoration(
          //               labelText: "Enter Address",
          //               border: const OutlineInputBorder(),
          //               suffixIcon: IconButton(
          //                 icon: const Icon(Icons.search),
          //                 onPressed: _updateLocationFromAddress,
          //               ),
          //             ),
          //             onChanged: (value) {
          //               setState(() {
          //                 _address = value;
          //               });
          //             },
          //           ),
          //           const SizedBox(height: 10),
          //           Row(
          //             children: [
          //               const Icon(Icons.location_pin, color: Colors.red),
          //               const SizedBox(width: 8),
          //               Expanded(
          //                 child: Text(
          //                   _address,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const SizedBox(height: 20),

          //    ],
          //     ),
          //   );
          //  },
          // ),
        ],
      ),
    );
  }
}
