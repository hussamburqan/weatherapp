import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../Model/City Data.dart';
import '../Model/Weather Data.dart';
import '../service/ImageExist.dart';
import '../service/WeatherService.dart';
import 'DialogCity.dart';

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
  late final List<City> citiesList;
  late final TextEditingController _controller;


  @override
  void initState() {
    super.initState();

    getdata();
    _controller = TextEditingController();
  }

  Future<void> getdata() async {
    final box = await Hive.box('Places');
    if(box.isEmpty){
      for(int i =0 ; i < City.citiesList.length ; i++){
        box.add(City.citiesList[i].city);
      }
    }else {
      City.citiesList = [];
      for(int i =0 ; i < box.length ; i++){
        City.citiesList.add(City(
            condition: '',
            tempc: '',
            city: box.getAt(i)
        ));
      }
      citiesList = City.citiesList;
    }
  }

  Future<void> refresh() async {

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
    });
  }

  Future<void> getWeather(City city) async {
    try {
      await Future.delayed(const Duration(milliseconds: 20));

      weather = (await weatherService.getWeatherData(city.city));

      city.tempc = weather?.temperatureC.toString() ?? 'N/A';
      city.condition = weather?.condition ?? 'N/A';
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getdata(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done){
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: createNewCity,
              backgroundColor: const Color(0xFF706E6E),
              child: const Icon(Icons.add),
            ),
            backgroundColor: Colors.transparent,
            body: LiquidPullToRefresh(
              onRefresh: refresh,
              backgroundColor: Colors.white30,
              height: 200,
              color: Colors.white12,
              animSpeedFactor: 1,
              showChildOpacityTransition: true,

              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView.builder(
                  itemCount: citiesList.length,
                  itemBuilder: (context, index) {
                    final city = citiesList[index];
                    return FutureBuilder(
                      future: getWeather(city),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, right: 8.0),
                            child: Slidable(
                              child: GestureDetector(
                                onTap: () {
                                  widget.onPlaceSelected(city.city);
                                  widget.onPageSelected(0);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(colors: [
                                        Color(0xD9706E6E),
                                        Color(0xD93D3C3C),
                                      ])
                                  ),
                                  child: SizedBox(
                                    height: 90,
                                    child: Row(
                                      children: [

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(city.city,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),),
                                                Text('${city.tempc}°C',
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                                Text(city.condition,
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5.0),
                                          child: TestImage(
                                              assetImagePath: 'assets/${city
                                                  .condition}.png',
                                              width: 80,
                                              height: 80),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [

                                  SlidableAction(
                                    onPressed: (BuildContext context) => deleteCity(index),
                                    icon: Icons.delete_forever,
                                    backgroundColor: Color(0xC0F56262),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }},
    );
  }

  void createNewCity(){
    showDialog(
      context: context,
      builder: (contest) {
        return Dialogbox(
          controller: _controller,
          onsave: SaveNewCity,
          oncancel: ()=> Navigator.of(context, rootNavigator: true).pop(),
        );
      },
    );
  }

  Future<void> SaveNewCity() async {
    final box = await Hive.box('Places');
    citiesList.add(City(condition: '', tempc: '', city: _controller.text));
    box.add(_controller.text);
    setState(() {
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  Future<void> deleteCity(int index) async {
    final box = await Hive.box('Places');
    citiesList.removeAt(index);
    box.deleteAt(index);
    setState(() {
    });
  }
}