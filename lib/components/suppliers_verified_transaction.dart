import 'package:flutter/material.dart';
import 'package:otop_front/services/confirmation_orders.dart'; // Import ConfirmationOrders

void main() {
  runApp(SuppliersVerifiedTransaction());
}

class SuppliersVerifiedTransaction extends StatelessWidget {
  const SuppliersVerifiedTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Center(child: Text('Purchases')),
            ],
          ),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: _fetchOrders(), // Fetch orders using getSupplierOrders
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

  Future<List<Transaction>> _fetchOrders() async {
    final confirmationOrders = ConfirmationOrders();
    try {
      final data =
          await confirmationOrders.getSupplierOrders(); // Fetch the orders

      if (data.isEmpty) {
        return [];
      }

      // Map the data to a list of Transaction objects
      return data
          .map<Transaction>((json) => Transaction.fromJson(json))
          .where(
              (transaction) => transaction.status.toUpperCase() == 'VERIFIED')
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch verified orders: $e');
    }
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
