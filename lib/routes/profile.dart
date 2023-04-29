import 'package:deepbinder/routes/about.dart';
import 'package:deepbinder/routes/nav_bar.dart';
import 'package:deepbinder/routes/session_modal.dart';
import 'package:deepbinder/routes/users.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:deepbinder/routes/shared.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    return MaterialApp(
      home: Scaffold(
          bottomNavigationBar: const BottomNavBar(2),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            leadingWidth: 30,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/logo-no-background (1).png',
                  fit: BoxFit.contain,
                  height: 50,
                ),
                Text('Profile'),
              ],
            ),
            backgroundColor: Color.fromARGB(255, 21, 37, 117),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Authentication token: '.toUpperCase() + user!.authToken+ '\n',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontWeight: FontWeight.bold),
                ),
                // const Spacer()
                Text(
                  'Username: '.toUpperCase() + user.username+ '\n',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontWeight: FontWeight.bold),
                ),
                // const spacer() ;
                Text(
                  'Datasource: '.toUpperCase() + user.datsource+ '\n',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontWeight: FontWeight.bold),
                ),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 21, 37, 117))),
                      onPressed: () {
                        Navigator.pop(context);
                        Get.offAllNamed('/login');
                      },
                      child: const Text('Logout')),
                ),
                // const spacer() ;
              ],
            ),
          )),
    );
  }
}
