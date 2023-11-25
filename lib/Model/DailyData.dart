class DailyData {
  String? dateTime;
  double? tempCH;
  double? tempCL;
  String? condition;

  DailyData({
    this.dateTime,
    this.condition,
    this.tempCH,
    this.tempCL
  });


  static DailyData fromJson(json) => DailyData(
    dateTime: json['date'],
    tempCH: json['day']['maxtemp_c'],
    tempCL: json['day']['mintemp_c'],
    condition: json['day']['condition']['text'],
  );
}
