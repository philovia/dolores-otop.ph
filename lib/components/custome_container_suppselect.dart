import 'package:flutter/material.dart';
import 'package:otop_front/widget/supplier_product_page.dart';
// import 'package:otop_front/widget/supplier_form.dart';
// import 'package:otop_front/widget/pos_widget.dart';

class CustomContainerSupselect extends StatelessWidget {
  const CustomContainerSupselect({super.key});

  @override
  Widget build(BuildContext context) {
    // get the width of the screen
    // double screenWidth = MediaQuery.of(context).size.width;

    // set the container width
    // double containerWidth;
    // if (screenWidth <= 500) {
    //   containerWidth = screenWidth * 0.9; // magagamit yung .9 percent ng screen
    // } else if (screenWidth > 500 && screenWidth <= 1100) {
    //   containerWidth = 500; // magagmmit yug max widt ng screen na 500
    // } else {
    //   containerWidth = 1700;
    // }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(186, 198, 228, 237),
        title: Column(
          children: [
            SizedBox(height: 32.0, width: 20.0),
            Row(
              children: [
                Text('Supplier Selection', style: TextStyle(fontSize: 18)),
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
          child: SupplierListWidget(),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(home: CustomContainerSupselect()),
  );
}
