import 'package:flutter/material.dart';

import '../models/product_sales.dart';
import '../services/sold_product_service.dart';
class ImpressionMeasurementWidget extends StatefulWidget {
  const ImpressionMeasurementWidget({super.key});

  @override
  State<ImpressionMeasurementWidget> createState() => _ImpressionMeasurementWidgetState();
}

class _ImpressionMeasurementWidgetState extends State<ImpressionMeasurementWidget> {
  final SoldProductService _service = SoldProductService();
  List<ProductSales> _topProducts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchTopProducts();
  }

  Future<void> _fetchTopProducts() async {
    try {
      final products = await _service.getTopSoldProducts();
      setState(() {
        _topProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load data';
        _isLoading = false;
      });
    }
  }

  String _getOrdinal(int number) {
    if (number == 1) return '1st';
    if (number == 2) return '2nd';
    if (number == 3) return '3rd';
    return '${number}th';
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MOST SOLD ITEMS',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(child: Text(_error!, style: TextStyle(color: Colors.red)))
                  : _topProducts.isEmpty
                  ? const Center(child: Text('No available data', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                itemCount: _topProducts.length,
                itemBuilder: (context, index) {
                  final product = _topProducts[index];
                  final position = _getOrdinal(index + 1);
                  return Text(
                    '$position: ${product.name} - ${product.quantitySold} sold',
                    style: const TextStyle(fontSize: 14),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
