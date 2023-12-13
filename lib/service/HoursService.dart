import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/Model/DailyData.dart';
import '../Model/Hourly Data.dart';

class HoursService {

  Future<List<Object>> gethoursData(String place,String day) async {

    try {
      final queryParameters = {
        'key': '486f6b5f8aac47fba51124019231112',
        'q': place,
        'days': day,
      };

      final uri = Uri.http('api.weatherapi.com', '/v1/forecast.json', queryParameters);


      final response = await http.get(uri);

        if (response.statusCode == 200 && day == '1') {
        final List<dynamic> list = json.decode(response.body)['forecast']['forecastday'][0]['hour'];
        return list.map((e) => HourlyData.fromJson(e)).toList();
      } else
        if (response.statusCode == 200 && day == '7')
      {
        final List<dynamic> list = json.decode(response.body)['forecast']['forecastday'];
        return list.map((e) => DailyData.fromJson(e)).toList();
      }


      else{
        throw Exception('Unable to get Weather');
      }
    } catch (e) {
      rethrow;
    }
  }
}
