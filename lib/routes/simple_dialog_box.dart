import 'dart:convert';

import 'package:deepbinder/routes/session_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_group.dart';
import 'create_single_user.dart';
import 'package:http/http.dart' as http;

class CreateGroupDialog extends StatefulWidget {
  const CreateGroupDialog({super.key});

  @override
  State<CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends State<CreateGroupDialog> {
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController disabledController = TextEditingController();
  String _identifier = '';
  String _disabled = '';
  bool _isLoading = false;
  String _errorMessage = '';
  @override
  void dispose() {
    identifierController.dispose();
    disabledController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: const Text('Create a new user group'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _disabled = value;
                    });
                  },
                  controller: identifierController,
                  decoration: const InputDecoration(
                    labelText: 'Identifier',
                    hintText: 'Enter the user identifier',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _identifier = value;
                    });
                  },
                  controller: disabledController,
                  decoration: const InputDecoration(
                    labelText: 'Disabled',
                    hintText: 'Enter the disabled attribute',
                  ),
                ),
              ],
            ),
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () async {
                  _isLoading
                      ? null
                      : _createUserGroup(
                          user!.uri, user.datsource, user.authToken);
                },
                child:
                    _isLoading ? CircularProgressIndicator() : Text('Create'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _createUserGroup(
      String uri, String datsource, String authToken) async {
    String _identifier = identifierController.text;
    String _disabled = disabledController.text;
    bool _isLoading = false;
    String _errorMessage = '';
    setState(() {
      _isLoading = true;
    });
    try {
      await createUserGroup(uri, datsource, authToken, _identifier, _disabled);
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class CreateUserDialog extends StatefulWidget {
  @override
  _CreateUserDialogState createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  Map<String, dynamic> _attributes = {
    'disabled': '',
    'expired': '',
    'access-window-start': '',
    'access-window-end': '',
    'valid-from': '',
    'valid-until': '',
    'timezone': null,
    'guac-full-name': '',
    'guac-organization': '',
    'guac-organizational-role': ''
  };

  String _username = '';
  String _password = '';
  bool _isLoading = false;
  String _errorMessage = '';
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _disabledController = TextEditingController();
  TextEditingController _expiredController = TextEditingController();
  TextEditingController _accessWindowStartController = TextEditingController();
  TextEditingController _accessWindowEndController = TextEditingController();
  TextEditingController _validFromController = TextEditingController();
  TextEditingController _validUntilController = TextEditingController();
  TextEditingController _timezoneController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _organizationController = TextEditingController();
  TextEditingController _organizationalRoleController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createUser(
      String uri, String datasource, String authToken) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await createUser(_username, _password, uri, datasource, authToken);
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    return SimpleDialog(
      title: const Text('Create User'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              TextFormField(
                controller: _disabledController,
                decoration: InputDecoration(labelText: 'Disabled'),
                onChanged: (value) {
                  setState(() {
                    _attributes['disabled'] = value;
                  });
                },
              ),
              TextFormField(
                controller: _expiredController,
                decoration: InputDecoration(labelText: 'Expired'),
                onChanged: (value) {
                  setState(() {
                    _attributes['expired'] = value;
                  });
                },
              ),
              TextFormField(
                controller: _accessWindowStartController,
                decoration: InputDecoration(labelText: 'Access Window Start'),
                onChanged: (value) {
                  setState(() {
                    _attributes['access-window-start'] = value;
                  });
                },
              ),
              TextFormField(
                controller: _accessWindowEndController,
                decoration: InputDecoration(labelText: 'Access Window End'),
                onChanged: (value) {
                  setState(() {
                    _attributes['access-window-end'] = value;
                  });
                },
              ),
              TextFormField(
                controller: _validFromController,
                decoration: InputDecoration(labelText: 'Valid From'),
                onChanged: (value) {
                  setState(() {
                    _attributes['valid-from'] = value;
                  });
                },
              ),
              TextFormField(
                controller: _validUntilController,
                decoration: InputDecoration(labelText: 'Valid Until'),
                onChanged: (value) {
                  setState(() {
                    _attributes['valid-until'] = value;
                  });
                },
              ),
              TextFormField(
                controller: _timezoneController,
                decoration: InputDecoration(labelText: 'Timezone'),
                onChanged: (value) {
                  setState(() {
                    _attributes['timezone'] = value;
                  });
                },
              ),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                onChanged: (value) {
                  setState(() {
                    _attributes['guac-full-name'] = value;
                  });
                },
              ),
              TextFormField(
                controller: _organizationController,
                decoration: InputDecoration(labelText: 'Organization'),
                onChanged: (value) {
                  setState(() {
                    _attributes['guac-organization'] = value;
                  });
                },
              ),
              TextFormField(
                controller: _organizationalRoleController,
                decoration: InputDecoration(labelText: 'Organizational Role'),
                onChanged: (value) {
                  setState(() {
                    _attributes['guac-organizational-role'] = value;
                  });
                },
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ElevatedButton(
                onPressed: () async {
                  _isLoading
                      ? null
                      : _createUser(user!.uri, user.datsource, user.authToken);
                },
                child:
                    _isLoading ? CircularProgressIndicator() : Text('Create'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
