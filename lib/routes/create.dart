import 'package:flutter/material.dart';

import 'nav_bar.dart';

class CreateNew extends StatefulWidget {
  @override
  _MyNewPageState createState() => _MyNewPageState();
}

class _MyNewPageState extends State<CreateNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('This is my new page!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                child: Wrap(children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Create User'),
                    onTap: () {
                      Navigator.pop(context);
                      // Place your "create user" code here
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.group),
                    title: const Text('Create Group'),
                    onTap: () {
                      Navigator.pop(context);
                      // Place your "create group" code here
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.cancel),
                    title: const Text('Cancel'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ]),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
