import 'package:flutter/material.dart';

class CreateGroup extends StatelessWidget {
  const CreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Create a new group"),
      children: [
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, "Create a new group");
          },
          child: const Text("Create a new group"),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, "Join a group");
          },
          child: const Text("Join a group"),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, "Cancel");
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}