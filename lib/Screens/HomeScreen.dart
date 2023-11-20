import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  final double tempc ;
  final double tempf ;
  final String condi ;
  final String city;
  //final String icon;
  final String time;

  const HomeScreen({
    super.key,
    required this.tempc,
    required this.tempf,
    required this.condi,
    required this.city,
   // required this.icon,
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
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(widget.city,style: TextStyle(fontSize: 50,color: Color(0xFF03ADCC))),
              ),
              Text(widget.time,style: TextStyle(fontSize: 40,color: Color(0xFF03ADCC))),
              SizedBox(height: 5),
              Image.asset('assets/${widget.condi}.png',height: 200,),
              SizedBox(height: 10),
              Text(widget.condi,style: TextStyle(fontSize: 50,color: Colors.white)),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(child: Text('${widget.tempc}°C',style: TextStyle(fontSize: 30 ,color: Colors.white))),
                  Text('${widget.tempf}°F',style: TextStyle(fontSize: 30 ,color: Colors.white)),
                  Text('${widget.tempf}°F',style: TextStyle(fontSize: 30 ,color: Colors.white)),
                ],
              ),


             // Image.network(widget.icon),
            ],
          )
      ),
    );
  }
}
