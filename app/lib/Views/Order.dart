import 'package:flutter/material.dart';
import '../SQLlite/database_helper.dart';
import '../Views/Cart.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _CartPageState();
}

class _CartPageState extends State<Order> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Cart> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    cartItems = await _dbHelper.getCartItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
        0,
        (sum, item) =>
            sum + (double.parse(item.productPrice!) * item.quantity!));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 21, 19, 143),
        title: Center(
          child: const Text(
            "Cart",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(255, 238, 238, 243)),
          ),
        ),
        actions: [
          IconButton(
            icon: Container(
              margin: EdgeInsets.only(right: 25),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              setState(() {
                for (var item in cartItems) {
                  _dbHelper.removeFromCart(item.id!);
                }
                cartItems.clear();
              });
            },
          )
        ],
      ),
      body: cartItems.isNotEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(
                          cartItems[index].image!,
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
                        ),
                        title: Text(
                          cartItems[index].productName!,
                          style: TextStyle(fontSize: 17),
                        ),
                        subtitle: Text(
                            'Quantity: ${cartItems[index].quantity} x ${cartItems[index].productPrice} \$'),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              if (cartItems[index].quantity! > 1) {
                                cartItems[index].quantity =
                                    cartItems[index].quantity! - 1;
                                _dbHelper.updateCart(cartItems[index]);
                              } else {
                                _dbHelper.removeFromCart(cartItems[index].id!);
                                cartItems.removeAt(index);
                              }
                            });
                          },
                        ),
                        isThreeLine: true,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1, color: Colors.grey);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: \$${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Order Placed Successfully!"),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        },
                        child: const Text(
                          "Place Order",
                          style: TextStyle(
                              color: Color.fromARGB(255, 31, 51, 186)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: Text("Your cart is empty"),
            ),
    );
  }
}
