// import 'dart:convert';
// import 'package:deepbinder/routes/session_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// class UserGroup {
//   final String identifier;
//   final bool disabled;

//   UserGroup({required this.identifier, required this.disabled});

//   factory UserGroup.fromJson(Map<String, dynamic> json) {
//     return UserGroup(
//       identifier: json['identifier'],
//       disabled: json['attributes']['disabled'] == null ? false : json['attributes']['disabled'],
//     );
//   }
// }

// class ListOfGroups extends StatelessWidget {
//   final UserGroup userGroup;

//   const ListOfGroups({required this.userGroup});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: () => _showDetails(context),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 userGroup.identifier,
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Disabled: ${userGroup.disabled}',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showDetails(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(userGroup.identifier),
//         content: Text('Disabled: ${userGroup.disabled}'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UserGroupList extends StatefulWidget {
//   @override
//   _UserGroupListState createState() => _UserGroupListState();
// }

// class _UserGroupListState extends State<UserGroupList> {
//   late  Future<List<User>> _userGroups;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserGroups();
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     _userGroups = _fetchUserGroups(authProvider.user!.uri,
//         authProvider.user!.datsource, authProvider.user!.authToken);
//   }

//   Future<List<UserGroup>> _fetchUserGroups(String uri, String datasource, String token) async {
//     final url = Uri.parse('$uri/api/session/data/$datasource/userGroups?token=$token');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final jsonList = json.decode(response.body);
//       final userGroups = jsonList.entries.map((entry) => UserGroup.fromJson(entry.value)).toList();
//       setState(() {
//         _userGroups = userGroups;
//       });
//     } else {
//       throw Exception('Failed to fetch user groups');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('User Groups')),
//       body: _userGroups == null
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _userGroups.length,
//               itemBuilder: (context, index) {
//                 final userGroup = _userGroups[index];
//                 return ListOfGroups(userGroup: userGroup);
//               },
//             ),
//     );
//   }
// }
import 'dart:convert';
import 'package:deepbinder/routes/app_drawer.dart';
import 'package:deepbinder/routes/session_modal.dart';
import 'package:deepbinder/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListOfGroups extends StatefulWidget {
  const ListOfGroups({Key? key}) : super(key: key);

  @override
  _UserGroupsPageState createState() => _UserGroupsPageState();
}

class _UserGroupsPageState extends State<ListOfGroups> {
  List<dynamic> _userGroups = [];

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _fetchUserGroups(authProvider.user!.uri, authProvider.user!.datsource,
        authProvider.user!.authToken);
  }

  Future<void> _fetchUserGroups(
      String uri, String datasource, String token) async {
    final response = await http.get(
      Uri.parse('$uri/api/session/data/$datasource/userGroups?token=$token'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _userGroups = data.values.toList();
      });
    } else {
      print('Failed to fetch user groups: ${response.reasonPhrase}');
    }
  }

  Future<void> _showDeleteDialog(
      BuildContext context, dynamic userGroup) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Group'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this group?'),
                SizedBox(height: 10),
                Text('Identifier: ${userGroup['identifier']}'),
                SizedBox(height: 10),
                Text('Attributes: ${userGroup['attributes']}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                // TODO: Delete group here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.primaryColor,
        title: Text('List of Groups'),
      ),
      body: _userGroups.isNotEmpty
          ? ListView.builder(
              itemCount: _userGroups.length,
              itemBuilder: (context, index) {
                final userGroup = _userGroups[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                      child: Card(
                        child: ListTile(
                          minVerticalPadding: 20,
                          title: Text(userGroup['identifier']),
                          subtitle: Text(
                              userGroup['attributes']['disabled'] == null
                                  ? 'Enabled'
                                  : 'Disabled'),
                        ),
                      ),
                      onTap: () {
                        _showDeleteDialog(context, userGroup);
                      }),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}







// class UserGroup {
//   final String identifier;
//   final bool disabled;

//   UserGroup({required this.identifier, required this.disabled});

//   factory UserGroup.fromJson(Map<String, dynamic> json) {
//     return UserGroup(
//       identifier: json['identifier'],
//       disabled: json['attributes']['disabled'] == null
//           ? false
//           : json['attributes']['disabled'],
//     );
//   }
// }

// class ListOfGroups extends StatelessWidget {
//   final UserGroup userGroup;

//   const ListOfGroups({required this.userGroup});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: () => _showDetails(context),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 userGroup.identifier.toString(),
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Disabled: ${userGroup.disabled}',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showDetails(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(userGroup.identifier.toString()),
//         content: Text('Disabled: ${userGroup.disabled}'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UserGroupList extends StatefulWidget {
//   @override
//   _UserGroupListState createState() => _UserGroupListState();
// }

// class _UserGroupListState extends State<UserGroupList> {
//   late Future<List<UserGroup>> _userGroups;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<List<UserGroup>> _fetchUserGroups(
//       String uri, String datasource, String token) async {
//     final url =
//         Uri.parse('$uri/api/session/data/$datasource/userGroups?token=$token');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final jsonList = json.decode(response.body);
//       final userGroups = jsonList.entries
//           .map((entry) => UserGroup.fromJson(entry.value))
//           .toList();
//       print(userGroups);
//       return userGroups;
//     } else {
//       throw Exception('Failed to fetch user groups');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     _userGroups = _fetchUserGroups(authProvider.user!.uri,
//         authProvider.user!.datsource, authProvider.user!.authToken);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Groups'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AppDrawer(),
//                 ),
//               );
//             },
//             icon: Icon(Icons.menu),
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<UserGroup>>(
//         future: _userGroups,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final userGroups = snapshot.data!;
//             return ListView.builder(
//               itemCount: userGroups.length,
//               itemBuilder: (context, index) {
//                 final userGroup = userGroups[index];
//                 return ListOfGroups(userGroup: userGroup);
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 '${snapshot.error}',
//                 style: TextStyle(fontSize: 20),
//               ),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
