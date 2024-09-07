//3
import 'package:flutter/material.dart';
import 'package:flutter_project/bag_card.dart';
import 'package:flutter_project/app.dart';

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({super.key});

  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  List<BagItem> bagItems = [
    BagItem(
      productImage:
      'https://pnghq.com/wp-content/uploads/pnghq.com-black-t-shirt-png-without-5-768x754.png',
      productTitle: 'Pullover',
      color: 'Black',
      size: 'L',
      price: 51,
      quantity: 1,
    ),
    BagItem(
      productImage:
      'https://pnghq.com/wp-content/uploads/pnghq.com-black-t-shirt-png-without-5-768x754.png',
      productTitle: 'T-shirt',
      color: 'Gray',
      size: 'L',
      price: 30,
      quantity: 1,
    ),
    BagItem(
      productImage:
      'https://pnghq.com/wp-content/uploads/pnghq.com-black-t-shirt-png-without-5-768x754.png',
      productTitle: 'Sport Dress',
      color: 'Black',
      size: 'M',
      price: 45,
      quantity: 1,
    ),
  ];

  int calculateTotal() {
    return bagItems.fold(
        0, (sum, item) => sum + item.price.toInt() * item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: myBagAppBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: bagItems.length,
                itemBuilder: (context, index) {
                  return BagCard(
                    item: bagItems[index],
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        bagItems[index].quantity = newQuantity;
                      });
                    },
                  );
                },
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total amount:',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(
                      '${calculateTotal()}\$',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.grey.shade200,
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: const Text('CHECK OUT'),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
