// models/receipt.dart
class Receipt {
  final List<Map<String, dynamic>> items;
  final double total;
  final double received;
  final double change;
  final DateTime timestamp;

  Receipt({
    required this.items,
    required this.total,
    required this.received,
    required this.change,
    required this.timestamp,
  });
}
