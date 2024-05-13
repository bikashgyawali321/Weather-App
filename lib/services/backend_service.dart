import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class BackendService extends ChangeNotifier {
  final String apiKey = "af48fbbdd6f5467696a141013241205";
  final String baseUrl = "http://api.weatherapi.com/v1";

  Future<Weather> getWeatherData(dynamic location) async {
    try {
      String url;
      if (location is String) {
        url = '$baseUrl/current.json?key=$apiKey&q=$location';
      } else if (location is List<double> && location.length == 2) {
        url = '$baseUrl/current.json?key=$apiKey&q=${location[0]},${location[1]}';
      } else {
        throw Exception('Invalid Data Provided');
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        Weather weather = Weather.fromJson(jsonMap);
        return weather;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
