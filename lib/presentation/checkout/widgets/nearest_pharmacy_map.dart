import 'package:diary/domain/entities/pharmacy_entiy.dart';
import 'package:diary/presentation/medicine/controllers/location_provider/position_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/exports.dart';
import '../../../core/routes/routes_names.dart';
import '../../../widgets/markers.dart';
import '../../map/controller/map_style_notifier.dart';
import '../../medicine/controllers/location_provider/position_provider.dart';
import '../controllers/checkout_provider.dart';

class NearestPharmacyMap extends ConsumerStatefulWidget {
  const NearestPharmacyMap({
    super.key,
  });

  @override
  ConsumerState<NearestPharmacyMap> createState() => _NearestPharmacyMapState();
}

class _NearestPharmacyMapState extends ConsumerState<NearestPharmacyMap> {
  GoogleMapController? _mapController;

  locateToNearestPositon(LatLng position, String name) async {
    ltng = position;
    _mapController?.animateCamera(CameraUpdate.newLatLng(position));
    lastCameraPosition = CameraPosition(target: position);
    _mapController?.animateCamera(CameraUpdate.newLatLng(position));
    final myMarker = await CustomMarkers.createMarker();
    markers.addAll([
      Marker(
        markerId: const MarkerId('nearest_pharmacy_marker'),
        position: position,
        icon: myMarker,
        zIndex: 7,
        infoWindow: InfoWindow(
          title: name,
        ),
      ),
    ]);
    setState(() {});
  }

  LatLng? ltng;
  CameraPosition? lastCameraPosition;
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(positionProvider);
    final mapStyle = ref.watch(mapStyleProvider);
    if (position is UserLocationState) {
      if (position.locationEntity.pharmacy == null) {
        return Row(
          children: [
            Expanded(
              child: Text(
                'Pick up from the nearest pharmacy is not yet allowed in your area yet',
                textAlign: TextAlign.center,
                style: TextStyles.robotoBold15,
              ),
            ),
          ],
        );
      }
      PharmacyEntity pharma = position.locationEntity.pharmacy!;
      locateToNearestPositon(
          LatLng(
            pharma.latitude,
            pharma.longitude,
          ),
          pharma.name);

      return Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: Borders.b12,
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
                  markers: markers.toSet()),
            ),
          ),
          xxsSpacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pharmacy Address :",
                style: TextStyles.robotoBold13,
              ),
              Expanded(
                child: Text(
                  pharma.address,
                  style: TextStyles.roboto13,
                ),
              ),
            ],
          )
        ],
      );
    }
    return Row(
      children: [
        IconButton(
            onPressed: () {
              context.goNamed(RoutesNames.mapSearchPage);
            },
            icon: const Icon(
              Icons.gps_fixed_outlined,
              color: AppColors.red,
            )),
        xxxsSpacer(),
        Expanded(
          child: Text(
            'Please choose your current location or allow GPS access',
            textAlign: TextAlign.center,
            style: TextStyles.robotoBold15,
          ),
        ),
      ],
    );
  }
}
