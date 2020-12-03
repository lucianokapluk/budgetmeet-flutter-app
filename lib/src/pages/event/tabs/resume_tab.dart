import 'package:budgetmeet/models/user_model.dart';
import 'package:budgetmeet/services/products_bloc.dart';
import 'package:budgetmeet/services/users_blco.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResumeTab extends StatelessWidget {
  final String groupId;
  final String eventId;
  final double fontSize;
  ResumeTab({Key key, this.groupId, this.eventId, this.fontSize})
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
          var userput = [];
          for (var item in snapshot.data.docs) {
            final product = item.data();
            userput.add(product['user_uid']);
            totalPrice = int.parse(product['price']) + totalPrice;
          }

          final seen = Set<String>();
          final usuariosQuePusieron =
              userput.where((str) => seen.add(str)).toList();
          print(usuariosQuePusieron);

          List iop = [];

          for (var user in usuariosQuePusieron) {
            var totalCadauser = 0;
            for (var item in snapshot.data.docs) {
              final product = item.data();
              if (user == product['user_uid']) {
                totalCadauser = totalCadauser + int.parse(product['price']);
              }
            }

            var ov = {"user": user, "totalprice": totalCadauser};
            iop.add(ov);
          }
          print(iop);
          Future<UserBud> userName =
              BlocUsers().getUser('y2Cy3kbsA9PTg5JITx6wOdsLhDz1');
          return ListView.builder(
              itemCount: iop.length,
              itemBuilder: (BuildContext context, index) {
                return FutureBuilder<UserBud>(
                  future: userName,
                  builder:
                      (BuildContext context, AsyncSnapshot<UserBud> snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.displayName +
                          iop[index]['totalprice'].toString());
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                );
                /*  return Text(
                    iop[index]['user'] + iop[index]['totalprice'].toString()); */
              });
        } else {
          return Text('das');
        }
      },
    );
  }

  dameuser() async {
    UserBud usi = await BlocUsers().getUser('y2Cy3kbsA9PTg5JITx6wOdsLhDz1');
    print(usi.displayName);
  }
}
