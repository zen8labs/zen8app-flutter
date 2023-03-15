import 'package:flutter/material.dart';
import 'package:zen8app/lib.dart';
import 'package:zen8app/app/pages/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const env = String.fromEnvironment('ENV');
  switch (env) {
    case "dev":
      Session.initialize(Env.dev);
      break;
    case "stg":
      Session.initialize(Env.stg);
      break;
    case "prod":
      Session.initialize(Env.prod);
      break;
    default:
      return;
  }

  runApp(const Zen8app());
}
