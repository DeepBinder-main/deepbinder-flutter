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
      title: 'Flutter layout demo',
      home: Scaffold(
          bottomNavigationBar: BottomNavBar(),
          appBar: AppBar(
            title: const Text('Profile'),
            // leading: const BackButton(color: Colors.white),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.offAllNamed('/login');
                  },
                  child: const Text('Logout')),
              Text(
                'Authentication token: ' + user!.authToken,
              ),

              // const Spacer()
              Text('Username: ' + user.username),
              // const spacer() ;
              Text('Datasource: ' + user.datsource),
              // const spacer() ;
            ],
          )),
    );
  }
}
