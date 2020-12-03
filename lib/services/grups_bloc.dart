import 'package:budgetmeet/src/preferences/user_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlocGroups {
  //GROUPS-------------------------------------------------------
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userPreference = UserPreference();
  Future createGroup(admin, groupName, List members) async {
    String collectionRef = 'groups';
    String docId = _firestore.collection(collectionRef).doc().id;

    DocumentReference groups =
        FirebaseFirestore.instance.collection(collectionRef).doc(docId);
    return await groups.set({
      'id': docId, // 42
      'groupName': groupName, // John Doe
      'admin': admin,
      'created': FieldValue.serverTimestamp(),

      'members': members
    }).then((value) {
      addMessage(
        groups.id,
        {
          'user': userPreference.displayName,
          'uid': userPreference.uid,
          'type': 'info',
          'text': 'ha creado el grupo $groupName',
          'created': DateTime.now()
        },
      );
    });
  }

  getGroups(groupId) {
    return _firestore
        .collection('groups')
        .where("members", arrayContains: groupId)
        .orderBy("created", descending: true)
        .snapshots();
  }

  //CHAT---------------------------------------
  Future<void> addMessage(String groupId, message) {
    return _firestore
        .collection("groups")
        .doc(groupId)
        .collection("chats")
        .add(message)
        .catchError((e) {
      print(e.toString());
    });
  }

  getChats(String groupIds) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(groupIds)
        .collection('chats')
        .orderBy("created", descending: true)
        .snapshots();
  }

  Future<dynamic> getLastChat(String groupIds) async {
    final Query document = FirebaseFirestore.instance
        .collection('groups')
        .doc(groupIds)
        .collection('chats')
        .orderBy("created", descending: true);
    return await document.get().then((QuerySnapshot snapshot) async {
      return snapshot.docs[0].data()['uid'];
    });
  }

  // EVENTS---------------------------------------
  Future<void> addEvents(String groupId, event) {
    return _firestore
        .collection("groups")
        .doc(groupId)
        .collection("events")
        .add(event)
        .catchError((e) {
      print(e.toString());
    });
  }

  getEvents(String groupIds) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(groupIds)
        .collection('events')
        .orderBy("date", descending: true)
        .snapshots();
  }
}
