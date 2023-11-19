import 'dart:convert';
import 'package:flutter/material.dart';
import 'Data/Weather Data.dart';
import 'Screens/HomeScreen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Weather App'),
        ),


        body: HomeScreen(),
      ),
    );
  }

 //  FutureBuilder(future: FutureWeatherData,
 //  builder: (context,snapshot) {
 //  if(snapshot.hasData){
 //  return const Text('Data is ready');
 //  }
 // else if(snapshot.hasError){
 //  return const Text('Data not ready');}
 // else {
 // return const Center(
 // child: CircularProgressIndicator(),
 // );}
 // }
 // ),

late Future<WeatherData> FutureWeatherData;

  Future<WeatherData> getWeatherData() async {

    http.Response response = await http.get(Uri.parse('http://api.weatherapi.com/v1/current.json?key=79fb3945227647ad94595829231911&q=London&aqi=no'));

    if(response.statusCode== 200){

    var jsonObject = jsonDecode(response.body);

    WeatherData data = WeatherData.fromJson(jsonObject);

    return data;
    }
    else {
      throw Exception('cant get Data ');
    }
  }

  @override
  void initState() {
    super.initState();
    FutureWeatherData = getWeatherData();
  }
}
