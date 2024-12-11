import 'package:flutter/material.dart';

class TotalSpendWidget extends StatelessWidget {
  const TotalSpendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Card(
        surfaceTintColor: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // First Row for Icon
              Row(
                children: [
                  Icon(Icons.analytics_outlined, size: 30, color: Colors.blue),
                  SizedBox(width: 120),
                  Text('₱50, 000.00',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Sales',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  SizedBox(width: 90),
                  Text('+33.45%', style: TextStyle(color: Colors.green)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(child: TotalSpendWidget()),
    ),
  ));
}
