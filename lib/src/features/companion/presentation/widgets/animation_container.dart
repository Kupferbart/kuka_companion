import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimationContainer extends StatelessWidget {
  const AnimationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget result;

    result = const SimpleStateMachine();

    result = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: result,
    );

    result = AspectRatio(
      aspectRatio: 16 / 9,
      child: result,
    );

    result = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: result,
    );

    return result;
  }
}

class SimpleStateMachine extends StatefulWidget {
  const SimpleStateMachine({super.key});

  @override
  State<SimpleStateMachine> createState() => _SimpleStateMachineState();
}

class _SimpleStateMachineState extends State<SimpleStateMachine> {
  SMITrigger? _pushButtonLeft;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
        artboard, 'Current Statemachine Ben');
    artboard.addController(controller!);
    _pushButtonLeft =
        controller.findInput<bool>('pushButtonLeft') as SMITrigger;
  }

  void _hitPushButtonLeft() => _pushButtonLeft?.fire();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hitPushButtonLeft,
      child: RiveAnimation.asset(
        'assets/square_guy_team.riv',
        onInit: _onRiveInit,
      ),
    );
  }
}
