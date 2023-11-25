import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../Model/Hourly Data.dart';
import '../service/HoursService.dart';

class HoursScreen extends StatefulWidget {
  final city;

  const HoursScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<HoursScreen> createState() => _HoursScreenState();
}

class _HoursScreenState extends State<HoursScreen> {
  HoursService hoursService = HoursService();
  List<HourlyData>? hoursData;
  String state = 'forecast.json';
  int i = 0 ;

  Future<void> refresh() async {

    await Future.delayed(const Duration(milliseconds: 10));
    await getWeather();
    print(i);
  }

  Future<void> getWeather() async {
    try {
      await Future.delayed(const Duration(milliseconds: 10));
      final newHoursData = await hoursService.gethoursData(widget.city, state,'1'/* days */);
      setState(() {
        hoursData = newHoursData.cast<HourlyData>();
      });

    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: refresh,
      backgroundColor: Colors.deepPurple[200],
      height: 200,
      color: Colors.deepPurple,
      animSpeedFactor: 2,
      showChildOpacityTransition: true,
      child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView.builder(
            itemCount: hoursData?.length ?? 0,
            itemBuilder: (context, index) {
              final hours = hoursData![index];
              DateTime dateTime = DateTime.parse('${hours.time}');
              String timeString = "${dateTime.hour}:${dateTime.minute}0";

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SizedBox(
                  height: 90,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                timeString,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  '${hours.temperatureC}°C',
                                  style: const TextStyle(fontSize: 18)),
                              Text('${hours.condition}'),
                            ],
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/${hours.condition}.png',
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
