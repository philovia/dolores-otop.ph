import 'package:flutter/material.dart';

Widget quantityInput() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        icon: Icon(Icons.remove),
        onPressed: () {},
      ),
      Text('1', style: TextStyle(fontSize: 18)),
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {},
      ),
    ],
  );
}
