import 'package:geolocator/geolocator.dart';

class GetLocation {

  static Future<bool> getstatus(){
    return Geolocator.isLocationServiceEnabled();
  }

  static Future<Position> getCurrentLocation() async {

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw();
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}