import 'package:geolocator/geolocator.dart';

class LocationManager {
  double? longitude;
  double? latitude;

  Future getLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    print(position.latitude);
    print(position.longitude);
    longitude = position.longitude;
    latitude = position.latitude;
  }
}
