import 'dart:convert';
import 'package:deepbinder/routes/nav_bar.dart';
import 'package:deepbinder/routes/session_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class User {
  final String username;
  final Map<String, dynamic> attributes;
  final int lastActive;

  User({
    required this.username,
    required this.attributes,
    required this.lastActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> attributes = json['attributes'] ?? {};

    return User(
      username: json['username'] ?? '',
      attributes: attributes,
      lastActive: json['lastActive'] ?? 0,
    );
  }
}

class CreateNew extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<CreateNew> {
  late Future<List<User>> _usersFuture;
  String _formatDate(int millisecondsSinceEpoch) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final formatter = DateFormat.yMd().add_Hm();
    return formatter.format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _usersFuture = _getUsers(authProvider.user!.uri,
        authProvider.user!.datsource, authProvider.user!.authToken);
    // _usersFuture = _getUsers();
  }

  Future<List<User>> _getUsers(
      String uri, String datasource, String token) async {
    final response = await http.get(Uri.parse(
        uri + '/api/session/data/' + datasource + '/users?token=' + token));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      List<User> users = [];
      for (var key in jsonResponse.keys) {
        final userJson = jsonResponse[key];
        users.add(User.fromJson(userJson));
      }

      return users;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<User> _getUserDetails(
      String username, String datasource, String uri, String token) async {
    final String apiUrl =
        uri + '/api/session/data/postgresql/users/?token=' + token;
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return User.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Widget _buildListTile(User user) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user1 = authProvider.user;
    return GestureDetector(
      onTap: () async {
        print('user details');
        User detailedUser = await _getUserDetails(
            user.username, user1!.datsource, user1.uri, user1.authToken);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('User : ' + user.username),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Attributes: ${detailedUser.attributes}'),
                    SizedBox(height: 8),
                    Text('Last Active: ${_formatDate(user.lastActive)}'),
                    SizedBox(height: 8),
                    Text(
                        'Email Address: ${user.attributes['guac-email-address']}'),
                    SizedBox(height: 8),
                    Text(
                        'Organisational Role: ${user.attributes['guac-organizational-role']}'),
                    SizedBox(height: 8),
                    Text('Full Name: ${user.attributes['guac-full-name']}'),
                    SizedBox(height: 8),
                    Text(
                        'Organisationa ${user.attributes['guac-organizationa']}'),
                    SizedBox(height: 8),
                    Text('timezone: ${user.attributes['timezone']}'),
                    SizedBox(height: 8),
                    Text(
                        'Access window Start: ${user.attributes['access-windows-start']}'),
                    SizedBox(height: 8),
                    Text(
                        'Access windows end: ${user.attributes['access-window-end']}'),
                    SizedBox(height: 8),
                    Text('Valid Until: ${user.attributes['valid-until']}'),
                    SizedBox(height: 8),
                    Text('Valid From: ${user.attributes['valid-from']}'),
                    SizedBox(height: 8),
                    Text('Disabled: ${user.attributes['disabled']}')
                  ],
                ),
              ),
            );
          },
        );
      },
      child: ListTile(
        title: Text(user.username),
        subtitle: Text('Last Active: ${_formatDate(user.lastActive)}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: const BottomNavBar(1),
        appBar: AppBar(
          title: Text('API Demo'),
        ),
        body: Center(
          child: FutureBuilder(
            future: _usersFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                final List<User> users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final User user = users[index];
                    return Card(
                      child: _buildListTile(user),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
