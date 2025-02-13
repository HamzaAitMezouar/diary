import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/exports.dart';

class CustomMarkers {
  static Future<BitmapDescriptor> createMarker() async {
    final data = await rootBundle.load(Assets.marker); // Path to your asset
    final Uint8List bytes = data.buffer.asUint8List();

    // Create an image from the bytes
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    // Create a Canvas to resize the image
    final size = Size(80, 80); // Set the desired size for the marker
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)));

    // Draw the image onto the canvas, resizing it
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()), // Source rectangle
      Rect.fromLTWH(0, 0, size.width, size.height), // Destination rectangle
      Paint(),
    );

    // End the drawing and convert it to a BitmapDescriptor
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(pngBytes);
  }
}
