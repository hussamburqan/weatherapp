import 'package:flutter/material.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8E95F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF8E95F5),
        elevation: 0,
        title: Text('Daily Weather'),

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
