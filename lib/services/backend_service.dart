import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class BackendService extends ChangeNotifier {
  final baseUrl =
      "http://api.weatherapi.com/v1/current.json?key=af48fbbdd6f5467696a141013241205";

  //API call by lattitude and longitude

  Future<Weather> getWeatherData(dynamic location) async {
    try {
      String url;
      if (location is String) {
        url = '$baseUrl&q=$location';
      } else if (location is List<double> && location.length == 2) {
        url = '$baseUrl&q=${location[0]},${location[1]}';
      } else {
        throw Exception('Invalid Data Provided');
      }
      //making the api call

      final response = await http.get(Uri.parse(url));
      //is api call successfull?
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        //create a instance of weather
        Weather weather = Weather.fromJson(data);
        return weather;
      } else {
        throw Exception('Unable to load weather data');
      }
    } catch (e) {
      throw Exception('Unable to load data:$e');
    }
  }
}
