import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mapsense/views/bottom_nav.dart';
import 'package:mapsense/views/login_page.dart';

class CheckLoggedIn extends StatelessWidget {
  const CheckLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasData) {
              return const BottomNav();
            } else if (snapshot.hasError){
              return const Center(child: Text('Something went wrong'),);
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
