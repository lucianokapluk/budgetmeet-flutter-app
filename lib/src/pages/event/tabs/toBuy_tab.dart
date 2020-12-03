import 'package:budgetmeet/services/products_bloc.dart';
import 'package:budgetmeet/src/pages/event/widgets/InputNewProduct.dart';

import 'package:budgetmeet/src/pages/event/widgets/ProductItem.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ListOfProducts extends StatefulWidget {
  final String groupId;
  final String eventId;
  ListOfProducts({Key key, this.groupId, this.eventId});

  @override
  _ListOfProductsState createState() => _ListOfProductsState();
}

class _ListOfProductsState extends State<ListOfProducts> {
  Stream<QuerySnapshot> productsToBuyStream;

  @override
  void initState() {
    super.initState();
    productsToBuyStream =
        BlocProducts().getProductToBuy(widget.groupId, widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*        floatingActionButton: FloatingActionButton(
          onPressed: () => BlocProducts().addProduct(
              widget.groupId, widget.eventId, {
            'productName': 'asdads',
            'price': '455',
            'whoPay': 'sdaasd',
          
          }),
        ), */
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: productsToBuyStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot product = snapshot.data.docs[index];
                        return ProductItem(
                          idGroup: widget.groupId,
                          idEvent: widget.eventId,
                          idproduct: product.id,
                          productName: product['productName'],
                          price: product['price'],
                          whoPay: product['whoPay'],
                        );
                      });
                } else {
                  return Center(child: Text('No tienes productos'));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        InputNewProduct(
          groupId: widget.groupId,
          eventId: widget.eventId,
        )
      ],
    ));
  }
}
