import 'package:budgetmeet/services/products_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  final String groupId;
  final String eventId;
  final double fontSize;
  TotalPrice({Key key, this.groupId, this.eventId, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> totalPriceStream =
        BlocProducts().getTotalResume(groupId, eventId);
    return StreamBuilder(
      stream: totalPriceStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var totalPrice = 0;
          for (var item in snapshot.data.docs) {
            totalPrice = int.parse(item.data()['price']) + totalPrice;
          }
          return Text(
            'Total \$ ' + totalPrice.toString(),
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          );
        } else {
          return Text('das');
        }
      },
    );
  }
}
