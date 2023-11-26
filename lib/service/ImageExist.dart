import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TestImage extends StatefulWidget {
  final String assetImagePath ;
  final double height;
  final double width;
  const TestImage({super.key, required this.assetImagePath, required this.height, required this.width});
  @override
  _TestImage createState() => _TestImage();
}

class _TestImage extends State<TestImage> {

  bool isImageExist = false;

  @override
  void initState() {
    super.initState();
    testImage();
  }

  Future<void> testImage() async {
    try {
      await rootBundle.load(widget.assetImagePath);
      setState(() {
        isImageExist = true;
      });
    }
    catch (e) {
      print('Error checking asset image existence: ${widget.assetImagePath}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isImageExist
          ? Image.asset(widget.assetImagePath,height: widget.height,width: widget.width )
          : Image.asset('assets/error.png',height: widget.height,width: widget.width),
    );
  }
}
