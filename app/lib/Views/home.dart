import 'package:app/Views/Headphone.dart';
import 'package:app/Views/Laptop.dart';
import 'package:app/Views/Order.dart';
import 'package:app/Views/TV.dart';
import 'package:app/Views/Watch.dart';
import 'package:app/Views/login.dart';
import 'package:app/Views/profile.dart';
import 'package:flutter/material.dart';
import 'package:app/Components/button.dart';
import 'package:app/JSON/users.dart';
import 'package:app/Views/auth.dart';
import 'package:app/Views/bottomnav.dart';
import 'package:app/Views/product_detail.dart'; // Import the ProductDetail class

class Home extends StatefulWidget {
  final Users? name;
  const Home({super.key, this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "lib/assets/images/headphone_icon.png",
    "lib/assets/images/laptop.png",
    "lib/assets/images/watch.png",
    "lib/assets/images/TV.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Daha açık bir arka plan rengi
      body: Container(
        margin: const EdgeInsets.only(top: 70, left: 20, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey there!",
                      style: const TextStyle(
                          color: Color(0xFF333333), // Daha koyu bir siyah
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Good Morning",
                      style: const TextStyle(
                          color: Color(0xFF555555), // Orta koyulukta gri
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "lib/assets/images/human2.png",
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Search Products",
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  ),
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                      color: Color(0xFF333333), // Siyah tonunda
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "See All",
                  style: TextStyle(
                      color: Color(0xFF007BFF), // Daha açık mavi ton
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            255, 66, 66, 183), // Yeni bir mavi ton
                        borderRadius: BorderRadius.circular(20)),
                    height: 120,
                    width: 90,
                    child: const Center(
                      child: Text(
                        "All",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.zero,
                    height: 120,
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (categories[index] ==
                            'lib/assets/images/headphone_icon.png') {
                          return CategoryTile(
                            image: categories[index],
                            destination: Headphone(),
                          );
                        } else if (categories[index] ==
                            'lib/assets/images/laptop.png') {
                          return CategoryTile(
                            image: categories[index],
                            destination: Laptop(),
                          );
                        } else if (categories[index] ==
                            'lib/assets/images/watch.png') {
                          return CategoryTile(
                            image: categories[index],
                            destination: Watch(),
                          );
                        } else {
                          return CategoryTile(
                            image: 'lib/assets/images/TV.png',
                            destination: Tv(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "All Products",
                  style: TextStyle(
                      color: Color(0xFF333333), // Siyah ton
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                      color: Color(0xFF007BFF), // Açık mavi vurgulu
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 190,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  _buildProduct(
                    context,
                    imagePath: "lib/assets/images/headphone2.2.png",
                    productName: "Headphone",
                    productPrice: "\$100",
                    productDescription:
                        "A high-quality headphone for immersive sound experience.",
                  ),
                  _buildProduct(
                    context,
                    imagePath: "lib/assets/images/watch2.png",
                    productName: "Watch",
                    productPrice: "\$50",
                    productDescription:
                        "A stylish watch with advanced features.",
                  ),
                  _buildProduct(
                    context,
                    imagePath: "lib/assets/images/laptop2.png",
                    productName: "Laptop",
                    productPrice: "\$100",
                    productDescription:
                        "A high-performance laptop for all your needs.",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Button(
                label: "GO BACK",
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Auth()));
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildProduct(
    BuildContext context, {
    required String imagePath,
    required String productName,
    required String productPrice,
    required String productDescription,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              imagePath: imagePath,
              productName: productName,
              productPrice: productPrice,
              productDescription: productDescription,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 100,
              fit: BoxFit.cover,
            ),
            Text(
              productName,
              style: const TextStyle(
                color: Color(0xFF333333), // Siyah ton
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  productPrice,
                  style: const TextStyle(
                    color: Color(0xFF007BFF), // Vurgu rengi olarak mavi
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 28, 81, 138), // Mavi vurgu
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Bottomnav()));
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image;
  final Widget destination;

  const CategoryTile(
      {super.key, required this.image, required this.destination});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        height: 120,
        width: 90,
        child: Center(
          child: Image.asset(image, height: 50),
        ),
      ),
    );
  }
}
