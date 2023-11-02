import 'package:flutter/material.dart';

class Util {
  PreferredSizeWidget appBarUtil(String title) {
    return AppBar(
      centerTitle: true,
      elevation: 5,
      title: Text(title),
    );
  }
}
