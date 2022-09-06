import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:maps/get_user_current_location.dart';

class ConvertLatLngToAddress extends StatefulWidget {
  const ConvertLatLngToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLatLngToAddress> createState() => _ConvertLatLngToAddressState();
}

class _ConvertLatLngToAddressState extends State<ConvertLatLngToAddress> {
  String providedcoordinates = '';
  String coordinatestoAddress = '';
  String providedAddress = '';
  String addresstoCoordinates = '';
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Conversion'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pin_drop_outlined),
            tooltip: 'Get Current Location',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GetCurrentLocation()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text(
                          'Coordinates to Address',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        controller: latitudeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Enter Latitude',
                            labelText: 'Latitude',
                            // errorText: 'Please enter 13-digit CNIC Number.',
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.my_location,
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: TextFormField(
                        controller: longitudeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Enter Longitude',
                            labelText: 'Longitude',
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.my_location,
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Provided Coordinates: ' +
                            latitudeController.text.toString() +
                            " " +
                            longitudeController.text.toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Coordinates to Address: \n' +
                          coordinatestoAddress +
                          '\n'),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // From coordinates to address
                        dynamic latitude =
                            double.parse(latitudeController.text.toString());
                        dynamic longitude =
                            double.parse(longitudeController.text.toString());

                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(latitude, longitude);

                        setState(() {
                          providedcoordinates = "$latitude, $longitude";
                          coordinatestoAddress =
                              placemarks.reversed.last.toString();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, bottom: 10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.sync,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    ' Convert Coordinates to Address',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Center(
                            child: Text(
                              'Address to Coordinates',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Enter Address',
                            labelText: 'Address',
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.place_outlined,
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Provided Address: ' +
                          addressController.text.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Address to Coordinates: ' +
                          addresstoCoordinates.toString()),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // From address to coordinates
                        String address = addressController.text.toString();
                        List<Location> locations =
                            await locationFromAddress(address);

                        setState(() {
                          providedAddress = address;
                          addresstoCoordinates =
                              locations.last.latitude.toString() +
                                  ", " +
                                  locations.last.longitude.toString();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, bottom: 10, top: 20),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.sync,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    ' Convert Address to Coordinates',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
