import 'package:flutter/material.dart';

class ExaminationPage extends StatelessWidget {
  const ExaminationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Examination"),
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
