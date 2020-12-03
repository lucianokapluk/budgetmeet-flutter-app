import 'package:flutter/material.dart';

inputDecoration(textHint) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
      borderRadius: BorderRadius.circular(20.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
      borderRadius: BorderRadius.circular(20.0),
    ),
    hoverColor: Colors.orange,
    contentPadding: const EdgeInsets.all(8.0),
    disabledBorder: InputBorder.none,
    hintText: textHint,
  );
}

inputDecorationIcon(textHint) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
      borderRadius: BorderRadius.circular(20.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
      borderRadius: BorderRadius.circular(20.0),
    ),
    hoverColor: Colors.orange,
    contentPadding: const EdgeInsets.all(8.0),
/*     disabledBorder: InputBorder.none, */
    hintText: textHint,
  );
}
