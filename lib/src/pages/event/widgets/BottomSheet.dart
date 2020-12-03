import 'package:budgetmeet/src/pages/event/widgets/ComprarBtn.dart';
import 'package:flutter/material.dart';

class BottomSheetCustom extends StatelessWidget {
  final String productName;
  final String idGroup;
  final String idEvent;
  final String idproduct;
  const BottomSheetCustom(
      {Key key, this.productName, this.idGroup, this.idEvent, this.idproduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ComprarBtn(
                productName: productName,
                idGroup: idGroup,
                idEvent: idEvent,
                idproduct: idproduct,
              ),
              Row(
                children: [
                  Icon(Icons.edit_outlined, color: Colors.orange),
                  Text(' Editar', style: TextStyle(fontSize: 22)),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.redAccent,
                  ),
                  Text(' Borrar', style: TextStyle(fontSize: 22)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
