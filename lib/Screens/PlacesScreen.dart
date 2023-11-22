import 'package:flutter/material.dart';
import '../Data/City Data.dart';
import '../Data/Weather Data.dart';
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

  String state1 = 'current.json';
  late List<City> citiesList;

  @override
  void initState() {
    super.initState();
    citiesList = City.citiesList;
  }

  Future<void> getWeather(City city) async {
    try {

      await Future.delayed(const Duration(milliseconds: 100));

      weather = await weatherService.getWeatherData(city.city, state1);

      city.tempc = weather?.temperatureC.toString() ?? 'N/A';
      city.condition = weather?.condition ?? 'N/A';
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8E95F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF8E95F5),
        elevation: 0,
        title: const Text('Select City'),
      ),
      body: ListView.builder(
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
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(city.city,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  Text('${city.tempc}°C'),
                                  Text(city.condition),
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
    );
  }
}
