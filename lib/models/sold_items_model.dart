class SoldItems {
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  int? iD;
  int? productID;
  Product? product;
  int? quantitySold;
  double? totalAmount;
  String? soldDate;
  int? supplierID;

  SoldItems(
      {this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.iD,
      this.productID,
      this.product,
      this.quantitySold,
      this.totalAmount,
      this.soldDate,
      this.supplierID});

  SoldItems.fromJson(Map<String, dynamic> json) {
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    iD = json['ID'];
    productID = json['ProductID'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantitySold = json['quantity_sold'];
    totalAmount = json['total_amount'];
    soldDate = json['sold_date'];
    supplierID = json['SupplierID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    data['DeletedAt'] = this.deletedAt;
    data['ID'] = this.iD;
    data['ProductID'] = this.productID;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity_sold'] = this.quantitySold;
    data['total_amount'] = this.totalAmount;
    data['sold_date'] = this.soldDate;
    data['SupplierID'] = this.supplierID;
    return data;
  }
}

class Product {
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  int? iD;
  String? name;
  String? description;
  int? price;
  int? quantity;
  String? category;
  int? supplierID;
  Supplier? supplier;
  String? storeName;
  String? sequentialNumber;

  Product(
      {this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.iD,
      this.name,
      this.description,
      this.price,
      this.quantity,
      this.category,
      this.supplierID,
      this.supplier,
      this.storeName,
      this.sequentialNumber});

  Product.fromJson(Map<String, dynamic> json) {
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    iD = json['ID'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    category = json['category'];
    supplierID = json['SupplierID'];
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
    storeName = json['store_name'];
    sequentialNumber = json['sequential_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['ID'] = iD;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['category'] = this.category;
    data['SupplierID'] = this.supplierID;
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    data['store_name'] = this.storeName;
    data['sequential_number'] = this.sequentialNumber;
    return data;
  }
}

class Supplier {
  int? iD;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  int? id;
  String? storeName;
  String? email;
  String? phoneNumber;
  String? address;
  String? password;
  String? role;
  Null products;
  int? purchased;
  Null otopProducts;

  Supplier(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.id,
      this.storeName,
      this.email,
      this.phoneNumber,
      this.address,
      this.password,
      this.role,
      this.products,
      this.purchased,
      this.otopProducts});

  Supplier.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    id = json['id'];
    storeName = json['store_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    password = json['password'];
    role = json['Role'];
    products = json['Products'];
    purchased = json['Purchased'];
    otopProducts = json['OtopProducts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    data['DeletedAt'] = this.deletedAt;
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['password'] = this.password;
    data['Role'] = this.role;
    data['Products'] = this.products;
    data['Purchased'] = this.purchased;
    data['OtopProducts'] = this.otopProducts;
    return data;
  }
}

// class SoldItems {
//   final int id;
//   final int productId;
//   final int quantitySold;
//   final double totalAmount;
//   final DateTime soldDate;
//   final int supplierId;

//   SoldItems({
//     required this.id,
//     required this.productId,
//     required this.quantitySold,
//     required this.totalAmount,
//     required this.soldDate,
//     required this.supplierId,
//   });

//   factory SoldItems.fromJson(Map<String, dynamic> json) {
//     return SoldItems(
//       id: json['id'] ?? 0,
//       productId: json['productId'] ?? 0,
//       quantitySold: json['quantity_sold'] ?? 0,
//       totalAmount: (json['total_amount'] ?? 0).toDouble(),
//       soldDate: DateTime.parse(json['sold_date'] ?? DateTime.now().toIso8601String()),
//       supplierId: json['supplierId'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'productId': productId,
//       'quantity_sold': quantitySold,
//       'total_amount': totalAmount,
//       'sold_date': soldDate.toIso8601String(),
//       'supplierId': supplierId,
//     };
//   }

//   static SoldItems setDefaultSoldDate(SoldItems soldItem) {
//     if (soldItem.soldDate == DateTime.fromMillisecondsSinceEpoch(0)) {
//       return SoldItems(
//         id: soldItem.id,
//         productId: soldItem.productId,
//         quantitySold: soldItem.quantitySold,
//         totalAmount: soldItem.totalAmount,
//         soldDate: DateTime.now(),
//         supplierId: soldItem.supplierId,
//       );
//     }
//     return soldItem;
//   }
// }
