import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:otop_front/chart_widget/chart_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuppliersSalesChart extends StatefulWidget {
  final String supplierId;

  const SuppliersSalesChart({super.key, required this.supplierId});

  @override
  State<SuppliersSalesChart> createState() => _SuppliersSalesChartState();
}

class _SuppliersSalesChartState extends State<SuppliersSalesChart> {
  String selectedPeriod = 'Daily'; // Default selection
  final List<String> periods = ['Daily', 'Weekly', 'Monthly', 'Yearly']; // Added 'Monthly'
  List<double> chartData = []; // To store the chart data
  String supplierId = ''; // Assuming supplierId is assigned after login

  @override
  void initState() {
    super.initState();
    fetchSalesData(); // Fetch the data when the widget is initialized
    loadSupplierId();
  }

  Future<void> loadSupplierId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    supplierId = prefs.getString('supplierId') ?? '';

    if (supplierId.isEmpty) {
      print('Supplier ID not found in SharedPreferences');
    } else {
      print('Supplier ID loaded: $supplierId');
      fetchSalesData(); // Now fetch sales data AFTER supplierId is loaded
    }
  }

  // Function to fetch sales data based on selected period
  Future<void> fetchSalesData() async {
    if (supplierId.isEmpty) {
      // Handle error if no supplierId is found
      print('Supplier ID is missing');
      return;
    }

    String interval = 'daily';
    if (selectedPeriod == 'Weekly') {
      interval = 'weekly';
    } else if (selectedPeriod == 'Monthly') { // Handle monthly interval
      interval = 'monthly';
    } else if (selectedPeriod == 'Yearly') {
      interval = 'yearly';
    }

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8097/api/otop/getSummary'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'supplierId': supplierId, // Include supplierId in the request
          'interval': interval,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // Process the response based on the selected period
        updateChartData(responseData);
      } else {
        throw Exception('Failed to load sales data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  // Function to update chart data based on the response
  void updateChartData(Map<String, dynamic> data) {
    setState(() {
      if (selectedPeriod == 'Daily') {
        chartData = [
          (data['Monday'] as num?)?.toDouble() ?? 0.0,
          (data['Tuesday'] as num?)?.toDouble() ?? 0.0,
          (data['Wednesday'] as num?)?.toDouble() ?? 0.0,
          (data['Thursday'] as num?)?.toDouble() ?? 0.0,
          (data['Friday'] as num?)?.toDouble() ?? 0.0,
          (data['Saturday'] as num?)?.toDouble() ?? 0.0,
        ];
      } else if (selectedPeriod == 'Weekly') {
        chartData = [
          (data['Week 1'] as num?)?.toDouble() ?? 0.0,
          (data['Week 2'] as num?)?.toDouble() ?? 0.0,
          (data['Week 3'] as num?)?.toDouble() ?? 0.0,
          (data['Week 4'] as num?)?.toDouble() ?? 0.0,
          (data['Week 5'] as num?)?.toDouble() ?? 0.0,
        ];
      } else if (selectedPeriod == 'Monthly') { // Handle monthly data
        chartData = [
          (data['January'] as num?)?.toDouble() ?? 0.0,
          (data['February'] as num?)?.toDouble() ?? 0.0,
          (data['March'] as num?)?.toDouble() ?? 0.0,
          (data['April'] as num?)?.toDouble() ?? 0.0,
          (data['May'] as num?)?.toDouble() ?? 0.0,
          (data['June'] as num?)?.toDouble() ?? 0.0,
          (data['July'] as num?)?.toDouble() ?? 0.0,
          (data['August'] as num?)?.toDouble() ?? 0.0,
          (data['September'] as num?)?.toDouble() ?? 0.0,
          (data['October'] as num?)?.toDouble() ?? 0.0,
          (data['November'] as num?)?.toDouble() ?? 0.0,
          (data['December'] as num?)?.toDouble() ?? 0.0,
        ];
      } else if (selectedPeriod == 'Yearly') {
        // Assuming 'data' contains year-wise sales data like { '2023': 1000, '2024': 1200, ... }
        chartData = (data.values.map((value) => (value as num).toDouble()).toList());
      }
    });
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
                  DropdownButton<String>(
                    value: selectedPeriod,
                    items: periods.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPeriod = newValue!;
                        fetchSalesData(); // Fetch new data when selection changes
                      });
                    },
                    underline: const SizedBox(),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 320,
                color: Colors.grey[200],
                child: chartData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  children: [
                    // Scrollable horizontal labels
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: selectedPeriod == 'Daily'
                                ? ['']
                                .map((label) => Container(
                              width: 60,
                              child: Center(
                                child: Text(
                                  label,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                                .toList()
                                : selectedPeriod == 'Weekly'
                            ? []
                                .map((label) => Container(
                            width: 60,
                            child: Center(
                            child: Text(
                            label,
                            style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                            ),
                            ),
                            ))
                                .toList()
                                : selectedPeriod == 'Monthly'
                            ? []
                                .map((label) => Container(
                            width: 60,
                            child: Center(
                            child: Text(
                            label,
                            style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                            ),
                            ),
                            ))
                                .toList()
                                : []
                                .map((label) => Container(
                              width: 60,
                              child: Center(
                                child: Text(
                                  label,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                                .toList(),
                            ),
                            ),
                            const SizedBox(height: 10),
                            BarGraph(
                              data: chartData,
                              labels: selectedPeriod == 'Daily'
                                  ? ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                                  : selectedPeriod == 'Weekly'
                                  ? ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5']
                                  : selectedPeriod == 'Monthly'
                                  ? ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                                  : ['2021', '2022', '2023', '2024', '2025'], // Example yearly labels
                            ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
