import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsense/models/location_model.dart';
import 'package:mapsense/services/db_services.dart';
import 'package:mapsense/services/location_services.dart';
import 'package:mapsense/views/widgets/snackbar.dart';

class LocationViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser;

  Position? yourLocation;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  final List<LatLng> pathList = [];

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  void onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    try {
      yourLocation = await LocationServices.determinePosition();
      final position = yourLocation!;
      debugPrint('urlocation: $yourLocation');

      final LatLng newPosition = LocationServices.positionToLatLng(position);

      pathList.add(newPosition);

      markers.add(Marker(
        markerId: MarkerId(newPosition.toString()),
        infoWindow: InfoWindow(title: 'Location ${pathList.length}'),
        icon: BitmapDescriptor.defaultMarkerWithHue((pathList.length * 60) % 360),
        position: newPosition,
      ));

      polylines.add(Polyline(
        polylineId: const PolylineId('path'),
        points: pathList,
        color: Colors.black,
        width: 5,
      ));
      debugPrint('Markers: $markers');

      await goToCurrentPosition();
      notifyListeners();

      await _databaseService.insertLocation(LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      ));

      await _firestore.collection('locations').add({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'user_id': currentUser?.uid ?? 'unknown_user',
      });
      debugPrint('Location inserted into DB');
    } catch (e) {
      showSnackbar(context, 'Error Fetching Location');
      debugPrint('Error getting current location: $e');
      
    }
  }

  Future<void> goToCurrentPosition() async {
    try {
      final GoogleMapController controller = await _controller.future;
      final CameraPosition currentPosition = CameraPosition(
        target: LocationServices.positionToLatLng(yourLocation!),
        zoom: 14.4746,
      );

      await controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
    } catch (e) {
      debugPrint('Error moving camera to current position: $e');
    }
  }

  Future<List<LocationModel>> getLocationsFromDatabase() async {
    return _databaseService.getLocations();
  }

  void setCurrentUser(User? user) {
    currentUser = user;
    notifyListeners();
  }
}