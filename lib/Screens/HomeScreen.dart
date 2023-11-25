import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  final double tempc ;
  final String condi ;
  final String city;
  final int humidity;
  final double wind;
  final String country;
  final String time;

  const HomeScreen({
    super.key,
    required this.wind,
    required this.humidity,
    required this.tempc,
    required this.condi,
    required this.city,
    required this.country,
    required this.time
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  Future<void> refresh() async {
    return await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
              children: [

                Align(alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: refresh,
                      child: const Icon(Icons.refresh),)),
                const SizedBox(height: 60),
                Text(widget.city,style: const TextStyle(fontSize: 50,color: Color(0xFFFFFFFF))),

                Text(widget.country,textAlign: TextAlign.center ,style: const TextStyle(fontSize: 40,color: Color(0xFFFFFFFF))),

                const SizedBox(height: 5),

                Image.asset('assets/${widget.condi}.png',height: 150,),

                const SizedBox(height: 10),

                Text(
                    widget.condi,
                    style:  const TextStyle(fontSize: 40,color: Colors.white,)),

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
                            Text('${widget.humidity}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 30 ,color: Colors.white)),
                            Image.asset('assets/Humidity.png',height: 40,width: 40),
                          ],
                        ),

                        Row(
                          children: [
                            Text('${widget.tempc}°C',style: const TextStyle(fontSize: 30 ,color: Colors.white)),
                            if(widget.tempc > 14 )
                              Image.asset('assets/Hot.png',height: 40,width: 40),
                            if(widget.tempc <= 14)
                              Image.asset('assets/Cold.png',height: 40,width: 40,),
                          ],
                        ),
                        Row(
                          children: [
                            Text('${widget.wind}',style: const TextStyle(fontSize: 30 ,color: Colors.white)),
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
