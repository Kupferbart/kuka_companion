import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/companion/presentation/companion_page.dart';
import '../features/user_management/presentation/login_page.dart';

part 'routes.g.dart';

@TypedGoRoute<CompanionRoute>(path: '/')
class CompanionRoute extends GoRouteData {
  const CompanionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CompanionPage();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}
