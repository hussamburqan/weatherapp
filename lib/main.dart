import 'package:flutter/material.dart';
import 'Data/Weather Data.dart';
import 'Screens/Drawer_Home.dart';
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
  String place1 = 'London';

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async{
    try {
  weather = await weatherService.getWeatherData(place1);
    }catch(e){
      throw(e);
}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: DrawerHome(),
        appBar: AppBar(
          leading: Builder(builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => Scaffold.of(context).openDrawer()
          )),
          centerTitle: true,
          title: const Text('Weather App'),
        ),
        body: GestureDetector(

          child: weather == null
              ?const Center(child: CircularProgressIndicator())
              :HomeScreen(condi: weather!.condition,tempc: weather!.temperatureC,tempf: weather!.temperatureF, city: place1,icon: weather!.icon,),
        )),
      );
  }
}
