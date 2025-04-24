import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TotalSpendWidget extends StatefulWidget {
  const TotalSpendWidget({super.key});

  @override
  State<TotalSpendWidget> createState() => _TotalSpendWidgetState();
}

class _TotalSpendWidgetState extends State<TotalSpendWidget> {
  double _sales = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOverallAmountSold();
  }

  Future<void> _fetchOverallAmountSold() async {
    try {
      final url = Uri.parse('http://127.0.0.1:8097/api/otop/solds_products'); // Replace with actual endpoint
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _sales = data['overall_amount_sold']?.toDouble() ?? 0.0;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch sales');
      }
    } catch (e) {
      print('Error fetching sales: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        surfaceTintColor: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // important
            children: [
              Row(
                children: [
                  const Icon(Icons.analytics_outlined,
                      size: 30, color: Colors.blue),
                  const Spacer(),
                  _isLoading
                      ? const CircularProgressIndicator(strokeWidth: 2)
                      : Text(
                    '₱${_sales.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Sales',
                      style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
