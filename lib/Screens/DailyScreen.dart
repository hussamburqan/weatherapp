import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../Model/DailyData.dart';
import '../service/HoursService.dart';
import '../service/ImageExist.dart';

class DailyScreen extends StatefulWidget {

  final city;
  const DailyScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  HoursService hoursService = HoursService();
  List<DailyData>? daysData;

  Future<void> refresh() async {

    await Future.delayed(const Duration(milliseconds: 10));

    await getDaily();

  }

  Future<void> getDaily() async {
    try {
      await Future.delayed(const Duration(milliseconds: 10));
      final newDailyData = await hoursService.gethoursData(widget.city,'7' /* days */);
      setState(() {
        daysData = newDailyData.cast<DailyData>();
      });

    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getDaily();
  }

  String getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: refresh,
      backgroundColor: Colors.white30,
      height: 200,
      color: Colors.white12,
      animSpeedFactor: 2,
      showChildOpacityTransition: true,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemCount: daysData?.length ?? 0,
          itemBuilder: (context, index) {
            final day = daysData![index];
            DateTime dateTime = DateTime.parse('${day.dateTime}');


            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0,left: 8.0,right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors: [
                      Color(0xD9706E6E),
                      Color(0xD93D3C3C),
                    ])
                ),
                child: SizedBox(
                  height: 100,
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
                                getDayName(dateTime.weekday),
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              Text('High : ${day.tempCH}°C',style: const TextStyle(color: Colors.white)),
                              Text('Low : ${day.tempCL}°C' ,style: const TextStyle(color: Colors.white)),
                              Text('${day.condition}' ,style: const TextStyle(color: Colors.white)),

                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: TestImage(assetImagePath: 'assets/${day.condition}.png',width: 80,height: 80),
                      ),

                    ],
                  ),
                ),),
            );
          },
        ),
      ),
    );
  }
}
