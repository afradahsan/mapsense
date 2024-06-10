import 'package:flutter/material.dart';
import 'package:mapsense/services/db_services.dart';
import 'package:mapsense/views/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'view_models/location_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Map Sense',
        home: BottomNav()
      ),
    );
  }
}