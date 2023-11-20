import 'package:flutter/material.dart';
import '../Data/City Data.dart';
import '../Mains/Second main.dart';
import 'PlacesScreen.dart';

class DrawerHome extends StatefulWidget {

  final Function(int) onPageSelected;

  const DrawerHome({super.key, required this.onPageSelected});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {

  List<City> cities = City.citiesList;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 120),
          //logo
          //DrawerHeader(child: Image.asset('')),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: ListTile(
              leading: Icon(Icons.flag),
              title: Text('Home',style: TextStyle(color: Colors.cyan),),
              onTap: () {
                setState(() {
                  widget.onPageSelected(1);

                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: ListTile(
              leading: Icon(Icons.flag),
              title: Text('Place',style: TextStyle(color: Colors.cyan),),
              onTap: () {
                setState(() {
                  widget.onPageSelected(2);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
