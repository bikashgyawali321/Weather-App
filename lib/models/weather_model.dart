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

  CurrentWeather({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      lastUpdatedEpoch: json['last_updated_epoch'],
      lastUpdated: DateTime.parse(json['last_updated']),
      tempC: json['temp_c'].toDouble(),
      tempF: json['temp_f'].toDouble(),
      isDay: json['is_day'] == 1,
      condition: Condition.fromJson(json['condition']),
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
