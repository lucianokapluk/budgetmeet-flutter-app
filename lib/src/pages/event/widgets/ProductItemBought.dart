import 'package:flutter/material.dart';

class ProductItemBought extends StatelessWidget {
  final String idGroup;
  final String idEvent;
  final String idproduct;
  final String productName;
  final String price;
  final String whoPay;
  final String photoURL;

  ProductItemBought({
    Key key,
    this.idGroup,
    this.idEvent,
    this.idproduct,
    this.price,
    this.productName,
    this.whoPay,
    this.photoURL,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          ExpansionTile(
            leading: CircleAvatar(
                radius: 20.0, backgroundImage: NetworkImage(photoURL)),
            trailing: Text('\$ $price'),
            title: Text(
              productName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            children: [Text('Precio: \$ $price'), Text('Lo compro $whoPay')],
          ),
        ],
      ),
    );
  }
}
/* 
class ProductItemBought extends StatelessWidget {
  final String idGroup;
  final String idEvent;
  final String idproduct;
  final String productName;
  final String price;
  final String whoPay;

  ProductItemBought({
    Key key,
    this.idGroup,
    this.idEvent,
    this.idproduct,
    this.price,
    this.productName,
    this.whoPay,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price.isNotEmpty ? '\$ ' + price : '\$ 0',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  productName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Divider(
              color: Colors.orange,
            )
          ],
        ),
        onTap: () => {
          showModalBottomSheet(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            context: context,
            builder: (BuildContext context) {
              return BottomSheetCustom(
                productName: productName,
                idEvent: idEvent,
                idGroup: idGroup,
                idproduct: idproduct,
              );
            },
          ),
        },
      ),
    );
  }
}
 */
