import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:zen8app/app/pages/auth/login/login_page.dart';
import 'package:zen8app/app/pages/main/home_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: LoginPage),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
