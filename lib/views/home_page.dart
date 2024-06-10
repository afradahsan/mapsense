import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsense/view_models/location_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  void onFabPressed(){
    Provider.of<LocationViewModel>(context, listen: false).getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final locationVM = Provider.of<LocationViewModel>(context);
    return Scaffold(
      body: GoogleMap(
          markers: locationVM.markers,
          polylines: locationVM.polylines,
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
            zoom: 14.4746,
          ),
          onMapCreated: locationVM.onMapCreated),
    );
  }
}
