import 'package:deepbinder/theme.dart';
import 'package:flutter/material.dart';
import 'package:deepbinder/routes/list_of_groups.dart';
import 'package:deepbinder/routes/list_of_users.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(right: 20),
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo-no-background (1).png',
                      height: 110,
                    ),
                    Text(
                      'Manage your users and groups',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: appTheme.primaryColor,
            ),
          ),
          ListTile(
            title: Text('List of Users'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListOfUsers()),
              );
            },
          ),
          ListTile(
            title: Text('List of Groups'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ListOfGroups(userGroup: UserGroup.fromJson({}))),
              );
            },
          ),
        ],
      ),
    );
  }
}
