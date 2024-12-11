import 'package:flutter/material.dart';
import 'package:otop_front/chart_widget/chart_bar.dart';

class SpendByChannelWidget extends StatefulWidget {
  const SpendByChannelWidget({super.key});

  @override
  State<SpendByChannelWidget> createState() => _SpendByChannelWidgetState();
}

class _SpendByChannelWidgetState extends State<SpendByChannelWidget> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOTAL SALES',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Row(
                      children: [
                        Text(
                          selectedDate == null
                              ? 'PICK A DATE'
                              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.orange),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.calendar_today, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 340,
                color: Colors.grey[200],
                child: BarGraph(
                  data: [30, 50, 80, 60, 90, 70],
                  labels: [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat'
                  ], // Labels for each bar
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
