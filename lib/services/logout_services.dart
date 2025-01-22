import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert'; // For converting the response to JSON
import 'package:flutter/material.dart'; // Import Flutter Material for navigation

class AuthService {
  // Function to logout the user
  Future<void> logout(BuildContext context, String token) async {
    final response = await http.post(
      Uri.parse(
          'https://cyan-dust-star.glitch.me/api/logout'), // Replace with your API URL
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Here you can check if the context is still mounted
      // Handle any additional logic you might need here
    } else {
      throw Exception(json.decode(response.body)['error'] ?? 'Logout failed');
    }
  }
}
