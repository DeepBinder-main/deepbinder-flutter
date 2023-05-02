import 'package:deepbinder/routes/app_drawer.dart';
import 'package:deepbinder/routes/create_single_user.dart';
import 'package:deepbinder/routes/expandable_FAB.dart';
import 'package:deepbinder/routes/list_of_users.dart';
import 'package:deepbinder/routes/simple_dialog_box.dart';
import 'package:deepbinder/theme.dart';
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
      theme: appTheme,
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
        body: Center(
          child: Column(
            children: [
              Container(
                child: Text(
                  "Welocome to DeepBinder!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                padding: EdgeInsets.all(20),
              ),
              Image.asset(
                'assets/images/logo-no-background (1).png',
                fit: BoxFit.contain,
                height: 200 ,
                width: 200,
                alignment: Alignment.center,
              ),
            ],
          ),
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
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//         leading: IconButton(
//           icon: Icon(Icons.menu),
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           },
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'Drawer Header',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text('Item 1'),
//               onTap: () {
//                 // do something
//               },
//             ),
//             ListTile(
//               title: Text('Item 2'),
//               onTap: () {
//                 // do something
//               },
//             ),
//             ListTile(
//               title: Text('Item 3'),
//               onTap: () {
//                 // do something
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Text('My App Body'),
//       ),
//     );
//   }
// }
