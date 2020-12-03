import 'package:budgetmeet/services/users_blco.dart';
import 'package:budgetmeet/src/preferences/user_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLogged = false;
  bool _loading = false;

  User get userLogged {
    return _auth.currentUser;
  }

  bool get isLogged {
    return _isLogged;
  }

  set isLogged(bool value) {
    this._isLogged = value;
    notifyListeners();
  }

  bool get loading {
    return _loading;
  }

  set loading(bool value) {
    this._loading = value;
    notifyListeners();
  }

  Future login() async {
    final userCollection = BlocUsers();
    loading = true;
    var user = await _signInWithGoogle();

    loading = false;
    if (user != null) {
      _isLogged = true;
      userCollection.createUser(user.user);
      final preferences = new UserPreference();
      await preferences.initPrefs();
      preferences.uid = user.user.uid;
      preferences.displayName = user.user.displayName;
      preferences.email = user.user.email;
      preferences.photoURL = user.user.photoURL;
      notifyListeners();
    } else {
      _isLogged = false;
      notifyListeners();
    }
  }

  void logout() async {
    loading = true;

    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove('uid ');
    preferences.remove('displayName');
    preferences.remove('email ');
    preferences.remove('photoURL ');
    await _auth.signOut();
    _isLogged = false;
    loading = false;
    notifyListeners();
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
