import 'package:flutter/material.dart';

linearCustomGradient() {
  return LinearGradient(
    tileMode: TileMode.mirror,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0.0,
      0.95,
    ],
    colors: [
      Color.fromRGBO(255, 129, 102, 1),
      Color.fromRGBO(249, 181, 118, 1)
    ],
  );
}
