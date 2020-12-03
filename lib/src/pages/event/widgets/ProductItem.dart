import 'package:budgetmeet/src/pages/event/widgets/BottomSheet.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String idGroup;
  final String idEvent;
  final String idproduct;
  final String productName;
  final String price;
  final String whoPay;

  ProductItem({
    Key key,
    this.idGroup,
    this.idEvent,
    this.idproduct,
    this.price,
    this.productName,
    this.whoPay,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Column(
          children: [
            Text(
              productName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
