import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  final double tempc ;
  final double tempf ;
  final String condi ;
  final String city;
  final String icon;

  const HomeScreen({
    super.key,
    required this.tempc,
    required this.tempf,
    required this.condi,
    required this.city,
    required this.icon
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
              const SizedBox(height: 140),
              Text(widget.city,style: TextStyle(fontSize: 50)),
              Text('${widget.tempc}°C',style: TextStyle(fontSize: 50)),
              Text('${widget.tempc}°F',style: TextStyle(fontSize: 50)),
              Text(widget.condi,style: TextStyle(fontSize: 50)),
              Image.network(widget.icon),
              Text('Back in 12:10',style: TextStyle(fontSize: 50))
            ],
          )
      ),
    );
  }
}
