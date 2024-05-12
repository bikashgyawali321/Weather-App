import 'package:flutter/material.dart';

//overall weather model
class Weather {
  final Location location;
  final CurrentWeather currentWeather;
  Weather({required this.location, required this.currentWeather});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location'] ?? ""),
      currentWeather: CurrentWeather.fromJson(json['currentWeather'] ?? ""),
    );
  }
}

//model for location
class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final DateTime localtime;
  Location(
      {required this.name,
      required this.country,
      required this.localtime,
      required this.lat,
      required this.lon,
      required this.region});
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        name: json['name'] ?? '',
        country: json['country'],
        region: json['region'],
        lat: json['lat'],
        lon: json['lon'],
        localtime: json['localtime']);
  }
}

//model for current weather
class CurrentWeather {
  final String lastUpdatedEpoch;
  final DateTime lastUpdated;
  final double tempC;
  final double tempF;
  final bool isDay;
  final Condition condition;
  CurrentWeather(
      {required this.lastUpdatedEpoch,
      required this.condition,
      required this.isDay,
      required this.lastUpdated,
      required this.tempC,
      required this.tempF});
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
        lastUpdatedEpoch: json['last_updated_epoch'],
        condition: Condition.fromJson(json['condition']),
        isDay: json['is_day'],
        lastUpdated: json['last_updated'],
        tempC: json['temp_c'],
        tempF: json['temp_f']);
  }
}

//model for condition
class Condition {
  final String text;
  final Icon icon;
  final num code;
  Condition({required this.text, required this.icon, required this.code});
  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
        text: json['text'], icon: json['icon'], code: json['code']);
  }
}
