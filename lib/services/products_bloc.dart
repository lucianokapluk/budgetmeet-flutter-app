import 'package:cloud_firestore/cloud_firestore.dart';

class BlocProducts {
  Stream<QuerySnapshot> getProductToBuy(String groupIds, String eventId) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(groupIds)
        .collection('events')
        .doc(eventId)
        .collection('products')
        .orderBy('productName', descending: false)
        .snapshots();
  }

  Future<void> addProduct(String groupId, eventId, product) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("events")
        .doc(eventId)
        .collection("products")
        .add(product)
        .catchError((e) {
      print(e.toString());
    });
  }

  Stream<QuerySnapshot> getProductBought(String groupIds, String eventId) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(groupIds)
        .collection('events')
        .doc(eventId)
        .collection('productsbought')
        .orderBy('productName', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getTotalResume(String groupIds, String eventId) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(groupIds)
        .collection('events')
        .doc(eventId)
        .collection('productsbought')
        .snapshots();
  }

  Future<void> addProductToListBought(
      String groupId, eventId, productdata, productId) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("events")
        .doc(eventId)
        .collection("productsbought")
        .add(productdata)
        .then((value) => deleteProductToBuy(groupId, eventId, productId))
        .catchError((e) {
      print(e.toString());
    });
  }

  deleteProductToBuy(String groupId, eventId, productId) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("events")
        .doc(eventId)
        .collection("products")
        .doc(productId)
        .delete()
        .then((value) => print('borrado'))
        .catchError((e) {
      print(e.toString());
    });
  }

  deleteProductBought(String groupId, eventId, productId, productName) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("events")
        .doc(eventId)
        .collection("productsbought")
        .doc(productId)
        .delete()
        .then((value) => addProduct(groupId, eventId,
            {'productName': productName, "price": '', "whoPay": ''}))
        .catchError((e) {
      print(e.toString());
    });
  }
}
