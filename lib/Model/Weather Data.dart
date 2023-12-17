class WeatherData {
  final double temperatureC;
  final int humidity;
  final double wind;
  final String condition;
  final String country;
  final String time;
  final String city;

  WeatherData({
    required this.city,
    required this.wind,
    required this.humidity,
    required this.time,
    required this.temperatureC,
    required this.condition,
    required this.country,
  });


  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
        city: json['location']['name'],
        humidity: json['current']['humidity'],
        wind: json['current']['wind_kph'],
        country: json ['location']['country'],
        time: json ['location']['localtime'],
        temperatureC: json['current']['temp_c'],
        condition: json['current']['condition']['text']);
  }

}
