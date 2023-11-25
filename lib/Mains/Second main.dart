import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wather_app/Screens/PlacesScreen.dart';
import '../Model/Weather Data.dart';
import '../Screens/DailyScreen.dart';
import '../Screens/Drawer_Home.dart';
import '../Screens/HoursScreen.dart';
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
  String state = 'current.json';
  late String place;

  int _numberScreen = 0;

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

    place = _mybox.get(1) ?? 'London';
  }

  Future<void> getWeather() async {
    try {
      weather = (await weatherService.getWeatherData(place, state));
    } catch (e) {
        print('Error fetching weather data: $e');

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: DrawerHome(onPageSelected: _onPageSelected),
        appBar: AppBar(

          title: Text(
            _numberScreen == 0
              ? 'Weather App'
              : _numberScreen == 1
              ? 'Places'
              : _numberScreen == 2
              ? '$place daily weather'
              : _numberScreen == 3
              ? '$place weather hours '
              : 'Lol',

          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Color(
              0xFFFFFFFF)),
          ),

          elevation: 6,
          backgroundColor: const Color(0xFF060D18),
          leading: Builder(builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xFFFFFFFF),
              size: 40,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          )),
          centerTitle: true,
        ),

        body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/background.jpg'),fit: BoxFit.fill)),
          child: StreamBuilder(
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
                          if (weather != null && _numberScreen == 0) {
                            return HomeScreen(
                              condi: weather!.condition,
                              tempc: weather!.temperatureC,
                              country: weather!.country,
                              humidity: weather!.humidity,
                              wind: weather!.wind,
                              city: place,
                              time: weather!.time,
                            );
                          } else if (_numberScreen == 1) {
                            return PlacesScreen(onPageSelected: (p0) {_onPageSelected(0);},onPlaceSelected: (selectedPlace) {
                              setState(() {
                                place = selectedPlace;
                                _mybox.put(1, place);
                              });
                            });
                          } else if (_numberScreen == 2){
                            return DailyScreen(city: place);

                          }else if(_numberScreen == 3){
                            return HoursScreen(city: place);

                          }else {
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
        ),
    );
  }


}


  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(
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
            child: const Text("Check your connection"),
          ),
        ],
      ),
    );
  }
