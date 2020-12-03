import 'package:flutter/material.dart';

buttonDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
        tileMode: TileMode.mirror,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0.0,
          0.95,
        ],
        colors: [
          Color.fromRGBO(255, 151, 151, 1),
          Color.fromRGBO(249, 181, 118, 1)
        ],
      ),
      color: Colors.red,
      borderRadius: BorderRadius.circular(100));
}

buttonDecorationDisabled() {
  return BoxDecoration(
      gradient: LinearGradient(
        tileMode: TileMode.mirror,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0.0,
          0.95,
        ],
        colors: [
          Color.fromRGBO(255, 151, 151, 0.2),
          Color.fromRGBO(249, 181, 118, 0.2)
        ],
      ),
      color: Colors.red,
      borderRadius: BorderRadius.circular(100));
}

textButton(textButton) {
  return Text(
    textButton,
    style: TextStyle(
        fontWeight: FontWeight.w400, fontSize: 18.0, color: Colors.white),
  );
}
//elevation
/*    boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ], */
