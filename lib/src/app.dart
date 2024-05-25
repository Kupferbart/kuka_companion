import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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
      home: const SimpleStateMachine(),
    );
  }
}

class SimpleStateMachine extends StatefulWidget {
  const SimpleStateMachine({Key? key}) : super(key: key);

  @override
  State<SimpleStateMachine> createState() => _SimpleStateMachineState();
}

class _SimpleStateMachineState extends State<SimpleStateMachine> {
  SMITrigger? _pushButtonLeft;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Current Statemachine Ben');
    artboard.addController(controller!);
    _pushButtonLeft = controller.findInput<bool>('pushButtonLeft') as SMITrigger;
  }

  void _hitPushButtonLeft() => _pushButtonLeft?.fire();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Animation'),
      ),
      body: Center(
        child: GestureDetector(
          child: RiveAnimation.asset(
            'assets/square_guy_team.riv',
            onInit: _onRiveInit,
          ),
          onTap: _hitPushButtonLeft,
        ),
      ),
    );
  }
}