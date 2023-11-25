import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/Weather Data.dart';

class WeatherService {

Future<WeatherData> getWeatherData(String place,String state) async {

  try{
    final queryParematers = {
    'key': '79fb3945227647ad94595829231911',
    'q': place,
    };

    final uri = Uri.http(
      'api.weatherapi.com','/v1/$state',queryParematers);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
    return WeatherData.fromJson(jsonDecode(response.body));

    } else {
    throw Exception('can not get Weather');}

  }catch (e)
  { rethrow;}
}
}


