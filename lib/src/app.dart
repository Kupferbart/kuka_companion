import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        //color: Colors.lightGreen,
        child: SimpleStateMachine(),
      ),
    );
  }
}

class SimpleStateMachine extends StatefulWidget {
  const SimpleStateMachine({Key? key}) : super(key: key);

  @override
  _SimpleStateMachineState createState() => _SimpleStateMachineState();
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