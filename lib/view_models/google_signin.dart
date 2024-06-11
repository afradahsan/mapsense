import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mapsense/view_models/location_viewmodel.dart';
import 'package:provider/provider.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context) async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser==null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

     final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userCredential.user;
    final locationViewModel = Provider.of<LocationViewModel>(context, listen: false);
    locationViewModel.setCurrentUser(user);

    notifyListeners();
  }

  Future<void> logout() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

}