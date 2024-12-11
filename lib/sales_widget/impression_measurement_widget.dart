import 'package:flutter/material.dart';

class ImpressionMeasurementWidget extends StatelessWidget {
  const ImpressionMeasurementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MOST SOLD ITEMS',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            // Placeholder for an impression measurement chart
            Container(
              height: 100,
              color: Colors.grey[200],
              child: Center(
                child: Text('No available data',
                    style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
