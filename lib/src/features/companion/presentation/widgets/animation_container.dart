import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimationContainer extends StatelessWidget {
  const AnimationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        elevation: 50,
        shadowColor:  Color.fromRGBO(0, 53,96, 1.0),
        surfaceTintColor: Color.fromRGBO(231, 231, 231, 1.0),
        color: Color.fromRGBO(231, 231, 231, 1.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
            child: SimpleStateMachine(),
          ),

      ),
    );
  }
}

class SimpleStateMachine extends StatefulWidget {
  const SimpleStateMachine({super.key});

  @override
  State<SimpleStateMachine> createState() => _SimpleStateMachineState();
}

class _SimpleStateMachineState extends State<SimpleStateMachine> {
  SMITrigger? _pushButtonLeft;
  SMITrigger? _pushButtonRight;
  bool _leftButtonEnabled = true;
  bool _rightButtonEnabled = true;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
        artboard, 'Current Statemachine Ben');
    artboard.addController(controller!);
    _pushButtonLeft =
    controller.findInput<bool>('pushButtonLeft') as SMITrigger;
    _pushButtonRight =
    controller.findInput<bool>('pushButtonRight') as SMITrigger;
  }

  //Funktion die nach klicken des linken Buttons auslöst
  void _hitPushButtonLeft() {
    if (_leftButtonEnabled) {
      _pushButtonLeft?.fire();
      _disableLeftButton();
      _startButtonTimer(_enableLeftButton);
    }
  }

  //Funktion die nach klicken des rechten Buttons auslöst
  void _hitPushButtonRight() {
    if (_rightButtonEnabled) {
      _pushButtonRight?.fire();
      _disableRightButton();
      _startButtonTimer(_enableRightButton);
    }
  }

  void _disableLeftButton() {
    setState(() {
      _leftButtonEnabled = false;
    });
  }

  void _disableRightButton() {
    setState(() {
      _rightButtonEnabled = false;
    });
  }

  void _enableLeftButton() {
    setState(() {
      _leftButtonEnabled = true;
    });
  }

  void _enableRightButton() {
    setState(() {
      _rightButtonEnabled = true;
    });
  }

  //Methode zum verzögerten Start der "onTimerEnd" Funktion
  void _startButtonTimer(VoidCallback onTimerEnd) {
    Timer(const Duration(seconds: 4), onTimerEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16), // Abstand zwischen Rand und Button
        ElevatedButton(
          onPressed: _leftButtonEnabled ? _hitPushButtonLeft : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 64), // Anpassen der Button-Größe
          ),
          child: const Text('Links freigeben'),
        ),
        Expanded(
          child: RiveAnimation.asset(
            'assets/square_guy_team.riv',
            onInit: _onRiveInit,
          ),
        ),
        ElevatedButton(
          onPressed: _rightButtonEnabled ? _hitPushButtonRight : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 64), // Anpassen der Button-Größe
          ),
          child: const Text('Rechts freigeben'),
        ),
        const SizedBox(width: 16), // Abstand zwischen Button und Rand
      ],
    );
  }
}
