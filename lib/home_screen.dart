// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/convert_lating_to_address.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const CameraPosition InitialCameraPosition =
      CameraPosition(target: LatLng(30.169570, 71.433986), zoom: 14.4746);

  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(30.169570, 71.433986),
      infoWindow: InfoWindow(title: 'First Location'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(30.169575, 70.433989),
      infoWindow: InfoWindow(title: 'Second Location'),
    ),
  ];

  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Google Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_vert_outlined),
            tooltip: 'Latitude Longitude to Address Conversion',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConvertLatLngToAddress()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: InitialCameraPosition,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.location_city,
        ),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(
                  target: LatLng(30.169575, 70.433989), zoom: 7)));
          setState(() {});
        },
      ),
    );
  }
}
