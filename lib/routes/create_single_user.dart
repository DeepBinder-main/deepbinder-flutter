import 'dart:convert';
import 'package:flutter/material.dart';
import 'connection_widget.dart';
import 'package:http/http.dart' as http;

Future<void> createUser(String username, String password, String uri,
    String datasource, String authToken) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST',
      Uri.parse('$uri/api/session/data/$datasource/users?token=$authToken'));
  request.body = json.encode({
    "username": username,
    "password": password,
    "attributes": {
      "disabled": "",
      "expired": "",
      "access-window-start": "",
      "access-window-end": "",
      "valid-from": "",
      "valid-until": "",
      "timezone": null,
      "guac-full-name": "",
      "guac-organization": "",
      "guac-organizational-role": ""
    }
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
    print(username);
    print(authToken);
    print("Error creating user");
  }
}
