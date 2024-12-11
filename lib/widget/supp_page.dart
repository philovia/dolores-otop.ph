// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:otop_front/services/service.dart';

import '../services/add_supplier_service.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({Key? key, required Map<String, dynamic> supplier})
      : super(key: key);

  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  List<Map<String, dynamic>> suppliers = [];

  @override
  void initState() {
    super.initState();
    _fetchSuppliers();
  }

  Future<void> _fetchSuppliers() async {
    final AddSupplierService service = AddSupplierService();
    final fetchedSuppliers = await service.fetchAllSuppliers();
    if (fetchedSuppliers != null) {
      setState(() {
        suppliers = fetchedSuppliers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier Page'),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: suppliers.length,
          itemBuilder: (context, index) {
            final supplier = suppliers[index];
            return ListTile(
              title: Text(supplier['store_name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SupplierDetailsPage(supplier: supplier),
                  ),
                );
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text('Select a supplier from the drawer'),
      ),
    );
  }
}

class SupplierDetailsPage extends StatelessWidget {
  final Map<String, dynamic> supplier;

  const SupplierDetailsPage({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${supplier['store_name'] ?? 'Supplier Details'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Store Name: ${supplier['store_name'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Text('Email: ${supplier['email'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16)),
            SizedBox(height: 8.0),
            Text('Phone Number: ${supplier['phone_number'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16)),
            SizedBox(height: 8.0),
            Text('Address: ${supplier['address'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
