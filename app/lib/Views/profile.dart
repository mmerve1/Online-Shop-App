import 'package:app/Components/button.dart';
import 'package:app/Components/colors.dart';
import 'package:app/JSON/users.dart';
import 'package:app/Views/bottomnav.dart';
import 'package:app/Views/login.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Users? profile;
  const Profile({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Daha temiz bir görünüm için beyaz arka plan
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profil resmi
                const CircleAvatar(
                  radius: 77,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("lib/assets/images/human2.png"),
                    radius: 75,
                  ),
                ),
                const SizedBox(height: 20),
                // Kullanıcı adı ve email
                Text(
                  profile?.fullName ?? "Belirtilmemiş",
                  style: const TextStyle(
                    fontSize: 28,
                    color: Color.fromARGB(255, 50, 27, 179),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  profile?.email ?? "Belirtilmemiş",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),

                // Genel bilgiler
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person, size: 30),
                        subtitle: const Text("Full name"),
                        title: Text(profile?.fullName ?? "Belirtilmemiş",
                            style: const TextStyle(fontSize: 18)),
                      ),
                      const Divider(height: 1, thickness: 1),
                      ListTile(
                        leading: const Icon(Icons.email, size: 30),
                        subtitle: const Text("Email"),
                        title: Text(profile?.email ?? "Belirtilmemiş",
                            style: const TextStyle(fontSize: 18)),
                      ),
                      const Divider(height: 1, thickness: 1),
                      ListTile(
                        leading: const Icon(Icons.account_circle, size: 30),
                        subtitle: const Text("Username"),
                        title: Text(profile?.usrName ?? "Belirtilmemiş",
                            style: const TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Giriş butonu
                Button(
                  label: "SIGN UP",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),

                // Ürün görme butonu
                Button(
                  label: "SEE A PRODUCT",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          //birincisi değişkenim veriyi tutacak olan
                          //ikincisinde veri var bunu 1.ye atacak
                          builder: (context) => Bottomnav(
                                profile: profile,
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
