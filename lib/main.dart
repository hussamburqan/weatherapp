import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'Mains/Second main.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('Home');
  await Hive.openBox('Places');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => PlaceProvider(),)
    ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SecondMain()
        ),
    );
  }
}

class PlaceProvider extends ChangeNotifier{
  final _Home = Hive.box('Home');

  void SetPlace(String select){
    _Home.put(1, select);
    notifyListeners();
  }

  String getPlace(){
    return _Home.get(1) ?? 'Hebron Ps';
  }
}