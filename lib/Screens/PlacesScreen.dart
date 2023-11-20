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

      await Future.delayed(Duration(milliseconds: 250));

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
      appBar: AppBar(
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
                  widget.onPageSelected(1);
                },
              child:Card(
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(city.city),
                              Text('${city.tempc}'),
                              Text('${city.condition}'),
                            ],
                          ),
                        ),
                        Image.asset('assets/icon.png'),
                      ],
                    ),
                  ),
                ));
              } else {
                return SizedBox(
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

