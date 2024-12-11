import 'package:flutter/material.dart';
import 'package:otop_front/chart_widget/bar_chart_sample7.dart';


class ResonanceScoreWidget extends StatelessWidget {
  const ResonanceScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OUTSTANDING SUPPLIERS',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 355,
                width: double.infinity,
                color: Colors.grey[200],
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: BarChartSample7(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
