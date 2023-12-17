import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../service/GetLocationService.dart';

class MapScreen extends StatefulWidget {
  final Function(int) onPageSelected;

  const MapScreen({Key? key, required this.onPageSelected}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  late CameraPosition goToSearchedForPlace;

  @override
  initState() {
    super.initState();
    getMyCurrentLocation();
  }

  Future<void> getMyCurrentLocation() async {
    position = await GetLocation.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));

    widget.onPageSelected(0);
    Provider.of<PlaceProvider>(context, listen: false).SetPlace('${position!.latitude},${position!.longitude}');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : Center(
            child: Container(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(color: Color(0x804F4F52),
                child: Text('Get Your Location')),
            SizedBox(height: 2),
            FloatingActionButton(
              backgroundColor: Color(0xFF706E6E),
              onPressed: _goToMyCurrentLocation,
              child: Icon(Icons.place, color: Colors.white),

            ),
            SizedBox(height: 20),
          ],
        ),

    );
  }
}