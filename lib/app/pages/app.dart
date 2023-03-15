import 'package:flutter/material.dart';
import 'package:zen8app/app/routes/router.dart';

class Zen8app extends StatefulWidget {
  const Zen8app({Key? key}) : super(key: key);

  @override
  State<Zen8app> createState() => _Zen8appState();
}

class _Zen8appState extends State<Zen8app> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp.router(
        title: "Flutter demo",
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
