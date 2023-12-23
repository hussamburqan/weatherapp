import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Screens/PlacesScreen.dart';
import 'package:weather_app/main.dart';
import 'Model/Weather Data.dart';
import 'Screens/DailyScreen.dart';
import 'Screens/Drawer_Home.dart';
import 'Screens/HoursScreen.dart';
import 'Screens/MapScreen.dart';
import 'service/WeatherService.dart';
import 'Screens/HomeScreen.dart';

class SecondMain extends StatefulWidget {
  const SecondMain({Key? key}) : super(key: key);
  @override
  State<SecondMain> createState() => _SecondMain();

}

class _SecondMain extends State<SecondMain> {
  WeatherService weatherService = WeatherService();
  WeatherData? weather;
  int _numberScreen = 0;
  late String place;
  bool statsOfData = false ;

  void _onPageSelected(int num) {
    setState(() {
      _numberScreen = num;
    });
  }

  Future<void> getWeather() async {
    place = Provider.of<PlaceProvider>(context, listen: false).getPlace();
    try {
      weather = (await weatherService.getWeatherData(place));
      statsOfData = true;
    } catch (e) {
      statsOfData = false;
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
                ? '${weather!.city} Daily weather'
                : _numberScreen == 3
                ? '${weather!.city} Weather hours'
                : _numberScreen == 4
                ? 'Map'
                : 'Lol',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xFFFFFFFF)),
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
                if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet) {
                  return FutureBuilder(
                    future: getWeather(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (weather != null && _numberScreen == 0 && statsOfData) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                getWeather();
                              });
                            },
                            child: HomeScreen(
                              DataWeather: weather!,
                            ),
                          );
                        } else if (_numberScreen == 1) {
                          try{
                            return PlacesScreen(onPageSelected: (p0) {_onPageSelected(0);});
                          }catch(e){
                            rethrow;
                          }
                        }
                        else if (_numberScreen == 2 ){
                          return DailyScreen();
                        }
                        else if(_numberScreen == 3 ){
                          return HoursScreen();
                        }
                        else if(_numberScreen == 4){
                          return MapScreen(onPageSelected: (int) {
                            getWeather();
                            _onPageSelected(0);
                          });

                        }else {
                          return  Center(child: Text('Place name error\n${Provider.of<PlaceProvider>(context, listen: false).getPlace()}',style: TextStyle(color: Colors.white,fontSize: 40),));
                        }
                      }
                      else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                }
                else if(snapshot.hasError){
                  return noInternet();
                }else
                {return const Center(
                    child: CircularProgressIndicator());
                }
              }
              else return const Center(
                  child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

Widget noInternet() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/no_internet.png',
          color: Color(0xBF706E6E),
          height: 100,
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: const Text(
            "No Internet connection",
            style: TextStyle(fontSize: 22,color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Text("Check your connection",style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}