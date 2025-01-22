// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:otop_front/services/add_supplier_service.dart';
import 'package:otop_front/widget/order_cardDialog.dart';

class SupplierListWidget extends StatefulWidget {
  const SupplierListWidget({super.key});

  @override
  _SupplierListWidgetState createState() => _SupplierListWidgetState();
}

class _SupplierListWidgetState extends State<SupplierListWidget> {
  final AddSupplierService _supplierService = AddSupplierService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _showSupplierDetails(Map<String, dynamic> supplier) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Supplier Details',
            style: TextStyle(fontSize: 20),
          ),
          content: SizedBox(
            width: 300,
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Supplier Name: ${supplier['store_name'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Email: ${supplier['email'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Phone Number: ${supplier['phone_number'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Address: ${supplier['address'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showOrderDialog(Map<String, dynamic> supplier) {
    showDialog(
      context: context,
      builder: (context) {
        return OrderDialogWidget(supplier: supplier);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search Supplier Name',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            color: Colors.grey[300],
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Text(
                          'Supplier Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Supplier Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>?>(
              future: _supplierService.fetchAllSuppliers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error fetching suppliers: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No suppliers found.'));
                } else {
                  final suppliers = snapshot.data!
                      .where((supplier) => supplier['store_name']
                          .toString()
                          .toLowerCase()
                          .contains(_searchQuery))
                      .toList();
                  return ListView.separated(
                    itemCount: suppliers.length,
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 0.5,
                      height: 2.0,
                    ),
                    itemBuilder: (context, index) {
                      final supplier = suppliers[index];
                      final isHighlighted = index % 2 == 0;
                      return Container(
                        color: isHighlighted ? Colors.grey[200] : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  supplier['store_name'] ?? 'Unknown Supplier',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 47, 47, 49),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          _showSupplierDetails(supplier),
                                      child: const Text('See Details',
                                          style: TextStyle(fontSize: 12.0)),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          _showOrderDialog(supplier),
                                      child: const Text('See Products',
                                          style: TextStyle(fontSize: 12.0)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
