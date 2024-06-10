import 'package:flutter/material.dart';
import 'package:mapsense/view_models/location_viewmodel.dart';
import 'package:provider/provider.dart';

class UserCoordinates extends StatelessWidget {
  const UserCoordinates({super.key});

  @override
  Widget build(BuildContext context) {
        final locationVM = Provider.of<LocationViewModel>(context);

    return Scaffold(
      body: FutureBuilder(
        future: locationVM.getLocationsFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final locations = snapshot.data;
            return ListView.builder(
              itemCount: locations!.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return ListTile(
                  title: Text('Lat: ${location.latitude}, Lng: ${location.longitude}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}