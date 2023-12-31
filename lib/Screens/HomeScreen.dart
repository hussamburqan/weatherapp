import 'package:flutter/material.dart';
import 'package:weather_app/Model/Weather%20Data.dart';
import '../service/ImageExist.dart';

class HomeScreen extends StatefulWidget {

  final WeatherData DataWeather;

  const HomeScreen({
    super.key,
    required this.DataWeather,

  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>  {

  @override
  Widget build(BuildContext context) {
    return  Column(
              children: [

                const SizedBox(height: 100),
                Text(widget.DataWeather.city,style: const TextStyle(fontSize: 50,color: Color(0xFFFFFFFF))),

                Text(widget.DataWeather.country,textAlign: TextAlign.center ,style: const TextStyle(fontSize: 40,color: Color(0xFFFFFFFF))),

                const SizedBox(height: 5),

                TestImage(assetImagePath: 'assets/${widget.DataWeather.condition}.png',height: 150,width: 150),

                const SizedBox(height: 10),

                Text(
                    widget.DataWeather.condition,
                    style:  const TextStyle(fontSize: 40,color: Colors.white,),textAlign: TextAlign.center),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.white30,
                    borderRadius: BorderRadius.circular(25)
                    ),
                    height: 50,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [

                        Row(
                          children: [
                            Text('${widget.DataWeather.humidity}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 30 ,color: Colors.white)),
                            Image.asset('assets/Humidity.png',height: 40,width: 40),
                          ],
                        ),

                        Row(
                          children: [
                            Text('${widget.DataWeather.temperatureC}°C',style: const TextStyle(fontSize: 30 ,color: Colors.white)),
                            if(widget.DataWeather.temperatureC > 14 )
                              Image.asset('assets/Hot.png',height: 40,width: 40),
                            if(widget.DataWeather.temperatureC <= 14)
                              Image.asset('assets/Cold.png',height: 40,width: 40,),
                          ],
                        ),
                        Row(
                          children: [
                            Text('${widget.DataWeather.wind}',style: const TextStyle(fontSize: 30 ,color: Colors.white)),
                            Image.asset('assets/WindSpeed.png',height: 40,width: 40),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
    );
  }
}
