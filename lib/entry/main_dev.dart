import 'package:flutter/material.dart';
import 'package:zen8app/app/root/app.dart';
import 'package:zen8app/core/configs/env.dart';

void main() async {
  await Env.loadDevConfigs();
  runApp(const Zen8app());
}
