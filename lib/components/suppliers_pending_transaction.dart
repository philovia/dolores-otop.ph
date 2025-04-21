import 'package:flutter/material.dart';
import 'package:otop_front/services/confirmation_orders.dart'; // Import ConfirmationOrders

void main() {
  runApp(const SuppliersPendingTransaction());
}

class SuppliersPendingTransaction extends StatelessWidget {
  const SuppliersPendingTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text('Purchases')),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: _fetchOrders(), // Fetch orders using getSupplierOrders
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No transactions found.'));
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
          .where((transaction) =>
              transaction.status.toUpperCase() ==
              'PENDING') // Filter by "PENDING" status
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch pending orders: $e');
    }
  }
}

class Transaction {
  final int Id;  // Change orderId to int
  final String productName;
  final String orderDate;
  final String status;

  Transaction({
    required this.Id,  // Ensure orderId is an int
    required this.productName,
    required this.orderDate,
    required this.status,
  });

  // Updated fromJson to safely handle orderId
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      Id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,  // Safely parse to int
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
        final confirmationOrders = ConfirmationOrders();

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(transaction.productName),
            subtitle: Text('Date: ${transaction.orderDate}'),
            trailing: transaction.status.toUpperCase() == 'PENDING'
                ? ElevatedButton(
                    onPressed: () async {
  try {
    // Show a loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Processing order...'),
        duration: Duration(seconds: 2),
      ),
    );

    // Call the confirmOrder method with the orderId
    final response = await confirmationOrders.confirmOrder(transaction.Id);

    // Use the response (e.g., display success details)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Order ${transaction.Id} confirmed successfully: ${response['message']}',
        ),
      ),
    );

    // Add further logic, like refreshing the list or updating UI
  } catch (error) {
    // Handle errors and show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
      ),
    );
  }
},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Orange button
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                    ),
                    child: const Text(
                      'PENDING',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    transaction.status,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

