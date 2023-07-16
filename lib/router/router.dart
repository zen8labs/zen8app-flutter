import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/models/models.dart';
import 'package:zen8app/app/pages/auth/login/login_page.dart';
import 'package:zen8app/app/pages/main/home/home_page.dart';
export 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (Session.isLoggedIn) {
      resolver.next(true);
    } else {
      router.push(LoginRoute());
    }
  }
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page, path: "/", guards: [AuthGuard()]),
    AutoRoute(page: LoginRoute.page),
  ];
}
