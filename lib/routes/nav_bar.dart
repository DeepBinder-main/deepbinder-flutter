import "package:deepbinder/routes/users.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "about.dart";
import "profile.dart";

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt_rounded,
              size: 20,
            ),
            label: "List of Connections"),
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
                context, MaterialPageRoute(builder: (context) => MyApp()));
            Get.offAllNamed('/home');
            break;
          case 2:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
            Get.offAllNamed('/profile');
            break;
        }
      },
    );
  }
}
// GNav(
//             gap: 8,
//             // activeColor: Colors.blue,
//             backgroundColor: Colors.black,
//             onTabChange: (value) {
//               print(value);
//             },
//             tabs: [
//               GButton(
//                 icon: Icons.home,
//                 text: 'Home',
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => MyApp()));
//                   Get.offAllNamed('/home');
//                 },
//               ),
//               GButton(
//                 icon: Icons.list,
//                 text: 'Users',
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Users()));
//                   Get.offAllNamed('/search');
//                 },
//               ),
//               GButton(
//                 icon: Icons.person,
//                 text: 'Profile',
//                 iconActiveColor: Colors.blue,
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Profile()));
//                   Get.offAllNamed('/profile');
//                 },
//               ),
//             ],
//           ),