import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otop_front/models/supplier_product.dart';

class ProductService {
  final String baseUrl;

  // Initialize with your backend's base URL
  ProductService(
      {this.baseUrl = 'http://127.0.0.1:8097/api/products/supplier'});

  // Fetch products by supplier ID
  Future<List<SupplierProduct>> getProductsBySupplier(int supplierId) async {
    final url = '$baseUrl/$supplierId'; // Construct the URL

    try {
      // Send the GET request to the backend
      final response = await http.get(Uri.parse(url));

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the JSON response into a list of Product objects
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => SupplierProduct.fromJson(json)).toList();
      } else {
        // Handle errors from the server
        throw Exception('Failed to load products');
      }
    } catch (error) {
      // Handle any errors that occur during the request
      throw Exception('Failed to load products: $error');
    }
  }
}
