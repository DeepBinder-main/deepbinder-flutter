import 'package:flutter/material.dart';
import 'package:deepbinder/routes/list_of_groups.dart';
import 'package:deepbinder/routes/list_of_users.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('DeepBinder App'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
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
                MaterialPageRoute(builder: (context) => ListOfGroups(userGroup: UserGroup.fromJson({}))),
              );
            },
          ),
        ],
      ),
    );
  }
}
