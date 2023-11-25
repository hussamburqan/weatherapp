class HourlyData {
   double? temperatureC;
   String? condition;
   String? time;

  HourlyData({
    this.time,
    this.temperatureC,
    this.condition,
  });


   static HourlyData fromJson(json) => HourlyData(

         time:json['time'],
         temperatureC: json['temp_c'],
         condition: json['condition']['text'],
   );
}
