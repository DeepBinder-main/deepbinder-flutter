import 'package:deepbinder/routes/about.dart';
import 'package:deepbinder/routes/profile.dart';
import 'package:deepbinder/routes/session_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:deepbinder/routes/shared.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
          bottomNavigationBar: GNav(
            gap: 8,
            activeColor: Colors.blue,
            backgroundColor: Colors.black,
            onTabChange: (value) {
              print(value);
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                  Get.offAllNamed('/home');
                },
              ),
              GButton(
                icon: Icons.list,
                text: 'Users',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Users()));
                  Get.offAllNamed('/search');
                },
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                  Get.offAllNamed('/profile');
                },
              ),
            ],
          ),
          appBar: AppBar(
            title: const Text('Users'),
            // leading: const BackButton(color: Colors.white),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center
            children: [],
          )),
    );
  }
}
