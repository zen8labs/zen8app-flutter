import 'package:flutter/material.dart';
import 'package:zen8app/app/pages/main/second/profile_page.dart';
import 'package:zen8app/app/pages/main/second/settings_page.dart';
import 'package:zen8app/core/theme/theme.dart';
import 'package:zen8app/app/pages/main/home/home_page.dart';

class Zen8app extends StatefulWidget {
  const Zen8app({Key? key}) : super(key: key);

  @override
  State<Zen8app> createState() => _Zen8appState();
}

class _Zen8appState extends State<Zen8app> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        title: "Flutter demo",
        theme: defaultTheme(),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.home)),
                ],
              ),
            ),
            body: TabBarView(children: [
              HomePage(),
              ProfilePage(),
              SettingsPage(),
            ]),
          ),
        ),
      ),
    );
  }
}
