import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/routing/app_router.dart';

class App extends ConsumerWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    final ColorScheme colorScheme =
        ColorScheme.fromSeed(seedColor: Colors.teal);

    final ThemeData theme = ThemeData(
      listTileTheme: ListTileThemeData(
        tileColor: colorScheme.surfaceContainerHigh,
        textColor: colorScheme.onSurface,
        selectedTileColor: colorScheme.secondaryContainer,
        selectedColor: colorScheme.onSecondaryContainer,
      ),
      colorScheme: colorScheme,
      useMaterial3: true,
    );

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: theme,
    );
  }
}
