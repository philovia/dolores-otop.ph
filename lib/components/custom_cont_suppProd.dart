// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:otop_front/widget_pos/bar_chart.dart';
// import 'package:otop_front/widget_pos/chart_admin.dart';
// import 'package:otop_front/widget_pos/chart_bar.dart';
// import 'package:otop_front/widget_pos/sample_chart.dart';

class CustomContsuppProd extends StatelessWidget {
  CustomContsuppProd({super.key});
  final List<double> data = [30, 50, 80, 60, 90, 70]; // Example data
  final List<String> labels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ]; // X-axis labels

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(186, 198, 228, 237),
        title: Column(
          children: [
            SizedBox(height: 32.0, width: 20.0),
            Center(
              child: Row(
                children: [
                  Text('Sales', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Divider(color: const Color.fromARGB(223, 137, 134, 134))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: buildContainerWithChart()),
                  Expanded(child: buildContainerWith()),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: buildContainerChart()),
                  Divider()
                  // Expanded(child: buildContainer("")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildContainer(String label) {
  //   return Container(
  //       margin: const EdgeInsets.all(6),
  //       decoration: BoxDecoration(
  //         color: const Color.fromARGB(186, 198, 228, 237),
  //         boxShadow: [
  //           BoxShadow(
  //             color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
  //             spreadRadius: 5,
  //             blurRadius: 7,
  //             offset: Offset(0, 3),
  //           ),
  //         ],
  //       ),
  //       child: DonutPieChart(data: data, labels: labels));
  // }

  Widget buildContainerWithChart() {
    return Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(186, 198, 228, 237),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        // child: BarGraph(
        //     data: data, labels: labels) // Insert your chart widget here
        );
  }

  Widget buildContainerWith() {
    return Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(186, 198, 228, 237),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        // child: PieChartSample3() // Insert your chart widget here
        );
  }

  Widget buildContainerChart() {
    return Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(186, 198, 228, 237),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        // child: BarChartSample7() // Insert your chart widget here
        );
  }
}

void main() {
  runApp(
    MaterialApp(home: CustomContsuppProd()),
  );
}
