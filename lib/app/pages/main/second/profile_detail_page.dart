import 'package:flutter/material.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("detail"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print("back");
            },
            child: Text("back"),
          ),
        ],
      ),
    );
  }
}
