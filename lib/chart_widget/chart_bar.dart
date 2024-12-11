import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final List<double> data; // List of data for the bars
  final List<String> labels; // List of labels for each bar

  const BarGraph({super.key, required this.data, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20), // Padding around the graph for axis labels
      width: double.infinity,
      height: 255, // Height of the container
      child: CustomPaint(
        painter: BarGraphPainter(data, labels),
      ),
    );
  }
}

class BarGraphPainter extends CustomPainter {
  final List<double> data;
  final List<String> labels;

  BarGraphPainter(this.data, this.labels);

  @override
  void paint(Canvas canvas, Size size) {
    final barPaint = Paint()
      ..color = Color.fromARGB(255, 12, 117, 186)
      ..style = PaintingStyle.fill;

    final textStyle = TextStyle(color: Colors.black, fontSize: 12);
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final barWidth =
        (size.width - 40) / data.length; // Adjusting width for y-axis padding

    // Draw y-axis labels and lines
    for (int i = 0; i <= 5; i++) {
      double y = size.height - (i * size.height / 5);
      double labelValue = maxValue * i / 5;

      // Y-Axis Labels
      TextPainter(
        text: TextSpan(text: labelValue.toStringAsFixed(0), style: textStyle),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(canvas, Offset(0, y - 10)); // Labels on y-axis

      // Horizontal grid lines (optional)
      final gridPaint = Paint()
        ..color = Colors.grey
        ..strokeWidth = 0.5;

      canvas.drawLine(
          Offset(30, y), Offset(size.width, y), gridPaint); // Grid lines
    }

    // Draw bars and labels
    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i] / maxValue) * size.height;
      final barX = i * barWidth + 40;
      final barRect = Rect.fromLTWH(
        barX,
        size.height - barHeight,
        barWidth * 0.6,
        barHeight,
      );

      // Draw the bar
      canvas.drawRect(barRect, barPaint);

      // Draw x-axis labels
      TextPainter(
        text: TextSpan(text: labels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: barWidth)
        // To center the label, we adjust its position to the center of the bar
        ..paint(
            canvas,
            Offset(barX + (barWidth * 0.7 / 2) - 15,
                size.height + 5)); // X-axis labels
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
      appBar: AppBar(title: Text('Custom Bar Graph')),
      body: Center(
        child: BarGraph(
          data: [30, 50, 80, 60, 90, 70], // Example data
          labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'], // X-axis labels
        ),
      ),
    ),
  ));
}
