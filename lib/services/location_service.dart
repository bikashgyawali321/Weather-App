import 'package:geolocator/geolocator.dart';

class AutomaticLocationService {
  Future<List<double>> getCurrentLocation() async {
    try {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        throw Exception(
            'Location service is disabled, you first need to enable it');
      }
      //check if permission to access the location is granted
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        throw Exception('Location permission is denied');
      }
      //get the current position
      Position position = await Geolocator.getCurrentPosition();
      return [position.latitude, position.longitude];
    } catch (e) {
      throw Exception('Failed to get current location: $e');
    }
  }
}
