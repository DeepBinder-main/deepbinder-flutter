import 'package:flutter/material.dart';
import 'create_single_user.dart';

class CreateGroupDialog extends StatefulWidget {
  const CreateGroupDialog({super.key});

  @override
  State<CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends State<CreateGroupDialog> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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

  Future<void> _createUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await createUser(_username, _password);
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
                onPressed: _isLoading ? null : _createUser,
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
