import 'package:flutter/material.dart';

class WeatherData {
  String name,country,icon;

  WeatherData({
      required this.name,
      required this.country,
      required this.icon
  });


Map<String, dynamic> toJson(){
    return{
      "name": this.name,
      "country": this.country,
      "icon": this.icon,
    };
}

factory WeatherData.fromJson(Map<String, dynamic> json){
  return WeatherData(
      name: json['name'],
      country: json['country'],
      icon: json['icon']
  );
}
}