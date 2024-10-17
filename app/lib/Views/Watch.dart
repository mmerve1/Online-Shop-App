import 'package:app/Components/colors.dart';
import 'package:app/SQLlite/database_helper.dart';
import 'package:app/Views/Cart.dart';
import 'package:app/Views/Order.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class Watch extends StatefulWidget {
  const Watch({super.key});

  @override
  State<Watch> createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<String> productName = [
    "TJM Watch5",
    "PFM-5 Watch8",
    "SYF-9 Watch7",
    "TJM Watch5",
    "PFM-5 Watch8",
    "SYF-9 Watch7"
  ];
  List<String> productImage = [
    "lib/assets/images/watch3.jpg",
    "lib/assets/images/watch4.jpg",
    "lib/assets/images/watch5.jpg",
    "lib/assets/images/watch3.jpg",
    "lib/assets/images/watch4.jpg",
    "lib/assets/images/watch5.jpg",
  ];
  List<String> productPrice = ["100", "200", "300", "100", "200", "300"];

  Future<void> _addProductToCart(int index) async {
    // Create a Cart object
    Cart newCartItem = Cart(
      id: null,
      productId: index.toString(), // Use index as productId for simplicity
      productName: productName[index],
      productPrice: productPrice[index],
      initialPrice: productPrice[index],
      quantity: 1, // Default quantity to 1
      unitTag: "Unit",
      image: productImage[index],
    );

    // Add the item to the database
    await _dbHelper.addToCart(newCartItem);

    // Navigate to the Order page after adding the item
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Order()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Text('3', style: TextStyle(color: Colors.white)),
              child: Icon(Icons.shopping_bag),
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          productImage[index],
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName[index],
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                  height:
                                      5), // Fiyat ile ad arasında biraz boşluk
                              Text(
                                "\$${productPrice[index]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => _addProductToCart(
                              index), // Add the product on tap
                          child: Container(
                            width: 70,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
