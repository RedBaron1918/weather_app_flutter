import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    this.weather,
    this.main,
    this.name,
  });

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weather?[0].icon}@2x.png';
  }

  List<WeatherElement>? weather;
  Main? main;
  String? name;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        weather: json["weather"] == null
            ? []
            : List<WeatherElement>.from(
                json["weather"]!.map((x) => WeatherElement.fromJson(x))),
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
        name: json["name"],
      );
  Map<String, dynamic> toJson() => {
        "weather": weather == null
            ? []
            : List<dynamic>.from(weather!.map((x) => x.toJson())),
        "main": main?.toJson(),
        "name": name,
      };
}

class Main {
  Main({
    this.temp,
  });

  double? temp;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
      };
}

class WeatherElement {
  WeatherElement({
    this.description,
    this.icon,
  });

  String? description;
  String? icon;

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "icon": icon,
      };
}
