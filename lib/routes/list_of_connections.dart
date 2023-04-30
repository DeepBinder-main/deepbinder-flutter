import 'package:flutter/material.dart';

class ListOfConnections extends StatelessWidget {
  const ListOfConnections({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        width: 100,
        child: const Text("List of connections"),
      ),
    );
  }
}
