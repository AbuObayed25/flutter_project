// //1
// import 'package:flutter/material.dart';
//
// // AppBar for the My Bag screen
// var myBagAppBar = AppBar(
//   backgroundColor: Colors.grey.shade300,
//   title: const Text(
//     'My Bag',
//     style: TextStyle(
//       fontSize: 32,
//       fontWeight: FontWeight.w500,
//     ),
//   ),
// );
//
// // Model class for a bag item
// class BagItem {
//   final String productImage;
//   final String productTitle;
//   final String color;
//   final String size;
//   final double price;
//   int quantity;
//
//   BagItem({
//     required this.productImage,
//     required this.productTitle,
//     required this.color,
//     required this.size,
//     required this.price,
//     this.quantity = 1,
//   });
// }
import 'package:flutter/material.dart';

// AppBar for the My Bag screen
var myBagAppBar = AppBar(
  backgroundColor: Colors.grey.shade300,
  title: const Text(
    'My Bag',
    style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
    ),
  ),
);

// Model class for a bag item
class BagItem {
  final String productImage;
  final String productTitle;
  final String color;
  final String size;
  final double price;
  int quantity;

  BagItem({
    required this.productImage,
    required this.productTitle,
    required this.color,
    required this.size,
    required this.price,
    this.quantity = 1,
  });
}

// Main function that starts the Flutter app
void main() {
  runApp(const MyApp());
}

// Main widget that returns the app structure
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: myBagAppBar,
        body: const Center(
          child: Text("Welcome to My Bag!"),
        ),
      ),
    );
  }
}

