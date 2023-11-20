class WeatherData {
  final double temperatureC;
  final double temperatureF;
  final String condition;
  final String icon;


  WeatherData({
    required this.temperatureC,
    required this.temperatureF,
    required this.condition,
    required this.icon,
  });


  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      icon: json ['current']['condition']['icon'],
      temperatureC: json['current']['temp_c'],
      temperatureF: json['current']['temp_f'],
      condition: json['current']['condition']['text'],);}
}
