import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/matrix/application/animation_service.dart';
import 'package:kuka_companion/src/features/robot/data/robot_repository.dart';
import 'package:kuka_companion/src/features/workflow/application/workflow_service.dart';
import 'package:rive/rive.dart';

import '../../../matrix/data/matrix_repo.dart';
import '../../../matrix/data/matrix_repository.dart';
import '../../../matrizeState/matrize_state_notifier.dart';

class AnimationContainer extends ConsumerStatefulWidget {
  AnimationContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimationContainerState();
}

class _AnimationContainerState extends ConsumerState<AnimationContainer> {
  SMITrigger? _pushButtonLeft;
  SMITrigger? _pushButtonRight;

  @override
  Widget build(BuildContext context) {
    final animationState = ref.watch(animationStateProvider);

    switch (animationState) {
      case AnimState.rosettenRunning || AnimState.rosettenFinished:
        _pushButtonLeft?.fire();
      case AnimState.gewindeRunning || AnimState.gewindeFinished:
        _pushButtonRight?.fire();
      default:
        () {};
    }

    return Center(
      //child: SimpleStateMachine(),
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: RiveAnimation.asset(
                'assets/square_guy_team_17_06.riv',
                onInit: _onRiveInit,
              ),
            ),
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'Current Statemachine');
    artboard.addController(controller!);
    _pushButtonLeft =
        controller.findInput<bool>('pushButtonLeft') as SMITrigger;
    _pushButtonRight =
        controller.findInput<bool>('pushButtonRight') as SMITrigger;
  }

  void startAnimationToLeft() {
    _pushButtonLeft?.fire();
  }

  void startAnimationToRight() {
    _pushButtonRight?.fire();
  }
}

class SimpleStateMachine extends ConsumerStatefulWidget {
  const SimpleStateMachine({super.key});

  @override
  ConsumerState<SimpleStateMachine> createState() => _SimpleStateMachineState();
}

class _SimpleStateMachineState extends ConsumerState<SimpleStateMachine> {
  SMITrigger? _pushButtonLeft;
  SMITrigger? _pushButtonRight;
  bool _leftButtonEnabled = true;
  bool _rightButtonEnabled = true;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'Current Statemachine');
    artboard.addController(controller!);
    _pushButtonLeft =
        controller.findInput<bool>('pushButtonLeft') as SMITrigger;
    _pushButtonRight =
        controller.findInput<bool>('pushButtonRight') as SMITrigger;
  }

  void _hitPushButtonLeft(WidgetRef ref, String matrixId) {
    final repository = ref.watch(matrixRepositoryProvider);
    if (_leftButtonEnabled) {
      _pushButtonLeft?.fire();
      final matrixState = ref.watch(matrixStateProvider);
      if (matrixState[matrixId] == MatrixState.filled) {
        ref
            .read(matrixStateProvider.notifier)
            .updateState(matrixId, MatrixState.waitRosettenPacked);
        debugPrint("Roboter: Lass die Rosetten laufen");
        repository.sendJson({
          'matrixId': 'matrixA',
          'rosette_A': true,
          'rosette_B': true,
          'gewinde_A': true,
          'gewinde_B': true,
          'box': true,
          'status': "run_rosetten"
        });
      } else if (matrixState[matrixId] == MatrixState.waitPappePacked) {
        ref
            .read(matrixStateProvider.notifier)
            .updateState(matrixId, MatrixState.waitGewindePacked);
        debugPrint("Roboter: Lass die Gewinde laufen");
        repository.sendJson({
          'matrixId': 'matrixA',
          'rosette_A': true,
          'rosette_B': true,
          'gewinde_A': true,
          'gewinde_B': true,
          'box': true,
          'status': "run_gewinde"
        });
      } else if (matrixState[matrixId] == MatrixState.allPacked) {
        ref
            .read(matrixStateProvider.notifier)
            .updateState(matrixId, MatrixState.finished);
      }
    }
  }

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

  void _startButtonTimer(VoidCallback onTimerEnd) {
    Timer(const Duration(seconds: 4), onTimerEnd);
  }

  @override
  Widget build(BuildContext context) {
    final matrixAsync = ref.watch(matrixStreamProvider);
    final robotAsync = ref.watch(robotStreamProvider);
    final workflowState = ref.watch(workflowStateHolderProvider);

    if (matrixAsync.hasValue && robotAsync.hasValue) {
      final matrix = matrixAsync.value!;
      final robot = robotAsync.value!;
    }

    /*return Consumer(builder: (context, ref, child) {
      final matrixState = ref.watch(matrixStateProvider);

      //überprüfen des Status der Matrix
      final bool isMatrixAReady = matrixState['matrixA'] == MatrixState.filled;
      final bool rosettenPacked = matrixState['matrixA'] == MatrixState.rosettenPacked;
      final bool isPappeReady = matrixState['matrixA'] == MatrixState.waitPappePacked;

      if(rosettenPacked){
        _hitPushButtonLeft(ref, 'matrixA');
      }

      final ElevatedButton leftButton = ElevatedButton(
        onPressed: isMatrixAReady|| isPappeReady ? () {
          if(isMatrixAReady && _leftButtonEnabled ) {
            _hitPushButtonLeft(ref, 'matrixA');
          }
          else{
              null;
          }
        }: null,
        child: const Text('Links freigeben'),
      );

      final ElevatedButton rightButton = ElevatedButton(
        onPressed: _rightButtonEnabled ? _hitPushButtonRight : null,
        child: const Text('Rechts freigeben'),
      );*/

    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: RiveAnimation.asset(
              'assets/square_guy_team_17_06.riv',
              onInit: _onRiveInit,
            ),
          ),
        ),
        const SizedBox(height: 32)
      ],
    );
    //});
  }
}
