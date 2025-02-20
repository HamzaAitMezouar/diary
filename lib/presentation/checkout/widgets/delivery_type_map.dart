import 'dart:io';

import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/presentation/medicine/controllers/location_provider/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/exports.dart';
import '../../medicine/controllers/location_provider/location_provider.dart';
import '../controllers/checkout_provider.dart';

class DeliveryTypeMapWidget extends ConsumerWidget {
  const DeliveryTypeMapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final checkout = ref.watch(checkoutProvider);

    return AnimatedContainer(
        transformAlignment: Alignment.bottomCenter,
        duration: Durations.extralong1,
        height: checkout?.deliveryType == null ? 0 : D.xxxxxxl * 1.3,
        width: double.infinity,
        child: checkout?.deliveryType == DeliveryType.home ? UserLocationMap() : NearestPharmacyMap());
  }
}

class NearestPharmacyMap extends StatelessWidget {
  const NearestPharmacyMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

class UserLocationMap extends ConsumerStatefulWidget {
  const UserLocationMap({
    super.key,
  });

  @override
  ConsumerState<UserLocationMap> createState() => _UserLocationMapState();
}

class _UserLocationMapState extends ConsumerState<UserLocationMap> {
  String mapStyle = "";
  initMap() {
    if (Platform.isAndroid) {
      rootBundle.loadString('assets/styles/map_style.txt').then((string) {
        mapStyle = string;
        setState(() {});
      });
    } else {
      rootBundle.loadString('assets/styles/map_style.json').then((string) {
        mapStyle = string;
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initMap();
  }

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(positionProvider);

    if (position is UserLocationState) {
      return GoogleMap(
          compassEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(position.locationEntity.latitude, position.locationEntity.longitude),
            zoom: 14,
          ),
          minMaxZoomPreference: const MinMaxZoomPreference(10, 35),
          onMapCreated: (GoogleMapController controller) {},
          onCameraMove: (position) {},
          markers: [
            Marker(
              markerId: const MarkerId('my_marker'),
              position: LatLng(position.locationEntity.latitude, position.locationEntity.longitude),
              icon: BitmapDescriptor.defaultMarker,
            )
          ].toSet());
    }
    return SizedBox();
  }
}
