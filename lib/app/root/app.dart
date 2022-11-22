import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:zen8app/core/theme/theme.dart';
import 'package:zen8app/app/pages/main/home/home_page.dart';

class Zen8app extends StatelessWidget {
  const Zen8app({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: GetMaterialApp(
        title: "Flutter demo",
        theme: defaultTheme(),
        home: const HomePage(),
      ),
    );
  }
}
