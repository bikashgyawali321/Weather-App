import 'package:flutter/foundation.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/backend_service.dart';
import 'package:geolocator/geolocator.dart';

class WeatherProvider extends ChangeNotifier {
  final BackendService backendService = BackendService();
  bool isLoading = false;
  Weather? _weatherData;

  Weather? get weatherData => _weatherData;

  Future<Weather> fetchWeatherByName(String location) async {
    isLoading = true;
    try {
      _weatherData = await backendService.getWeatherData(location);
      isLoading = false;
      notifyListeners();
      return _weatherData!;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception('Unable to load the weather of $location: $e');
    }
  }

  Future<Weather> fetchWeatherByLongLatt() async {
    isLoading = true;
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      double latitude = position.latitude;
      double longitude = position.longitude;

      String location = '$latitude,$longitude';

      _weatherData = await backendService.getWeatherData(location);

      isLoading = false;
      notifyListeners();

      return _weatherData!;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception('Unable to load weather data: $e');
    }
  }
}
