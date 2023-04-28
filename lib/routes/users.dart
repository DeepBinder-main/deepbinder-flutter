// import 'dart:convert';
// import 'package:deepbinder/routes/session_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import 'connection_widget.dart';
// import 'nav_bar.dart';

// class Users extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<Users> {
//   List<dynamic> _connections = [];
//   bool _isLoading = false;
//   String _formatDate(int millisecondsSinceEpoch) {
//     final dateTime =
//         DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
//     final formatter = DateFormat.yMd().add_Hm();
//     return formatter.format(dateTime);
//   }

//   Color _getConnectionStatusColor(int activeConnections) {
//     return activeConnections == 0 ? Colors.red : Colors.blue;
//   }

//   Widget _buildConnectionStatusDot(int activeConnections) {
//     return Container(
//       width: 10,
//       height: 10,
//       decoration: BoxDecoration(
//         color: _getConnectionStatusColor(activeConnections),
//         shape: BoxShape.circle,
//       ),
//     );
//   }

//   Future<void> getData(String uri, String datasource, String token) async {
//     setState(() {
//       _isLoading = true;
//     });
//     final response = await http.get(Uri.parse(uri +
//         '/api/session/data/' +
//         datasource +
//         '/connections?token=' +
//         token));
//     if (response.statusCode == 200) {
//       setState(() {
//         _connections = json.decode(response.body).values.toList();
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       print(response.reasonPhrase);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Sort the connections list based on activeConnections
//     final authProvider = Provider.of<AuthProvider>(context);
//     final user = authProvider.user;
//     _connections.sort(
//         (a, b) => b['activeConnections'].compareTo(a['activeConnections']));
//     return Scaffold(
//         bottomNavigationBar: const BottomNavBar(),
//         appBar: AppBar(
//           title: const Text('List of Connections'),
//           automaticallyImplyLeading: false,
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async {
//             final authProvider =
//                 Provider.of<AuthProvider>(context, listen: false);
//             await getData(authProvider.user!.uri, authProvider.user!.datsource,
//                 authProvider.user!.authToken);
//           },
//           child: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   final authProvider =
//                       Provider.of<AuthProvider>(context, listen: false);
//                   await getData(
//                       authProvider.user!.uri,
//                       authProvider.user!.datsource,
//                       authProvider.user!.authToken);
//                 },
//                 child: const Text('Get Data'),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(8),
//                   itemCount: _connections.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final connection = _connections[index];
//                     return GestureDetector(
//                       onTap: () {
//                         // TODO: Implement onPress functionality
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => TargetWidget(
//                               uri: user!.uri,
//                               datasource: user.datsource,
//                               authToken: user.authToken,
//                               connectionId: int.parse(connection['identifier']),
//                               name: connection['name'],
//                               // name: connection['name'],
//                               // protocol: connection['protocol'],
//                               // identifier: connection['identifier'],
//                               // parentIdentifier: connection['parentIdentifier'],
//                             ),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(connection['name']),
//                                   Text('protocol : ' + connection['protocol']),
//                                   Text(connection['identifier']),
//                                   Text(connection['parentIdentifier']),
//                                   // Text(connection['activeConnections']
//                                   //     .toString()),
//                                   Text('last active : ' +
//                                       _formatDate(connection['lastActive'])),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: connection['activeConnections'] == 1
//                                     ? Colors.blue
//                                     : Colors.red,
//                               ),
//                               width: 10,
//                               height: 10,
//                             ),
//                             const SizedBox(width: 8),
//                             const Icon(Icons.navigate_next_rounded),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

import 'dart:convert';
import 'package:deepbinder/routes/session_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'connection_widget.dart';
import 'nav_bar.dart';

class Users extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Users> {
  List<dynamic> _connections = [];
  bool _isLoading = true;

  String _formatDate(int millisecondsSinceEpoch) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final formatter = DateFormat.yMd().add_Hm();
    return formatter.format(dateTime);
  }

  Color _getConnectionStatusColor(int activeConnections) {
    return activeConnections == 0 ? Colors.red : Colors.blue;
  }

  Widget _buildConnectionStatusDot(int activeConnections) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: _getConnectionStatusColor(activeConnections),
        shape: BoxShape.circle,
      ),
    );
  }

  Future<void> getData(String uri, String datasource, String token) async {
    final response = await http.get(Uri.parse(uri +
        '/api/session/data/' +
        datasource +
        '/connections?token=' +
        token));
    if (response.statusCode == 200) {
      setState(() {
        _connections = json.decode(response.body).values.toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    // Get the data when the page is opened
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    getData(authProvider.user!.uri, authProvider.user!.datsource,
        authProvider.user!.authToken);
  }

  @override
  Widget build(BuildContext context) {
    // Sort the connections list based on activeConnections
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    _connections.sort(
        (a, b) => b['activeConnections'].compareTo(a['activeConnections']));
    return Scaffold(
        bottomNavigationBar: const BottomNavBar(0),
        appBar: AppBar(
          title: const Text('List of Connections'),
          automaticallyImplyLeading: false,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  await getData(
                      authProvider.user!.uri,
                      authProvider.user!.datsource,
                      authProvider.user!.authToken);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _connections.length,
                        itemBuilder: (BuildContext context, int index) {
                          final connection = _connections[index];
                          return GestureDetector(
                            onTap: () {
                              // TODO: Implement onPress functionality
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TargetWidget(
                                    uri: user!.uri,
                                    datasource: user.datsource,
                                    authToken: user.authToken,
                                    connectionId:
                                        int.parse(connection['identifier']),
                                    name: connection['name'],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(connection['name']),
                                        Text('protocol : ' +
                                            connection['protocol']),
                                        Text(connection['identifier']),
                                        Text(connection['parentIdentifier']),
                                        Text('last active : ' +
                                            _formatDate(
                                                connection['lastActive'])),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          connection['activeConnections'] == 1
                                              ? Colors.blue
                                              : Colors.red,
                                    ),
                                    width: 10,
                                    height: 10,
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.navigate_next_rounded),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }
}
