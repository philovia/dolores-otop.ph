// ignore_for_file: implementation_imports

import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl =
      'https://cyan-dust-star.glitch.me/api'; // Update this with your backend URL

  // Unified login function for admin, cashier, and supplier
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      await _saveToken(responseData['token']);

      // If the user is a supplier, save the supplier ID
      if (responseData['role'] == 'supplier') {
        await _saveSupplierId(responseData['supplier_id']);
      }

      return {
        'token': responseData['token'],
        'role': responseData['role'],
      };
    } else {
      final errorData = json.decode(response.body);
      return Future.error(errorData['error']);
    }
  }

  // Function to save the token in shared preferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('auth_token', token);
  }

  // Function to save the supplier ID in shared preferences
  Future<void> _saveSupplierId(int supplierId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('supplier_id', supplierId);
  }

  // Function to retrieve the stored token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Function to retrieve the stored supplier ID
  Future<int?> getSupplierId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('supplier_id');
  }

  // Function to handle logout
  Future<void> logout(BuildContext context, String token) async {
    final token = await getToken();
    if (token != null) {
      final url = Uri.parse('$baseUrl/logout');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await _clearToken();
        print('Logout successful');
      } else {
        final errorData = json.decode(response.body);
        throw errorData['error'];
      }
    } else {
      throw 'No token found for logout';
    }
  }

  // Function to clear the token from shared preferences
  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('auth_token');
  }
}




// import 'dart:convert';
// // ignore: implementation_imports
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   static const String baseUrl =
//       'http://127.0.0.1:8097/api'; // Update this with your backend URL

//   // Unified login function for admin, cashier, and supplier
//   Future<Map<String, dynamic>> login(String email, String password) async {
//     final url = Uri.parse('$baseUrl/login');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'email': email,
//         'password': password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       await _saveToken(responseData['token']);
//       return {
//         'token': responseData['token'],
//         'role': responseData['role'],
//       };
//     } else {
//       final errorData = json.decode(response.body);
//       return Future.error(errorData['error']);
//     }
//   }

//   // Function to save the token in shared preferences
//   Future<void> _saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('auth_token', token);
//   }

//   // Function to retrieve the stored token
//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('auth_token');
//   }

//   // Function to handle logout
//   Future<void> logout(BuildContext context, String token) async {
//     final token = await getToken();
//     if (token != null) {
//       final url = Uri.parse('$baseUrl/logout');
//       final response = await http.post(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         await _clearToken();
//         ('Logout successful');
//       } else {
//         final errorData = json.decode(response.body);
//         throw errorData['error'];
//       }
//     } else {
//       throw 'No token found for logout';
//     }
//   }

//   // Function to clear the token from shared preferences
//   Future<void> _clearToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove('auth_token');
//   }
// } 
