import 'package:flutter/material.dart';
import 'package:otop_front/services/order_service.dart';

void main() {
  runApp(MyVerifiedTransaction());
}

class MyVerifiedTransaction extends StatelessWidget {
  const MyVerifiedTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final orderService = OrderService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Center(child: Text('Puchases')),
            ],
          ),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: _fetchOrders(orderService),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No transactions found.'));
            } else {
              return TransactionList(transactions: snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Future<List<Transaction>> _fetchOrders(OrderService orderService) async {
    final data = await orderService.fetchOrders();
    if (data != null) {
      // Filter out transactions where the status is not 'verified'
      return data
          .map<Transaction>((json) => Transaction.fromJson(json))
          .where((transaction) => transaction.status.toUpperCase() == 'VERIFIED')
          .toList();
    }
    return [];
  }
}

class Transaction {
  final String productName;
  final String orderDate;
  final String status;

  Transaction({
    required this.productName,
    required this.orderDate,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      productName: json['product_name'] ?? 'Unknown',
      orderDate: json['order_date'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];

        // Determine the text style and color based on status
        final statusStyle = TextStyle(
          color: transaction.status.toUpperCase() == 'VERIFIED'
              ? Colors.green
              : Colors.red,
          fontWeight: transaction.status.toUpperCase() == 'VERIFIED'
              ? FontWeight.bold
              : FontWeight.normal,
          fontSize: 16.0,
        );

        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(transaction.productName),
            subtitle: Text('Date: ${transaction.orderDate}'),
            trailing: Text(
              transaction.status,
              style: statusStyle,
            ),
          ),
        );
      },
    );
  }
}
