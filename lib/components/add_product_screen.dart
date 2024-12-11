// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../models/product.dart'; // Your Product model
// import '../providers/product_provider.dart'; // Your Product provider
// import '../services/product_services.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final List<GlobalKey<ProductFormCardState>> _productFormKeys = [];

//   double _calculateTotalPrice() {
//     double total = 0.0;
//     for (var key in _productFormKeys) {
//       final formState = key.currentState;
//       if (formState != null) {
//         total += formState.totalPrice;
//       }
//     }
//     return total;
//   }

//   int _calculateTotalStock() {
//     int totalStock = 0;
//     for (var key in _productFormKeys) {
//       final formState = key.currentState;
//       if (formState != null) {
//         totalStock += formState.stock; // Use the stock getter to get the current stock value
//       }
//     }
//     return totalStock;
//   }

//   void _addProductForm() {
//     final key = GlobalKey<ProductFormCardState>();
//     setState(() {
//       _productFormKeys.add(key);
//     });
//   }

//   void _deleteProductForm(int index) {
//     setState(() {
//       if (_productFormKeys.isNotEmpty) {
//         _productFormKeys.removeAt(index);
//       }
//     });
//   }

//   Future<void> _saveAllProducts() async {
//     final productService = ProductServices();
//     List<Map<String, dynamic>> productDataList = [];

//     for (var key in _productFormKeys) {
//       final formState = key.currentState;
//       if (formState != null) {
//         final productData = {
//           "name": formState.name,
//           "description": formState.description,
//           "category": formState.category,
//           "stock": formState.stock,
//           "price": formState.price,
//           "image": formState.imagePath,
//         };
//         productDataList.add(productData);
//       }
//     }
//     try {
//       await productServices.saveAllProducts(productDataList);
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("All products saved successfully!")),
//       );
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error saving products: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Add Product', style: TextStyle(fontSize: 18))),
//       ),
//       body: SingleChildScrollView(
//         child: Wrap(
//           spacing: 12, // Spacing between cards
//           runSpacing: 12, // Spacing between rows of cards
//           children: [
//             ..._productFormKeys.map((key) {
//               return ProductFormCard(
//                 key: key,
//                 onAddProduct: _addProductForm,
//                 onDelete: () {
//                   _deleteProductForm(_productFormKeys.indexOf(key));
//                 },
//               );
//             }),
//             Center(
//               child: IconButton(
//                 icon: Icon(Icons.add, color: const Color.fromARGB(182, 123, 118, 118)),
//                 iconSize: 50,
//                 onPressed: _addProductForm,
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//   child: ConstrainedBox(
//     constraints: BoxConstraints(maxWidth: 400), // Set max width to 400
//     child: Padding(
//       padding: const EdgeInsets.all(8.0), // Adjust padding as needed
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Flexible(
//             child: Text(
//               "Total Products: ${_productFormKeys.length}",
//               style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Flexible(
//             child: Text(
//               "Total Stock: ${_calculateTotalStock()}",
//               style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Flexible(
//             child: Text(
//               "Total Price: Php${_calculateTotalPrice().toStringAsFixed(2)}",
//               style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _saveAllProducts,
//             child: Text("Save Product", style: TextStyle(fontSize: 10)),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),

//     );
//   }
// }

// class ProductFormCard extends StatefulWidget {
//   final VoidCallback onAddProduct;
//   final VoidCallback onDelete;

//   const ProductFormCard({
//     super.key,
//     required this.onAddProduct,
//     required this.onDelete,
//   });

//   @override
//   ProductFormCardState createState() => ProductFormCardState();
// }

// class ProductFormCardState extends State<ProductFormCard> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _categoryController = TextEditingController();
//   final TextEditingController _stockController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();

//   XFile? _pickedImage;

//   // Getter for total price
//   double get totalPrice {
//     double price = double.tryParse(_priceController.text) ?? 0.0;
//     int stock = int.tryParse(_stockController.text) ?? 0;
//     return price * stock;
//   }

//   // Getters for the product fields
//   String get name => _nameController.text;
//   String get description => _descriptionController.text;
//   String get category => _categoryController.text;
//   int get stock => int.tryParse(_stockController.text) ?? 0;
//   double get price => double.tryParse(_priceController.text) ?? 0.0;
//   String? get imagePath => _pickedImage?.path;

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _pickedImage = image;
//     });
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate() && _pickedImage != null) {
//       final product = Product(
//         name: _nameController.text,
//         description: _descriptionController.text,
//         category: _categoryController.text,
//         stock: int.parse(_stockController.text),
//         price: double.parse(_priceController.text),
//         imagePath: _pickedImage!.path,
//       );

//       Provider.of<ProductProvider>(context, listen: false).addProduct(product);
//       widget.onAddProduct();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         int columns;

//         if (constraints.maxWidth <= 500) {
//           columns = 1; // 1 column
//         } else if (constraints.maxWidth <= 1000) {
//           columns = 2; // 2 columns
//         } else {
//           columns = 3; // 3 columns
//         }

//         return SizedBox(
//           width: constraints.maxWidth / columns - 12, // Adjust width based on columns
//           child: Card(
//             elevation: 3,
//             margin: EdgeInsets.all(12),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     GestureDetector(
//                       onTap: _pickImage,
//                       child: Container(
//                         height: 150,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: const Color.fromARGB(255, 142, 83, 83)),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: _pickedImage != null
//                             ? Image.file(File(_pickedImage!.path), fit: BoxFit.cover)
//                             : Center(child: Text("Upload Product Image")),
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: InputDecoration(labelText: "Product Name", labelStyle: TextStyle(fontSize: 13)),
//                       validator: (value) => value == null || value.isEmpty ? "Enter product name" : null,
//                     ),
//                     TextFormField(
//                       controller: _descriptionController,
//                       decoration: InputDecoration(labelText: "Description", labelStyle: TextStyle(fontSize: 13)),
//                       validator: (value) => value == null || value.isEmpty ? "Enter product description" : null,
//                     ),
//                     TextFormField(
//                       controller: _categoryController,
//                       decoration: InputDecoration(labelText: "Category", labelStyle: TextStyle(fontSize: 13)),
//                       validator: (value) => value == null || value.isEmpty ? "Enter category" : null,
//                     ),
//                     TextFormField(
//                       controller: _stockController,
//                       decoration: InputDecoration(labelText: "Stock", labelStyle: TextStyle(fontSize: 13)),
//                       keyboardType: TextInputType.number,
//                       validator: (value) => value == null || value.isEmpty ? "Enter stock" : null,
//                     ),
//                     TextFormField(
//                       controller: _priceController,
//                       decoration: InputDecoration(labelText: "Price", labelStyle: TextStyle(fontSize: 13)),
//                       keyboardType: TextInputType.number,
//                       validator: (value) => value == null || value.isEmpty ? "Enter price" : null,
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(
//                           onPressed: _submitForm,
//                           child: Text("Add Product", style: TextStyle(fontSize: 10)),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red),
//                           onPressed: widget.onDelete,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
