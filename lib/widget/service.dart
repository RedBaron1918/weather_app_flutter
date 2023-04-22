import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather_model.dart';

class Service {
  static Future<Weather?> getWeather(String cityName) async {
    final params = {
      'q': cityName,
      'appid': 'e41e59c5c041a45f376e6959387d2beb',
      'units': 'metric'
    };

    final uri =
        Uri.https('api.openweathermap.org', '/data/2.5/weather', params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      return null;
    }
  }
}
