import 'package:diary/core/errors/exceptions.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationDataSource {
  Future<Position> getCurrentLocation();
}

class LocationDataSourceImpl extends LocationDataSource {
  @override
  Future<Position> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        throw CustomException(message: "Location permissions are permanently denied.");
      }

      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
