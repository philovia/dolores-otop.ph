import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('auth_token');

  if (token != null) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    int userId = decodedToken['userId']; // Assuming the userId is in the token
    return userId;
  } else {
    return null;
  }
}
