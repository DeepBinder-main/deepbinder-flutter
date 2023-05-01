import 'package:deepbinder/routes/app_drawer.dart';
import 'package:deepbinder/routes/create_single_user.dart';
import 'package:deepbinder/routes/expandable_FAB.dart';
import 'package:deepbinder/routes/list_of_users.dart';
import 'package:deepbinder/routes/simple_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:deepbinder/routes.dart';

import 'nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavBar(1),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppDrawer()),
              );
            },
          ),
          automaticallyImplyLeading: false,
          title: Image.asset(
            'assets/images/logo-no-background (1).png',
            fit: BoxFit.contain,
            height: 50,
          ),
          backgroundColor: Color.fromARGB(255, 21, 37, 117),
        ),
        body: Card(
          child: Text("Hello"),
        ),
        drawer: AppDrawer(),
        floatingActionButton: ExpandableFab(
          children: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                showDialog(
                    context: context, builder: (context) => CreateUserDialog());
              },
            ),
            IconButton(
              icon: Icon(Icons.group),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => CreateGroupDialog());
              },
            ),
          ],
          icon: Icons.add,

          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     showModalBottomSheet(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return Container(
          //           child: Wrap(children: <Widget>[
          //             ListTile(
          //               leading: const Icon(Icons.person),
          //               title: const Text('Create User'),
          //               onTap: () {
          //                 Navigator.pop(context);
          //                 // Place your "create user" code here
          //               },
          //             ),
          //             ListTile(
          //               leading: const Icon(Icons.group),
          //               title: const Text('Create Group'),
          //               onTap: () {
          //                 Navigator.pop(context);
          //                 // Place your "create group" code here
          //               },
          //             ),
          //             ListTile(
          //               leading: const Icon(Icons.cancel),
          //               title: const Text('Cancel'),
          //               onTap: () {
          //                 Navigator.pop(context);
          //               },
          //             ),
          //           ]),
          //         );
          //       },
          //     );
          //   },
        ),
      ),
    );
  }
}
