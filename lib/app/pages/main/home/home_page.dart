import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:zen8app/app/pages/main/home/home_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeVM = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              StreamBuilder(
                stream: _homeVM.outToken,
                builder: (context, snapshot) {
                  var text = snapshot.data?.toString() ?? "!!!!";
                  return Text(text);
                },
              ),
              ElevatedButton(
                child: Text("Test"),
                onPressed: () async {
                  _homeVM.inLogin.add(null);
                },
              ),
              ElevatedButton(
                onPressed: (() {}),
                child: Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
