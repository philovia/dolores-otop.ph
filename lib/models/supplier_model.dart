// supplier_model.dart

class Supplier {
  final int id;
  final String storeName;
  final String email;
  final String phoneNumber;
  final String address;
  final String password;
  final String role;

  Supplier({
    required this.id,
    required this.storeName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    String? role,
  }) : role = role ?? 'supplier';

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'] ?? 0,
      storeName: json['storeName'] ?? 'Unknown Store',
      email: json['email'],
      phoneNumber: json['contact'],
      address: json['address'],
      password: json['password'],
      role: json['role'] ?? 'supplier',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storeName': storeName,
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'password': password,
      'role': role,
    };
  }
}
