// Overall weather model
class Weather {
  final Location location;
  final CurrentWeather current;

  Weather({required this.location, required this.current});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current']),
    );
  }
}

// Model for location
class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final DateTime localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
      localtime: DateTime.parse(json['localtime']),
    );
  }
}

// Model for current weather
class CurrentWeather {
  final int lastUpdatedEpoch;
  final DateTime lastUpdated;
  final double tempC;
  final double tempF;
  final bool isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelsLikeC;
  final double feelsLikeF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;

  CurrentWeather({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      lastUpdatedEpoch: json['last_updated_epoch'],
      lastUpdated: DateTime.parse(json['last_updated']),
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      isDay: json['is_day'] == 1,
      condition: Condition.fromJson(json['condition']),
      windMph: json['wind_mph'],
      windKph: json['wind_kph'],
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'],
      pressureIn: json['pressure_in'],
      precipMm: json['precip_mm'],
      precipIn: json['precip_in'],
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelsLikeC: json['feelslike_c'],
      feelsLikeF: json['feelslike_f'],
      visKm: json['vis_km'].toDouble(),
      visMiles: json['vis_miles'],
      uv: json['uv'].toDouble(),
      gustMph: json['gust_mph'],
      gustKph: json['gust_kph'],
    );
  }
}

// Model for condition
class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}
