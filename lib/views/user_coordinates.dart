import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapsense/view_models/google_signin.dart';
import 'package:mapsense/view_models/location_viewmodel.dart';
import 'package:mapsense/views/widgets/coord_list.dart';
import 'package:provider/provider.dart';

class UserCoordinates extends StatelessWidget {
  const UserCoordinates({super.key});

  @override
  Widget build(BuildContext context) {
    final locationVM = Provider.of<LocationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Co-ordinates',
          style: TextStyle(fontFamily: GoogleFonts.montserrat().fontFamily),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                GoogleSignInProvider().logout();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: FutureBuilder(
        future: locationVM.getLocationsFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final locations = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [CoordList(locations: locations!)],
              ),
            );
          }
        },
      ),
    );
  }
}
