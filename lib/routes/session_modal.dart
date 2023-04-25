import 'dart:convert';

import 'package:deepbinder/routes/about.dart';
import 'package:deepbinder/routes/page2.dart';
import 'package:deepbinder/routes/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page.dart';
import 'profile_modal.dart';

class User {
  final String authToken;
  final String username;
  final String datsource;
  final String uri;
  User(
      {required this.authToken,
      required this.username,
      required this.datsource,
      required this.uri});

  // from json string
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      authToken: json['authToken'],
      username: json['username'],
      datsource: json['datasource'],
      uri: json['uri'],
    );
  }
}

class AuthProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> login(BuildContext context, String username, String password,
      String uri) async {
    // print(uri);
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request =
        http.Request('POST', Uri.parse(uri + '/api/tokens?token=null'));
    request.bodyFields = {
      'username': username,
      'password': password,
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final URI = uri;
    if (response.statusCode == 200) {
      print('Hello');
      final json = await response.stream.bytesToString();
      print(json);
      // _user = User.fromJson(jsonData);
      final authToken = jsonDecode(json)['authToken'];
      final username = jsonDecode(json)['username'];
      final datasource = jsonDecode(json)['dataSource'];
      print(json.runtimeType);
      Map<String, dynamic> data = {
        'authToken': authToken,
        'username': username,
        'datasource': datasource,
        'uri': URI,
      };
      _user = User.fromJson(data);
      notifyListeners();
      final snackBar = SnackBar(
        content: Text('Logged in as ' + _user.toString()),
        backgroundColor: (Colors.black),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyApp();
      }));
    } else {
      // throw Exception('Failed to login');
      final snackBar = SnackBar(
        content: const Text('Failed to login'),
        backgroundColor: (Colors.black),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // void logout() {
  //   _user = null;
  //   notifyListeners();
  //   Navigator.push(context, MaterialPageRoute(builder: builder) {
  //     return Page();
  //   });
  // }
}
