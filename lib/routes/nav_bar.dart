import "package:deepbinder/routes/create.dart";
import "package:deepbinder/routes/home.dart";
import "package:deepbinder/routes/list_of_users.dart";
import "package:deepbinder/routes/users.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "about.dart";
import "profile.dart";

class BottomNavBar extends StatelessWidget {
  BottomNavBar(int i, {super.key});
  var color_selected = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // selectedItemColor: Colors.red,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt_rounded,
              size: 20,
              color: color_selected,
            ),
            label: "Connections"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
              color: color_selected,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.rocket_rounded,
              size: 20,
              color: color_selected,
            ),
            label: "Profile"),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
          color_selected = Colors.blue;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Users()));
            Get.offAllNamed('/users');
            break;
          case 1:
          color_selected = Colors.blue;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen()));
            Get.offAllNamed('/home');
            break;
          case 2:
          color_selected = Colors.blue;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile()));
            Get.offAllNamed('/profile');
            break;
        }
      },
    );
  }
}
