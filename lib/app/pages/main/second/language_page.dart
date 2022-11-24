import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print("back");
            },
            child: Text("Detail"),
          ),
        ],
      ),
    );
  }
}
