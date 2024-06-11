import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapsense/models/location_model.dart';

class CoordList extends StatelessWidget {
  const CoordList({super.key, required this.locations});

  final List<LocationModel> locations;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: locations.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          final location = locations[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 80,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/location.png',
                  height: 50,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Latitude: ${location.latitude}',
                      style: TextStyle(
                          fontFamily: GoogleFonts.montserrat().fontFamily),
                    ),
                    Text(
                      'Longitude: ${location.longitude}',
                      style: TextStyle(
                          fontFamily: GoogleFonts.montserrat().fontFamily),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
