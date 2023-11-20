import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wather_app/Screens/PlacesScreen.dart';
import '../Data/Weather Data.dart';
import '../Screens/Drawer_Home.dart';
import '../service/WeatherService.dart';
import '../Screens/HomeScreen.dart';

class SecondMain extends StatefulWidget {
  const SecondMain({Key? key}) : super(key: key);
  @override
  State<SecondMain> createState() => _SecondMain();

}

class _SecondMain extends State<SecondMain> {
  WeatherService weatherService = WeatherService();
  WeatherData? weather;
  String state1 = 'current.json';
  late String place1;
  int _numberScreen = 1;

  final _mybox = Hive.box('mybox');

  void _onPageSelected(int num) {

    setState(() {
      _numberScreen = num;
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
    place1 = _mybox.get(1, defaultValue: 'London');
  }


  Future<void> getWeather() async {
    try {
      weather = await weatherService.getWeatherData(place1, state1);
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF060720),
        drawer: DrawerHome(onPageSelected: _onPageSelected),
        appBar: AppBar(backgroundColor: Color(0xFF0391AB),
          leading: Builder(builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          )),
          centerTitle: true,
          title: const Text('Weather App'),
        ),
        body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          initialData: ConnectivityResult.none,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            if (snapshot.hasData) {
              ConnectivityResult result = snapshot.data!;
              if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
                return FutureBuilder(
                  future: getWeather(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (weather != null && _numberScreen == 1) {
                        return HomeScreen(
                          condi: weather!.condition,
                          tempc: weather!.temperatureC,
                          tempf: weather!.temperatureF,
                          city: place1,
                          time: weather!.time,
                        );
                      } else if (_numberScreen == 2) {
                        return PlacesScreen(onPlaceSelected: (selectedPlace) {
                          setState(() {
                            place1 = selectedPlace;
                            _mybox.put(1, place1);
                          });
                        }, onPageSelected:_onPageSelected);
                      } else {
                        return const Center(child: Text('Weather data is null.'));
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                return noInternet();
              }
            } else {
              return loading();
            }
          },
        ),
      ),
    );
  }


}


  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  Widget noInternet() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no_internet.png',
            color: Colors.red,
            height: 100,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text(
              "No Internet connection",
              style: TextStyle(fontSize: 22),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const Text("Check your connection, then refresh the page."),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: () async {
              ConnectivityResult result = await Connectivity().checkConnectivity();
            },
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }
