// ignore_for_file: unused_local_variable, file_names

import 'package:flutter/material.dart';
import 'package:otop_front/widget/product_list_cont.dart';
// import 'package:otop_front/widget/supplier_product_listscreen.dart';
// import 'package:otop_front/widget/product_listCont.dart';
// import 'package:otop_front/widget/product_list_cont.dart';

class CustomeConSuppage extends StatelessWidget {
  const CustomeConSuppage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(186, 198, 228, 237),
        title: Column(
          children: [
            const SizedBox(height: 32.0, width: 20.0),
            Row(
              children: const [
                Text('Product List', style: TextStyle(fontSize: 18)),
              ],
            ),
            const Divider(color: Color.fromARGB(223, 137, 134, 134))
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 10,
            left: 10,
            right: 10,
          ),
          decoration: const BoxDecoration(
            color: Color.fromARGB(186, 198, 228, 237),
          ),
          // Display the product list widget
          child: ProductListScreen(),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(home: CustomeConSuppage()),
  );
}
