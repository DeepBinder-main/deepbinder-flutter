import 'package:deepbinder/routes/about.dart';
import 'package:deepbinder/routes/nav_bar.dart';
import 'package:deepbinder/routes/session_modal.dart';
import 'package:deepbinder/routes/users.dart';
import 'package:deepbinder/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:deepbinder/routes.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:deepbinder/routes/shared.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
//     return MaterialApp(
//       // theme: appTheme,
//       theme: ThemeData.dark(useMaterial3: true),
//       home: Scaffold(
//           bottomNavigationBar:  BottomNavBar(2),
//           appBar: AppBar(
//             // leading: IconButton(
//               // icon: const Icon(Icons.arrow_back),
//               // onPressed: () {
//               //   Navigator.pop(context);
//               // },
//             // ),
//             leadingWidth: 30,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset(
//                   'assets/images/logo-no-background (1).png',
//                   fit: BoxFit.contain,
//                   height: 50,
//                 ),
//                 Text('Profile'),
//               ],
//             ),
//             backgroundColor: Color.fromARGB(255, 21, 37, 117),
//           ),
//           body: RefreshIndicator(
//             onRefresh: () {
//               return authProvider.refreshUser();

//             },
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Authentication token: '.toUpperCase() + user!.authToken+ '\n',
//                     style: TextStyle(
//                         fontSize: 20,
//                         // color: Color.fromARGB(255, 2, 2, 2),
//                         fontWeight: FontWeight.bold),
//                   ),
//                   // const Spacer()
//                   Text(
//                     'Username: '.toUpperCase() + user.username+ '\n',
//                     style: TextStyle(
//                         fontSize: 20,
//                         // color: Color.fromARGB(255, 2, 2, 2),
//                         fontWeight: FontWeight.bold),
//                   ),
//                   // const spacer() ;
//                   Text(
//                     'Datasource: '.toUpperCase() + user.datsource+ '\n',
//                     style: TextStyle(
//                         fontSize: 20,
//                         // color: Color.fromARGB(255, 2, 2, 2),
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                         style: ButtonStyle(
//                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Color.fromARGB(255, 21, 37, 117))),
//                         onPressed: () {
//                           print(context);
//                           Navigator.popAndPushNamed(context, '/login');
//                           // Navigator.pop(context, true);
//                           // Get.offAllNamed('/login');
//                         },
//                         child: const Text('Logout')),
//                   ),
//                   // const spacer() ;
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
    return MaterialApp(
      // theme: appTheme,
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        
        floatingActionButton: TextButton(
          child: Text("Refresh Token"),
          onPressed: () {
            authProvider.refreshUser(user!.username, user.password,user.uri);
          },
        ),
        bottomNavigationBar: BottomNavBar(2),
        appBar: AppBar(
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
                'Authentication token: '.toUpperCase() +
                    user!.authToken +
                    '\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Username: '.toUpperCase() + user.username + '\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Datasource: '.toUpperCase() + user.datsource + '\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                      Color.fromARGB(255, 21, 37, 117),
                    ),
                  ),
                  onPressed: () {
                    print(context);
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
