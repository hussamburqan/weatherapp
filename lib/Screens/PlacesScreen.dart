import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../Model/City Data.dart';
import '../Model/Weather Data.dart';
import '../service/WeatherService.dart';

class PlacesScreen extends StatefulWidget {
  final Function(String) onPlaceSelected;
  final Function(int) onPageSelected;

  const PlacesScreen({Key? key, required this.onPlaceSelected, required this.onPageSelected}) : super(key: key);

  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  WeatherService weatherService = WeatherService();
  WeatherData? weather;
  int i = 0 ;

  String state1 = 'current.json';
  late List<City> citiesList;

  @override
  void initState() {
    super.initState();
    citiesList = City.citiesList;
  }

  Future<void> refresh() async {

    await Future.delayed(const Duration(seconds: 1));

  }

  Future<void> getWeather(City city) async {
    try {

      await Future.delayed(const Duration(milliseconds: 20));

      weather = (await weatherService.getWeatherData(city.city, state1));

      city.tempc = weather?.temperatureC.toString() ?? 'N/A';
      city.condition = weather?.condition ?? 'N/A';
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
          onRefresh: refresh,
          backgroundColor: Colors.deepPurple[200],
          height: 200,
          color: Colors.deepPurple,
          animSpeedFactor: 1,
          showChildOpacityTransition: true,

          child:  Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: citiesList.length,
              itemBuilder: (context, index) {
                final city = citiesList[index];
                return FutureBuilder(
                  future: getWeather(city),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return GestureDetector(
                        onTap: () {
                          widget.onPlaceSelected(city.city);
                          widget.onPageSelected(0);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0,left: 8.0,right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xFF264698),
                                  Color(0xFF007DFF),
                                ])
                            ),
                            child: SizedBox(
                              height: 90,
                              child: Row(
                                children: [

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(city.city,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                          Text('${city.tempc}°C',style: const TextStyle(color: Colors.white)),
                                          Text(city.condition,style: const TextStyle(color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Image.asset(
                                    'assets/${city.condition}.png',
                                    width: 80,
                                    height: 80,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox(
                        height: 70,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
    );
  }
}
