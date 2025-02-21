import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/presentation/checkout/controllers/checkout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/exports.dart';
import '../../../core/routes/routes_names.dart';
import '../../../domain/entities/location_entity.dart';
import '../../map/controller/map_style_notifier.dart';
import '../../medicine/controllers/location_provider/position_provider.dart';
import '../../medicine/controllers/location_provider/position_state.dart';

class MapAddressCard extends ConsumerStatefulWidget {
  const MapAddressCard({super.key});

  @override
  ConsumerState<MapAddressCard> createState() => _MapAddressCardState();
}

class _MapAddressCardState extends ConsumerState<MapAddressCard> {
  GoogleMapController? _mapController;

  locateToAddressPositon(LocationEntity position) {
    LocationEntity loc = position;
    ltng = LatLng(loc.latitude, loc.longitude);
    _mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(loc.latitude, loc.longitude)));
    lastCameraPosition = CameraPosition(target: LatLng(loc.latitude, loc.longitude));
    _mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(loc.latitude, loc.longitude)));
    setState(() {});
  }

  locateToNearestPositon(LatLng position) {
    ltng = position;
    _mapController?.animateCamera(CameraUpdate.newLatLng(position));
    lastCameraPosition = CameraPosition(target: position);
    _mapController?.animateCamera(CameraUpdate.newLatLng(position));
    setState(() {});
  }

  LatLng? ltng;
  CameraPosition? lastCameraPosition;

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(positionProvider);
    final mapStyle = ref.watch(mapStyleProvider);
    final checkout = ref.watch(checkoutProvider);
    if (position is UserLocationState) {
      if (checkout?.deliveryType == DeliveryType.pharmacy && position.locationEntity.pharmacy != null) {
        locateToNearestPositon(
            LatLng(position.locationEntity.pharmacy!.latitude, position.locationEntity.pharmacy!.longitude));
      } else {
        locateToAddressPositon(position.locationEntity);
      }

      return Column(
        children: [
          Expanded(
            child: GoogleMap(
                style: mapStyle,
                compassEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapToolbarEnabled: false,
                zoomControlsEnabled: true,
                initialCameraPosition: lastCameraPosition!,
                minMaxZoomPreference: const MinMaxZoomPreference(10, 35),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                onCameraMove: (position) {
                  //    _lastCameraPosition = CameraPosition(target: LatLng(loc.latitude, loc.longitude));
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('my_marker'),
                    position: LatLng(position.locationEntity.latitude, position.locationEntity.longitude),
                    icon: BitmapDescriptor.defaultMarker,
                  )
                }),
          ),
          xxsSpacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address :",
                style: TextStyles.robotoBold13,
              ),
              Expanded(
                child: Text(
                  position.locationEntity.address ?? "",
                  style: TextStyles.roboto13,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    context.goNamed(RoutesNames.mapSearchPage, extra: ltng);
                  },
                  child: const Icon(Icons.edit))
            ],
          )
        ],
      );
    }
    return SizedBox();
  }
}
