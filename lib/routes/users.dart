// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Connection {
//   final String name;
//   final String identifier;
//   final int protocol;
//   final String parentIdentifier;
//   final String attributes;

//   Connection({
//     required this.name,
//     required this.identifier,
//     required this.protocol,
//     required this.parentIdentifier,
//     required this.attributes,
//   });

//   factory Connection.fromJson(Map<String, dynamic> json) {
//     return Connection(
//       name: json['name'],
//       identifier: json['identifier'],
//       protocol: json['protocol'],
//       parentIdentifier: json['parentIdentifier'],
//       attributes: json['attributes'],
//     );
//   }
// }

// class Users extends StatefulWidget {
//   const Users({Key? key}) : super(key: key);

//   @override
//   _UserState createState() => _UserState();
// }

// class _UserState extends State<Users> {
//   List<Connection> _connections = [];

//   Future<void> _fetchData() async {
//     final response = await http.get(Uri.parse(
//         'https://guac.nullchapter.tech/api/session/data/postgresql/connections?token=05E0C84469F9FA0003A70D8F4FC35ED3D48C10DB5FF4E853B48FFEDDC8F10C51'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body) as List<dynamic>;
//       final connections = data
//           .map((dynamic connection) =>
//               Connection.fromJson(connection as Map<String, dynamic>))
//           .toList();
//       setState(() {
//         _connections = connections;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Connections'),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(10),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//         ),
//         itemCount: _connections.length,
//         itemBuilder: (BuildContext context, int index) {
//           final connection = _connections[index];
//           return Card(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(connection.name),
//                 const SizedBox(height: 10),
//                 Text('Host: ${connection.identifier}:${connection.protocol}'),
//                 const SizedBox(height: 10),
//                 Text('Username: ${connection.parentIdentifier}'),
//                 const SizedBox(height: 10),
//                 Text('Password: ${connection.attributes}'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Users extends StatefulWidget {
//   @override
//   _MyPageState createState() => _MyPageState();
// }

// class _MyPageState extends State<Users> {
//   List<dynamic> _data = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     var url = Uri.parse('https://guac.nullchapter.tech/api/session/data/postgresql/connections?token=BD8E91459F2DB19230520F73FC21D192F6120BA1C4CEDEAB3493B0534232B52F');
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       setState(() {
//         _data = json.decode(response.body);
//       });
//     } else {
//       print('Failed to fetch data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List of connections'),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         itemCount: _data.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             child: Column(
//               children: [
//                 Text(_data[index]['name']),
//                 Text(_data[index]['identifier']),
//                 // Text(_data[index]['database']),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Users> {
  String _responseData = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final response = await http.get(Uri.parse(
        'https://guac.nullchapter.tech/api/session/data/postgresql/connections?token=C79AA3F12419E3A59854953677BE3FE7E23935F230A6EC0D6FB6FD5029216F00'));
    if (response.statusCode == 200) {
      setState(() {
        _responseData = response.body;
      });
      print(_responseData);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            
            Text(
              "API Response",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _responseData,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'dart:convert';

// import 'package:deepbinder/routes/about.dart';
// import 'package:deepbinder/routes/profile.dart';
// import 'package:deepbinder/routes/session_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:provider/provider.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:deepbinder/routes/shared.dart';
// import 'dart:convert';
// import 'package:http/http.dart';
// import 'users.dart';
// import 'postman.dart';

// class Users extends StatefulWidget {
//   const Users({super.key});

//   @override
//   State<Users> createState() => _UsersState();
// }

// class _UsersState extends State<Users> {
//   late String name;
//   late String id;

//   fetchData(String uri, datasource, token) async {
//     try {
//       Response response = await post(
//           // Uri.parse(
//           //     '${uri}/api/session/data/${datasource}/connections?token=${token}'),
//           Uri.parse(
//               'https://guac.nullchapter.tech/api/session/data/postgresql/connections?token=40361B757D8A4FCC7B1FBCCA7CEE782EFF95F186B678293279DAB4C87D697E65'),
//           body: {'name': this.name, 'identifier': this.id});

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body.toString());
//         print(data[0]);
//         print('Login successfully');
//         return data[0];
//       } else {
//         print('failed');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         child: Text(fetchData('https://guac.nullchapter.tech', "postgresql", "BF5C55D29748DA9EDBC261064ACA657DFEB01595D2DB8A31D527EB60ADB2BBC1")),
//       ),
//     );
//   }
// }







// class Users extends StatefulWidget {
//   @override
//   _UsersState createState() => _UsersState();
// }

// class _UsersState extends State<Users> {
//   var _data = {"hello": "bruh"};
//   @override
//   void initState() {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final user = authProvider.user;
//     super.initState();
//     fetchData(user!.uri, user.datsource, user.authToken);
//   }

//   Future<Map<String, dynamic>> fetchData(
//       String uri, String datsource, String token) async {
//     Map<String, dynamic> _data = {};
//     var request = http.Request(
//         'GET',
//         Uri.parse(
//             '${uri}/api/session/data/${datsource}/connections?token=${token}'));
//     http.StreamedResponse response = await request.send();
// //   if (response.statusCode == 200) {
// //   return await response.stream.bytesToString();
// // }
// // else {
// //   print(response.reasonPhrase);
// // }
//     if (response.statusCode == 200) {
//       final data = await response.stream.bytesToString();
//       final decodedData = jsonDecode(data) as Map<String, dynamic>;
//       setState(() {
//         _data = decodedData;
//       });
//       return _data;
//     } else {
//       _data = {"hello": "bruh"};
//       print(response.reasonPhrase);
//       throw Exception('Failed to fetch data' + _data[0]);
//     }
//   }

//   List<String> items = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//     'Item 6',
//     'Item 7',
//     'Item 8',
//     'Item 9',
//     'Item 10',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List of Connections'),
//       ),
//       body: GridView.builder(
//         gridDelegate:
//             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemCount: _data.length,
//         itemBuilder: (context, index) {
//           final item = _data.values.elementAt(index);
//           return Card(
//             child: ListTile(
//               title: Text(item),
//               subtitle: Text(item),
//               trailing: Text(item),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add item logic here
//           setState(() {
//             items.add('New Item');
//           });
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
