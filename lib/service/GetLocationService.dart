import 'package:geolocator/geolocator.dart';

class GetLocation {
  static Future<Position> getCurrentLocation() async {

    // Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle case where the user denies location permission
        throw();
      }
    }
    // return Current Location
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}