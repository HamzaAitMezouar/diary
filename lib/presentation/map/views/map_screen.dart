import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:diary/presentation/map/controller/map_style_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/exports.dart';
import '../../../widgets/markers.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  @override
  void initState() {
    initMap();
    super.initState();
  }

  List<Marker> markers = [];

  initMap() {
    cretaeMarkers();
  }

  LatLng position = const LatLng(32.3388, -6.353);
  cretaeMarkers() async {
    final myMarker = await CustomMarkers.createMarker();
    markers.addAll([
      Marker(
        markerId: const MarkerId('my_marker'),
        position: position,
        icon: myMarker,
        onTap: () {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  content: const Text("This is your current location"),
                  actions: [
                    const TextButton(
                      onPressed: null,
                      child: Text("Yes"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("No"),
                    ),
                  ],
                );
              });
        },
      ),
      Marker(
          markerId: const MarkerId('my_marker2'),
          position: const LatLng(32.33, -6.353),
          icon: myMarker,
          zIndex: 7,
          infoWindow: const InfoWindow(
            title: "Pharmacy Somaa",
          ))
    ]);
    setState(() {});

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mapStyle = ref.watch(mapStyleProvider);
    return GoogleMap(
      compassEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      style: mapStyle,
      initialCameraPosition: const CameraPosition(
        target: LatLng(32.3388, -6.353),
        zoom: 14,
      ),
      minMaxZoomPreference: const MinMaxZoomPreference(10, 35),
      onMapCreated: (GoogleMapController controller) {},
      onCameraMove: (position) {},
      markers: markers.toSet(),
    );
  }
}

Future<ui.Image> loadImageAsset(String assetPath) async {
  final ByteData data = await rootBundle.load(assetPath);
  final Uint8List bytes = data.buffer.asUint8List();
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(bytes, (ui.Image img) {
    completer.complete(img);
  });
  return completer.future;
}

class HypeDealMarkerPainter extends CustomPainter {
  HypeDealMarkerPainter({
    required this.radius,
    required this.innerRadius,
    required this.iconImage,
    required this.borderWidth,
    required this.shadowBlur,
    required this.shadowColor,
    required this.hasEvents,
  });

  final double radius;
  final double innerRadius;
  final ui.Image iconImage;
  final double borderWidth;
  final double shadowBlur;
  final Color shadowColor;
  final bool hasEvents;

  @override
  void paint(Canvas canvas, Size size) {
    const double shadowOffset = 0;
    final double innerRadiusWithBorder = innerRadius - borderWidth / 2;

    // Draw the shadow
    final Paint shadowPaint = Paint()
      ..color = shadowColor.withOpacity(0.25)
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, shadowBlur);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2 + shadowOffset),
      radius,
      shadowPaint,
    );

    // Draw the inner circle with border
    final Paint innerPaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), innerRadius, innerPaint);

    innerPaint.style = PaintingStyle.fill;
    innerPaint.color = hasEvents ? AppColors.turquoise : AppColors.quickPink; // Updated color logic
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      innerRadiusWithBorder,
      innerPaint,
    );

    // Draw the image
    final double imageSize = innerRadius; // Scale the image size
    final Offset imageOffset = Offset(
      (size.width - imageSize) / 2,
      (size.height - imageSize) / 2,
    );
    paintImage(
      canvas: canvas,
      rect: imageOffset & Size(imageSize, imageSize),
      image: iconImage,
      fit: BoxFit.contain,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
