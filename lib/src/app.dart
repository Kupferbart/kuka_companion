import 'package:flutter/material.dart';

import 'features/user_management/presentation/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);

    return MaterialApp(
      theme: ThemeData(
        listTileTheme: ListTileThemeData(
          tileColor: colorScheme.surfaceContainerHigh,
          textColor: colorScheme.onSurface,
          selectedTileColor: colorScheme.secondaryContainer,
          selectedColor: colorScheme.onSecondaryContainer,
        ),
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
