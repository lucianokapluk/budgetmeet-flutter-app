import 'package:budgetmeet/services/products_bloc.dart';
import 'package:budgetmeet/src/preferences/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../event_provider.dart';

class ComprarBtn extends StatelessWidget {
  final String idGroup;
  final String idEvent;
  final String idproduct;
  final String id;
  final String productName;

  ComprarBtn({
    Key key,
    this.idGroup,
    this.idEvent,
    this.idproduct,
    this.id,
    this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Icon(Icons.shopping_cart_outlined, color: Colors.orange),
          Text('Comprar', style: TextStyle(fontSize: 22)),
        ],
      ),
      onTap: () {
        Navigator.pop(context);
        print(idGroup);
        showDialogComprar(
          context,
          productName,
          idEvent,
          idGroup,
          idproduct,
        );
      },
    );
  }

  showDialogComprar(context, productName, idEvent, idGroup, idproduct) {
    TextEditingController textPriceController = TextEditingController();
    final userPreference = UserPreference();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.orange)),
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.orange),
              ),
              onPressed: () async {
                final eventProvider =
                    Provider.of<EventProvider>(context, listen: false);
                await BlocProducts().addProductToListBought(
                    idGroup,
                    idEvent,
                    {
                      'productName': productName,
                      'idproduct': idproduct,
                      'price': textPriceController.text,
                      'whoPay': userPreference.displayName,
                      'photoURL': userPreference.photoURL,
                      'user_uid': userPreference.uid
                    },
                    idproduct);
                Navigator.pop(context);
                eventProvider.tabEventController.animateTo(1);
              },
              child: Text('Confirmar'),
            ),
          ],
          title: Text(
            'Cuanto pagaste por este producto?',
            style: TextStyle(fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(productName),
              TextFormField(
                controller: textPriceController,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "\$",
                    prefix: Text("\$")),
                cursorColor: Colors.orange,
              )
            ],
          ),
        );
      },
    );
  }
}
