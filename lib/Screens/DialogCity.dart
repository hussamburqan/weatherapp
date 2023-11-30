import 'package:flutter/material.dart';



class Dialogbox extends StatelessWidget {
  final controller;
  final VoidCallback onsave;
  final VoidCallback oncancel;

  Dialogbox({super.key,required this.controller,required this.onsave  ,required this.oncancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF706E6E),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(controller: controller ,decoration: const InputDecoration(border: OutlineInputBorder() ,hintText: 'Add a new City pls <3',hintStyle: TextStyle(color: Colors.white60)),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(onPressed: onsave,
                  color: Colors.black87,
                  child: const Text('Save',style: TextStyle(color: Colors.white60)),
                ),
                const SizedBox(width: 10),
                MaterialButton(onPressed: oncancel,
                  color: Colors.black87,
                  child: const Text('Cancel',style: TextStyle(color: Colors.white60)),
                ),
              ],)
          ],
        ),

      ),
    );
  }

}
