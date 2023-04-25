import 'package:deepbinder/routes/session_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return const Text('Not logged in');
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${user.authToken}'),
          Text('Username: ${user.username}'),
          Text('uri: ${user.uri}'),
          Text('datasource: ${user.datsource}'),
        ],
      );
    }
  }
}
