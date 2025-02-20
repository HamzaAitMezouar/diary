import 'dart:io';

import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/presentation/medicine/controllers/location_provider/location_state.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
        height: checkout?.deliveryType == null ? 0 : D.xxxxxxl * 1.5,
        width: double.infinity,
        child: checkout?.deliveryType == DeliveryType.home ? const UserLocationMap() : const NearestPharmacyMap());
  }
}

class NearestPharmacyMap extends StatelessWidget {
  const NearestPharmacyMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
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
      return Column(
        children: [
          Expanded(
            child: GoogleMap(
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
                markers: {
                  Marker(
                    markerId: const MarkerId('my_marker'),
                    position: LatLng(position.locationEntity.latitude, position.locationEntity.longitude),
                    icon: BitmapDescriptor.defaultMarker,
                  )
                }),
          ),
          xxxxsSpacer(),
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
              IconButton(onPressed: () {}, icon: Icon(Icons.edit))
            ],
          )
        ],
      );
    }
    return CustomButton(
      onTap: () {
        context.goNamed(RoutesNames.mapSearchPage);
      },
      title: "Choose from map",
      style: TextStyles.montserratBold15,
    );
  }
}
