import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wather_app/Model/DailyData.dart';
import '../Model/Hourly Data.dart';

class HoursService {

  Future<List<Object>> gethoursData(String place, String state ,String day) async {
    try {
      final queryParameters = {
        'key': '79fb3945227647ad94595829231911',
        'q': place,
        'days': day,

      };

      final uri = Uri.http('api.weatherapi.com', '/v1/$state', queryParameters);

      final response = await http.get(uri);

      if (response.statusCode == 200 && day == '1') {
        final List<dynamic> list = json.decode(response.body)['forecast']['forecastday'][0]['hour'];
        return list.map((e) => HourlyData.fromJson(e)).toList();
      } else if (response.statusCode == 200 && day == '7')
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
