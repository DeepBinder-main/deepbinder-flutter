import 'dart:convert';
import 'package:deepbinder/routes/about.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TargetWidget extends StatefulWidget {
  final String name;
  final String uri;
  final String datasource;
  final String authToken;
  final int connectionId;

  const TargetWidget({
    Key? key,
    required this.name,
    required this.uri,
    required this.datasource,
    required this.authToken,
    required this.connectionId,
  }) : super(key: key);

  @override
  _TargetWidgetState createState() => _TargetWidgetState();
}

class _TargetWidgetState extends State<TargetWidget> {
  Map<String, dynamic> _data = {};
  List<Map<String, dynamic>> _history = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
    _getHistory();
  }

  Future<void> _getData() async {
    setState(() => _isLoading = true);
    final response = await http.get(
      Uri.parse(
        widget.uri +
            '/api/session/data/' +
            widget.datasource +
            '/connections/' +
            widget.connectionId.toString() +
            '/parameters?token=' +
            widget.authToken,
      ),
    );
    setState(() => _isLoading = false);
    if (response.statusCode == 200) {
      setState(() {
        _data = json.decode(response.body);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _getHistory() async {
    final request = http.Request(
      'GET',
      Uri.parse(
        widget.uri +
            '/api/session/data/' +
            widget.datasource +
            '/connections/' +
            widget.connectionId.toString() +
            '/history?token=' +
            widget.authToken,
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final historyJson = await response.stream.bytesToString();
      final historyData = json.decode(historyJson) as List;
      setState(() {
        _history = historyData.cast<Map<String, dynamic>>();
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _deleteConnection(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this connection?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () async {
              Navigator.pop(context); // Close the confirmation dialog
              setState(() => _isLoading = true);
              final request = http.Request(
                'DELETE',
                Uri.parse(
                  '${widget.uri}/api/session/data/${widget.datasource}/connections/${widget.connectionId}?token=${widget.authToken}',
                ),
              );
              final response = await request.send();
              setState(() => _isLoading = false);
              if (response.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${widget.name} (${widget.connectionId}) has been deleted.'),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Connection Deleted'),
                    content: const Text(
                        'The connection has been successfully deleted.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        },
                      ),
                    ],
                  ),
                );
              } else {
                print(response.reasonPhrase);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _killSession(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Session Kill'),
        content: const Text(
            'Are you sure you want to kill all sessions for this connection?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Kill'),
            onPressed: () async {
              Navigator.pop(context); // Close the confirmation dialog
              setState(() => _isLoading = true);
              var headers = {'Content-Type': 'application/json'};
              var request = http.Request(
                'PATCH',
                Uri.parse(
                  '${widget.uri}/api/session/data/${widget.datasource}/activeConnections?token=${widget.authToken}',
                ),
              );
              request.body = json.encode([
                {"op": "remove", "path": "/{{activeConnectionSession}}"}
              ]);
              request.headers.addAll(headers);
              final response = await request.send();
              setState(() => _isLoading = false);
              if (response.statusCode == 204) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Session Kill Success'),
                    content: const Text(
                        'All sessions have been successfully killed.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                print(response.reasonPhrase);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        bottom: _isLoading
            ? const PreferredSize(
                child: LinearProgressIndicator(
                  color: Colors.black,
                ),
                preferredSize: Size.fromHeight(4.0),
              )
            : null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hostname: ${_data['hostname'] ?? ''}'),
            Text('Ignore Cert: ${_data['ignore-cert'] ?? ''}'),
            Text('Port: ${_data['port'] ?? ''}'),
            Text('Disable Auth: ${_data['disable-auth'] ?? ''}'),
            Text('Username: ${_data['username'] ?? ''}'),
            ElevatedButton(
              onPressed: () async {
                await _deleteConnection(context);
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Delete Connection'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _killSession(context);
              },
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : const Text('Kill Session'),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: _history.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const DrawerHeader(
                child: Text('Connection History'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              );
            }
            final historyItem = _history[index - 1];
            return ListTile(
              title: Text(
                  'From: ${DateTime.fromMillisecondsSinceEpoch(historyItem['startDate'])} To: ${DateTime.fromMillisecondsSinceEpoch(historyItem['endDate'])}'),
              subtitle: Text('Host: ${historyItem['remoteHost']}'),
            );
          },
        ),
      ),
    );
  }
}
