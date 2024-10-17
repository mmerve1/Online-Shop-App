import 'package:app/JSON/users.dart';
import 'package:app/Views/Order.dart';
import 'package:app/Views/home.dart';
import 'package:app/Views/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Bottomnav extends StatefulWidget {
  final Users? profile;

  const Bottomnav({super.key, this.profile});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late List<Widget> pages;
  late Home homePage;
  late Order orderPage;
  late Profile profilePage;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    homePage = Home();
    orderPage = Order();
    profilePage = Profile(
        profile: widget
            .profile); // Profile sayfasına kullanıcı bilgilerini geçiriyoruz
    pages = [homePage, orderPage, profilePage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color.fromARGB(255, 164, 165, 170),
        color: const Color.fromARGB(255, 38, 19, 90),
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.shopping_bag_outlined, color: Colors.white),
          Icon(Icons.person_2_outlined, color: Colors.white)
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
