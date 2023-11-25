import 'package:flutter/material.dart';

import '../Model/City Data.dart';

class DrawerHome extends StatefulWidget {

  final Function(int) onPageSelected;

  const DrawerHome({super.key, required this.onPageSelected});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0x0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xBE060D19),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0), // adjust as needed
            bottomRight: Radius.circular(30.0), // adjust as needed
          ),
        ),
        child: Column(
          children: [

            //logo
            DrawerHeader(padding: const EdgeInsets.all(10),
                child: Image.asset('assets/icon.png')),

            Padding(
              padding: const EdgeInsets.only(left: 10.0 ,right: 10.0),
              child: Container(
                  decoration: BoxDecoration(color: const Color(0xFF2949BB),borderRadius: BorderRadius.circular(10)),
                  height: 55,
                  child: ListTile(
                    leading: const Icon(Icons.home,color: Colors.white),
                    title: const Text('Home',style: TextStyle(color: Color(0xFFFFFFFF)),),

                    onTap: () {
                      setState(() {
                        widget.onPageSelected(0);
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,top: 10,right: 10),
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF2949BB), borderRadius: BorderRadius.circular(10)),
                height: 55,
                child: ListTile(
                  leading: const Icon(Icons.flag,color: Colors.white),
                  title: const Text('Place',style: TextStyle(color: Color(0xFFFFFFFF)),),

                  onTap: () {
                    setState(() {
                      widget.onPageSelected(1);
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0 ,top: 10,right: 10.0),
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF2949BB),borderRadius: BorderRadius.circular(10)),
                height: 55,
                child: ListTile(
                  leading: const Icon(Icons.calendar_month,color: Colors.white),
                  title: const Text('Daily Weather',style: TextStyle(color: Color(0xFFFFFFFF)),),

                  onTap: () {
                    setState(() {
                      widget.onPageSelected(2);
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0 ,top: 10,right: 10.0),
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF2949BB),borderRadius: BorderRadius.circular(10)),
                height: 55,
                child: ListTile(
                  leading: const Icon(Icons.timer,color: Colors.white),
                  title: const Text('Hourly Weather',style: TextStyle(color: Color(0xFFFFFFFF)),),

                  onTap: () {
                    setState(() {
                      widget.onPageSelected(3);
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
