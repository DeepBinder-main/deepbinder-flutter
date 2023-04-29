import "package:deepbinder/routes/create.dart";
import "package:deepbinder/routes/home.dart";
import "package:deepbinder/routes/users.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "about.dart";
import "profile.dart";

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(int i, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // selectedItemColor: Colors.red,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt_rounded,
              size: 20,
            ),
            label: "Connections"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.rocket_rounded,
              size: 20,
            ),
            label: "Profile"),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Users()));
            Get.offAllNamed('/users');
            break;
          case 1:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateNew()));
            Get.offAllNamed('/home');
            break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile()));
            Get.offAllNamed('/profile');
            break;
        }
      },
    );
  }
}
