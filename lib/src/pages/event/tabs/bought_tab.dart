import 'package:budgetmeet/services/products_bloc.dart';

import 'package:budgetmeet/src/pages/event/widgets/ProductItemBought.dart';
import 'package:budgetmeet/src/pages/event/widgets/total_price.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ListOfProductsBought extends StatelessWidget {
  final String groupId;
  final String eventId;
  ListOfProductsBought({Key key, this.groupId, this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> productsBoughtStreem =
        BlocProducts().getProductBought(groupId, eventId);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: productsBoughtStreem,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot product = snapshot.data.docs[index];

                        return Dismissible(
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.deepOrange,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Deshacer \n Compra',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                            onDismissed: (direction) {
                              BlocProducts().deleteProductBought(groupId,
                                  eventId, product.id, product['productName']);
                            },
                            key: ValueKey(product.id),
                            child: ProductItemBought(
                              idGroup: groupId,
                              idEvent: eventId,
                              idproduct: product.id,
                              productName: product['productName'],
                              price: product['price'],
                              whoPay: product['whoPay'],
                              photoURL: product['photoURL'],
                            ));
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
        TotalPrice(
          groupId: groupId,
          eventId: eventId,
          fontSize: 35.0,
        )
      ],
    ));
  }
}
