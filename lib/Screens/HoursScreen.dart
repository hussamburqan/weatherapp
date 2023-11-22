import 'package:flutter/material.dart';

class HoursScreen extends StatefulWidget {
  const HoursScreen({super.key});

  @override
  State<HoursScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<HoursScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8E95F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF8E95F5),
        elevation: 0,
        title: Text('Hourly Weather'),

      ),
      body: Column(
        children: [
          SizedBox(height: 140),
          Center(child: Text('no data'))
        ],
      ),
    );
  }
}
