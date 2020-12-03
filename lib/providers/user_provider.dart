import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String get uid {
    return auth.currentUser.uid;
  }

  String get displayName {
    return auth.currentUser.displayName;
  }

  String get email {
    return auth.currentUser.email;
  }

  String get photoURL {
    return auth.currentUser.photoURL;
  }

  void createUser(User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return await users
        .doc(user.uid)
        .set({
          'displayName': user.displayName, // John Doe
          'email': user.email, // Stokes and Sons
          'photoURL': user.photoURL // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
