import 'package:flutter/material.dart';

class Util {
  PreferredSizeWidget appBarUtil(String title) {
    return AppBar(
      centerTitle: true,
      elevation: 5,
      title: Text(title),
    );
  }

  Visibility visibleUtil(bool visible, String text) {
    return Visibility(
        visible: visible,
        child: Text(text,
            style: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold)));
  }

  Text textPeaje(String text) {
    return Text(text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18));
  }
}
