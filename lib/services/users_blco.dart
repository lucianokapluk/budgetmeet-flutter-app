import 'package:budgetmeet/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BlocUsers {
  void createUser(User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return await users
        .doc(user.uid)
        .set({
          'uid': user.uid,
          'displayName': user.displayName.toLowerCase(), // John Doe
          'email': user.email, // Stokes and Sons
          'photoURL': user.photoURL // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  getUsers(String searchField) async {
    if (searchField != '') {
      if (searchField.contains('@')) {
        return FirebaseFirestore.instance
            .collection("users")
            .where('email', isGreaterThanOrEqualTo: searchField)
            .where('email', isLessThan: searchField + 'z')
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection("users")
            .where('displayName', isGreaterThanOrEqualTo: searchField)
            .where('displayName', isLessThan: searchField + 'z')
            .snapshots();
      }
    } else {
      return FirebaseFirestore.instance
          .collection("users")
          .where('displayName', isEqualTo: 'adsasdasdas')
          .snapshots();
    }
  }

  Future<UserBud> getUser(String id) async {
    UserBud user;
    final DocumentReference document =
        FirebaseFirestore.instance.collection('users').doc(id);

    await document.get().then((DocumentSnapshot snapshot) {
      user = UserBud.fromJsonMap(snapshot.data());
    });
    return user;
  }
}
