import 'package:flutter/material.dart';
import 'package:otop_front/chart_widget/sample_chart.dart';


class ContextualWidget extends StatelessWidget {
  const ContextualWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CATEGORIES',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            // Replace placeholder with DonutPieChart
            SizedBox(
              height: 122,
              child: DonutPieChart(
                data: [30, 50, 80, 60, 90, 70], // Example data
                labels: [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat'
                ], // Example labels
              ),
            ),
          ],
        ),
      ),
    );
  }
}
