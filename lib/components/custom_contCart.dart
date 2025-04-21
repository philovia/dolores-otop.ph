// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:otop_front/widget/cart_page.dart';
// import 'package:otop_front/widget/supp_page.dart';

class CustomContcart extends StatelessWidget {
  const CustomContcart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(186, 198, 228, 237),
        title: Column(
          children: [
            SizedBox(height: 32.0, width: 20.0),
            Row(
              children: [
                Text('Orders', style: TextStyle(fontSize: 18)),
              ],
            ),
            Divider(color: const Color.fromARGB(223, 137, 134, 134))
          ],
        ),
      ),
      body: Center(
        child: Container(
          // width: containerWidth,

          padding: EdgeInsets.only(
            bottom: 10,
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(186, 198, 228, 237),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 156, 151, 151).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
          ),
          // to put the listview inside the container
          child: Column(
            children: [
              CartItemWidget()
              // CartItemWidget(
              //   productName: 'Analog Magazine Rack',
              //   price: 120.0,
              //   quantity: 2,
              //   total: 240.0,
              // ),
              // CartItemWidget(
              //   productName: 'Closca Helmet',
              //   price: 132.0,
              //   quantity: 1,
              //   total: 132.0,
              // ),
              // CartItemWidget(
              //   productName: 'Sigg Water Bottle',
              //   price: 23.0,
              //   quantity: 2,
              //   total: 46.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(home: CustomContcart()),
  );
}
