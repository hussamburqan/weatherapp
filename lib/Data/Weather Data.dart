class WeatherData {
  final double temperatureC;
  final double temperatureF;
  final String condition;
  final String icon;
  final String time;


  WeatherData(  {
    required this.icon,
    required this.time,
    required this.temperatureC,
    required this.temperatureF,
    required this.condition,
   // required this.icon,
  });


  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      time: json ['location']['localtime'],
      icon: json ['current']['condition']['icon'],
      temperatureC: json['current']['temp_c'],
      temperatureF: json['current']['temp_f'],
      condition: json['current']['condition']['text']);}
}
