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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Text(widget.city,style: TextStyle(fontSize: 50,color: Color(0xFFFFFFFF))),

              ),
              Text(widget.country,style: TextStyle(fontSize: 40,color: Color(0xFFFFFFFF))),

              SizedBox(height: 5),

              Image.asset('assets/${widget.condi}.png',height: 200,),

              SizedBox(height: 10),

              Text(widget.condi,style: TextStyle(fontSize: 50,color: Colors.white)),

              SizedBox(height: 15),

              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [

                  Row(
                    children: [
                      Container(child: Text('${widget.humidity}',style: TextStyle(fontSize: 30 ,color: Colors.white))),
                      Image.asset('assets/Humidity.png',height: 40,width: 40),
                    ],
                  ),

                  Row(
                    children: [
                      Text('${widget.tempc}°C',style: TextStyle(fontSize: 30 ,color: Colors.white)),
                      if(widget.tempc > 14 )
                        Image.asset('assets/Hot.png',height: 40,width: 40),
                      if(widget.tempc <= 14)
                        Image.asset('assets/Cold.png',height: 40,width: 40,),
                    ],
                  ),
                  Row(
                    children: [
                      Text('${widget.wind}',style: TextStyle(fontSize: 30 ,color: Colors.white)),
                      Image.asset('assets/WindSpeed.png',height: 40,width: 40),
                    ],
                  ),

                ],
              ),


             // Image.network(widget.icon),
            ],
          )
      ),
    );
  }
}
