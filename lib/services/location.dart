import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0;
  double longtude = 0;
  Future<void> GetLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longtude = position.longitude;
    } catch (e) {
      print("ERROR : NOT WORKING $e");
    }
  }
}
