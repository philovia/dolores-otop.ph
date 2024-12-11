import 'package:flutter/material.dart';
import 'dart:math';

class DonutPieChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;

  const DonutPieChart({super.key, required this.data, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: 100,
      child: CustomPaint(
        painter: DonutPieChartPainter(data, labels),
      ),
    );
  }
}

class DonutPieChartPainter extends CustomPainter {
  final List<double> data;
  final List<String> labels;
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  DonutPieChartPainter(this.data, this.labels);

  @override
  void paint(Canvas canvas, Size size) {
    final total = data.reduce((a, b) => a + b);

    double startAngle = -pi / 2;
    final outerRadius = min(size.width / 2, size.height / 2) - 20;

    final innerRadius = outerRadius * 0.6;

    final center = Offset(size.width / 2, size.height / 2);
    final textStyle = TextStyle(color: Colors.black, fontSize: 12);

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i] / total) * 2 * pi;
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }

    // Draw the inner circle to create the hollow center
    final innerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, innerRadius, innerCirclePaint);

    // Draw labels
    startAngle = -pi / 2; // Reset start angle for label placement
    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i] / total) * 2 * pi;
      final labelAngle = startAngle + sweepAngle / 2;
      final labelX = center.dx + (outerRadius + 20) * cos(labelAngle);
      final labelY = center.dy + (outerRadius + 20) * sin(labelAngle);

      // Draw the labels
      TextPainter(
        text: TextSpan(text: labels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(canvas, Offset(labelX - 15, labelY - 10));

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Custom Donut Pie Chart')),
      body: Center(
        child: DonutPieChart(
          data: [30, 50, 80, 60, 90, 70], // Example data
          labels: [
            'Mon',
            'Tue',
            'Wed',
            'Thu',
            'Fri',
            'Sat'
          ], // Labels for the pie chart
        ),
      ),
    ),
  ));
}
