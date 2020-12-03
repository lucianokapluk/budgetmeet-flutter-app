import 'package:budgetmeet/services/products_bloc.dart';
import 'package:budgetmeet/src/pages/utils/input_decoration.dart';

import 'package:flutter/material.dart';

class InputNewProduct extends StatelessWidget {
  final String groupId;
  final String eventId;

  InputNewProduct({Key key, this.groupId, this.eventId});
  final TextEditingController inputTextMessage = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: inputTextMessage,
                  decoration: inputDecorationIcon(
                    'Agrega un producto a comprar..',
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              IconButton(
                onPressed: () {
                  BlocProducts().addProduct(groupId, eventId, {
                    'productName': inputTextMessage.text,
                    'price': '0',
                    'whoPay': '',
                  });
                  inputTextMessage.text = '';
                },
                icon: Icon(Icons.done),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
