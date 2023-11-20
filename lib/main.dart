import 'package:flutter/material.dart';
import 'Data/Weather Data.dart';
import 'service/WeatherService.dart';
import 'Screens/HomeScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WeatherService weatherService = WeatherService();
  WeatherData? weather ;
  String place1 = 'palestine';

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async{
    try {
      weather = await weatherService.getWeatherData(place1);
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Weather App'),
        ),
        body: weather == null
            ?Center(child: CircularProgressIndicator())
            :HomeScreen(condi: weather!.condition,tempc: weather!.temperatureC,tempf: weather!.temperatureF, city: place1,icon: weather!.icon,)),
      );
  }
}
