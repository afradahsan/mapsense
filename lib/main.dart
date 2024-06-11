import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mapsense/firebase_options.dart';
import 'package:mapsense/services/db_services.dart';
import 'package:mapsense/view_models/google_signin.dart';
import 'package:mapsense/views/widgets/check_loggedin.dart';
import 'package:provider/provider.dart';
import 'view_models/location_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DatabaseService().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Map Sense',
        home: CheckLoggedIn()
      ),
    );
  }
}