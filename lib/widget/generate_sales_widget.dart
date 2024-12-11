// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class SalesInventoryPage extends StatefulWidget {
  const SalesInventoryPage({super.key});

  @override
  _SalesInventoryPageState createState() => _SalesInventoryPageState();
}

class _SalesInventoryPageState extends State<SalesInventoryPage> {
  DateTime selectedDate = DateTime.now(); // Default to the current date

  final List<Map<String, dynamic>> tableData = [
    {
      'no': 1,
      'companyName': 'ACP MAZAPAN SWEETS BAKERY',
      'soldItem': 25,
      'totalGross': 1362.00,
      'payment': 1114.00,
      'netIncome': 248.00,
      'date': DateTime(2023, 7, 1), // Sample date
    },
    {
      'no': 2,
      'companyName': 'EM-AR HANDICRAFTS TRADING',
      'soldItem': 1,
      'totalGross': 100.00,
      'payment': 70.00,
      'netIncome': 30.00,
      'date': DateTime(2023, 7, 15), // Sample date
    },
    {
      'no': 3,
      'companyName': 'Jai-jais Banana Chips',
      'soldItem': 6,
      'totalGross': 315.00,
      'payment': 225.00,
      'netIncome': 90.00,
      'date': DateTime(2023, 8, 10), // Sample date
    },
  ];

  // Filtered data
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    // Initialize filtered data
    _filterDataBySelectedMonth();
  }

  void _filterDataBySelectedMonth() {
    setState(() {
      filteredData = tableData.where((row) {
        DateTime rowDate = row['date'];
        return rowDate.year == selectedDate.year &&
            rowDate.month == selectedDate.month;
      }).toList();
    });
  }

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020), // Earliest selectable date
      lastDate: DateTime(2100), // Latest selectable date
      helpText: "Select Month and Year", // Help text in the picker
      fieldLabelText: "Enter month and year", // Placeholder in the picker
      initialDatePickerMode: DatePickerMode.year, // Show year picker first
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal, // Header background color
            colorScheme: const ColorScheme.light(primary: Colors.teal),
            buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month); // Set month & year
        _filterDataBySelectedMonth();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Inventory'),
        backgroundColor: const Color.fromARGB(255, 255, 200, 123),
      ),
      body: Column(
        children: [
          // Date Picker Button
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Month: ${DateFormat.yMMMM().format(selectedDate)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () => _selectMonth(context),
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Pick Month'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 200, 123),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // Data Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: double.infinity, // Ensures the table takes full width
                child: DataTable(
                  columnSpacing: 15, // Adjust column spacing as needed
                  columns: const [
                    DataColumn(label: Text('No.')),
                    DataColumn(label: Text('Company Name')),
                    DataColumn(label: Text('Sold Item')),
                    DataColumn(label: Text('Total Gross for Retail')),
                    DataColumn(label: Text('Payment for Suppliers')),
                    DataColumn(label: Text('Net Income')),
                  ],
                  rows: filteredData.map((row) {
                    return DataRow(cells: [
                      DataCell(Text(row['no'].toString())),
                      DataCell(Text(row['companyName'])),
                      DataCell(Text(row['soldItem'].toString())),
                      DataCell(Text('₱ ${row['totalGross'].toStringAsFixed(2)}')),
                      DataCell(Text('₱ ${row['payment'].toStringAsFixed(2)}')),
                      DataCell(Text('₱ ${row['netIncome'].toStringAsFixed(2)}')),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
