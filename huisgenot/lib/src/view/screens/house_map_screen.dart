import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/house_controller.dart';
import '../../model/house_model.dart';


class HouseMapScreen extends StatefulWidget {
  const HouseMapScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HouseMapScreen> createState() => _HouseMapScreenState();
}

class _HouseMapScreenState extends State<HouseMapScreen> {
  late GoogleMapController mapController;
  final HouseController _houseController = HouseController();

  final LatLng _center = const LatLng(53.23, 6.570570);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  List<House> houses = []; // Initialize with an empty list
  Set<Marker> _getMarkers() {
    return houses
        .map(
          (house) => Marker(
        markerId: MarkerId(house.id),
        position: LatLng(house.lat, house.lng),
            onTap: () {
              _showCustomInfoWindow(house);
            },
      ),
    ).toSet();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Houses', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF0D1702),
          leading: Container(
            margin: const EdgeInsets.all(8.0), // Add margin here
            child: IconButton(
              icon: const Icon(Icons.chevron_left , color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),),

        body: StreamBuilder<List<House>>(
          stream: _houseController.getHouses(), // Assuming getHouses is accessible here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              houses = snapshot.data ?? []; // Update the houses list
              return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
                markers: _getMarkers(),
              );
            }
          },
        ),
      ),
    );

  }

  void _showCustomInfoWindow(House house) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 150, // Adjust the height as needed
          color: Color(0xFF0D1702),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(house.name, style: TextStyle(color: Colors.white)),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle button press
                      },
                    ),
                  ],
                ),
                subtitle: Text(house.address, style: TextStyle(color: Color(0xFFA1C47E))),
              ),
            ],
          ),
        );
      },
    );
  }

}
