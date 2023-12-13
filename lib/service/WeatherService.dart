import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/Weather Data.dart';

class WeatherService {

  Future<WeatherData> getWeatherData(String place) async {

    try{
      final queryParematers = {
        'key': '486f6b5f8aac47fba51124019231112',
        'q': place,
      };

      final uri = Uri.http(
          'api.weatherapi.com','/v1/current.json',queryParematers);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return WeatherData.fromJson(jsonDecode(response.body));

      } else {
        throw Exception('can not get Weather');}

    }catch (e)
    {
      rethrow;
    }
  }
}


