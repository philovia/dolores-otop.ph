// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:otop_front/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // This function redirects user based on the role.
  void _redirectUser(String role) {
    String routeName;
    switch (role) {
      case 'admin':
        routeName = '/admin';
        break;
      case 'cashier':
        routeName = '/cashier';
        break;
      case 'supplier':
      default:
        routeName = '/supplier';
        break;
    }
    Navigator.pushReplacementNamed(context, routeName);
  }

//   Future<void> saveSupplierId(int supplierId) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setInt('supplierId', supplierId);  // Save the supplierId in shared preferences
// }

  // This function handles the login process.
  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      // Call the login method from AuthService.
      var data = await _authService.login(email, password);
      await _saveToken(data['token']); // Save the token after login.
      if (!mounted) return;
      _redirectUser(data['role']); // Redirect based on the role.
    } catch (e) {
      _showError(e.toString());
    }
  }

  // Save the token to shared preferences.
  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Load the token from shared preferences (if exists).
  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      // You can use this to decode or verify the token if needed.
    }
  }

  // Show error messages to the user.
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('DOLORES OTOP.PH')),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(194, 255, 255, 255),
            border: Border.all(color: Colors.indigo),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 400,
          height: 350,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "images/otopph.png",
                    height: 100,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Login',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                _buildTextField(_emailController, 'Email'),
                const SizedBox(height: 10),
                _buildTextField(_passwordController, 'Password',
                    obscureText: true),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
