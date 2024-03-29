import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
Future<http.Response> createUserGroup(String uri, String datsource, String authToken, String identifier, String disabled) async {
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'identifier': identifier,
    'attributes': {
      'disabled': disabled,
    },
  });

  final http.Response response = await http.post(
    Uri.parse('$uri/api/session/data/$datsource/userGroups?token=$authToken'),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    print('User Group created successfully');
  } else {
    print('Failed to create user: ${response.statusCode} '+response.body);
  }
  
  return response;
}
