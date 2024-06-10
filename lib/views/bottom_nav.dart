import 'package:flutter/material.dart';
import 'package:mapsense/views/home_page.dart';
import 'package:mapsense/views/user_coordinates.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> pages = [];
  int selectedIndex = 0;
  final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();


  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(key: _homePageKey),
      const UserCoordinates(),
    ];
  }

  void _onFabPressed() {
    if (selectedIndex == 0) {
      _homePageKey.currentState?.onFabPressed();
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            activeIcon: Icon(Icons.bookmarks_rounded),
            label: 'Coordinates',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _onFabPressed();
              },
              child: const Icon(Icons.gps_fixed_rounded),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
