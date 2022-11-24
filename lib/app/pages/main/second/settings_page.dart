import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print("detail");
            },
            child: Text("Detail"),
          ),
        ],
      ),
    );
  }
}
