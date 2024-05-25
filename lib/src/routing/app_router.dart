import 'package:go_router/go_router.dart';
import 'package:kuka_companion/src/routing/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) => GoRouter(
      routes: $appRoutes,
      initialLocation: '/login',
    );
