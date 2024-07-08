import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/matrix/application/animation_service.dart';
import 'package:kuka_companion/src/features/matrix/data/matrix_repo.dart';
import 'package:kuka_companion/src/features/matrix/domain/matrix.dart';
import 'package:kuka_companion/src/features/matrix/domain/matrix_id.dart';
import 'package:kuka_companion/src/features/robot/data/robot_command.dart';
import 'package:kuka_companion/src/features/robot/data/robot_repository.dart';
import 'package:kuka_companion/src/features/robot/domain/robot.dart';
import 'package:kuka_companion/src/features/robot/domain/robot_state.dart';
import 'package:kuka_companion/src/features/workflow/application/workflow_service.dart';

import '../../workflow/domain/workflow_state.dart';

class MatrixStepper extends ConsumerStatefulWidget {
  const MatrixStepper({super.key});

  @override
  ConsumerState<MatrixStepper> createState() => _MatrixStepperState();
}

class _MatrixStepperState extends ConsumerState<MatrixStepper> {
  bool _awaitRobotRunningStatus = false;

  @override
  Widget build(BuildContext context) {
    WorkflowState _currentWorkflowState =
        ref.watch(workflowStateHolderProvider);

    final matrixAsync = ref.watch(matrixStreamProvider);
    final matrix = matrixAsync.hasValue
        ? matrixAsync.value!
        : const Matrix(
            id: MatrixID('matrixA'),
            rosetteA: false,
            rosetteB: false,
            gewindeA: false,
            gewindeB: false,
            box: false,
          );
    final robotAsync = ref.watch(robotStreamProvider);
    final robot = robotAsync.hasValue
        ? robotAsync.value!
        : const Robot(state: RobotState.error);

    if(_awaitRobotRunningStatus && robot.state == RobotState.running){
      setState(() {_awaitRobotRunningStatus = false;});
    }

    if(_currentWorkflowState.runtimeType == RobotRosettenState && robot.state == RobotState.ready && _awaitRobotRunningStatus == false) {
      Future(() async {
        if(ref.read(animationStateProvider) == AnimState.rosettenRunning && robot.state == RobotState.ready) {
          ref.read(animationStateProvider.notifier).changeState(AnimState.rosettenFinished);
        }
      });
    }

    if(_currentWorkflowState.runtimeType == RobotGewindeState && robot.state == RobotState.ready && _awaitRobotRunningStatus == false) {
      Future(() async {
        if(ref.read(animationStateProvider) == AnimState.gewindeRunning && robot.state == RobotState.ready) {
          ref.read(animationStateProvider.notifier).changeState(AnimState.gewindeFinished);
        }
      });
    }

    /*if (robot.state == RobotState.ready) {
      final animState = ref.read(animationStateProvider.notifier).animState;

      switch (animState) {
        case AnimState.rosettenRunning:
          ref
              .read(animationStateProvider.notifier)
              .changeState(AnimState.rosettenFinished);
        case AnimState.gewindeRunning:
          ref
              .read(animationStateProvider.notifier)
              .changeState(AnimState.gewindeFinished);
        default:
          () {};
      }
    }*/

    //final animState = ref.watch(animationStateProvider);

    //resetAnimationLeft(animState, robot.state);

    /*Future(() async {
      await Future.delayed(Duration(seconds: 3));
      //final animState = ref.watch(animationStateProvider);
      if(ref.read(animationStateProvider) == AnimState.rosettenRunning && robot.state == RobotState.ready) {
        ref.read(animationStateProvider.notifier).changeState(AnimState.rosettenFinished);
      }
    });*/


    /*if(animState == AnimState.rosettenRunning && robot.state == RobotState.ready) {
      ref.read(animationStateProvider.notifier).changeState(AnimState.rosettenFinished);
    }

    if(animState == AnimState.gewindeRunning && robot.state == RobotState.ready) {
      ref.read(animationStateProvider.notifier).changeState(AnimState.gewindeFinished);
    }*/

    final List<Step> stepList = List.empty(growable: true);

    final Step fillMatrixStep = Step(
        title: const Text('Matrix befüllen'),
        content: const Text(
            'Setze bitte beide Rosetten, Gewinde und die Box in die Matrize!'),
        isActive: _mapWorkflowStateToInt(_currentWorkflowState) >= 0,
        state: _mapWorkflowStateToInt(_currentWorkflowState) > 0
            ? StepState.complete
            : StepState.indexed);

    final Step robotRosettenStep = Step(
        title: const Text('Rosetten verpacken'),
        content: const Text(
            'Bitte warte, bis der Roboter die Rosetten verpackt hat!'),
        isActive: _mapWorkflowStateToInt(_currentWorkflowState) >= 1,
        state: _mapWorkflowStateToInt(_currentWorkflowState) > 1
            ? StepState.complete
            : StepState.indexed);

    final Step pappeEinlegenStep = Step(
        title: const Text('Pappe einlegen'),
        content: const Text('Bitte lege die Pappe in die Box!'),
        isActive: _mapWorkflowStateToInt(_currentWorkflowState) >= 2,
        state: _mapWorkflowStateToInt(_currentWorkflowState) > 2
            ? StepState.complete
            : StepState.indexed);

    final Step robotGewindeStep = Step(
        title: const Text('Gewinde verpacken'),
        content: const Text(
            'Bitte warten, bis der Roboter die Gewinde verpackt hat'),
        isActive: _mapWorkflowStateToInt(_currentWorkflowState) >= 3,
        state: _mapWorkflowStateToInt(_currentWorkflowState) > 3
            ? StepState.complete
            : StepState.indexed);

    final Step boxStep = Step(
        title: const Text('Box entnehmen'),
        content:
            const Text('Bitte die Box entnehmen. Du hast es dann geschafft :)'),
        isActive: _mapWorkflowStateToInt(_currentWorkflowState) >= 4,
        state: _mapWorkflowStateToInt(_currentWorkflowState) > 0
            ? StepState.complete
            : StepState.indexed);

    stepList.add(fillMatrixStep);
    stepList.add(robotRosettenStep);
    stepList.add(pappeEinlegenStep);
    stepList.add(robotGewindeStep);
    stepList.add(boxStep);

    return Stepper(
      currentStep: _mapWorkflowStateToInt(_currentWorkflowState),
      steps: stepList,
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        Widget result;

        result = switch (details.currentStep) {
          0 => ElevatedButton(
              onPressed: (_currentWorkflowState.isReady(matrix) &&
                      robot.state == RobotState.ready)
                  ? _startRobotRosetten
                  : null,
              child: const Text('Weiter'),
            ),
          1 => ElevatedButton(
              onPressed: (_currentWorkflowState.isReady(matrix) &&
                      robot.state == RobotState.ready)
                  ? ref.read(workflowServiceProvider).enterNextState
                  : null,
              child: const Text('Weiter'),
            ),
          2 => ElevatedButton(
              onPressed: (_currentWorkflowState.isReady(matrix) &&
                      robot.state == RobotState.ready)
                  ? _startRobotGewinde
                  : null,
              child: const Text('Weiter'),
            ),
          3 => ElevatedButton(
              onPressed: (_currentWorkflowState.isReady(matrix) &&
                      robot.state == RobotState.ready)
                  ? ref.read(workflowServiceProvider).enterNextState
                  : null,
              child: const Text('Weiter'),
            ),
          4 => ElevatedButton(
              onPressed: (_currentWorkflowState.isReady(matrix) &&
                      robot.state == RobotState.ready)
                  ? ref.read(workflowServiceProvider).enterNextState
                  : null,
              child: const Text('Weiter'),
            ),
          _ => Container(),
        };

        result = Align(
          alignment: Alignment.center,
          child: result,
        );

        result = Padding(
          padding: const EdgeInsets.only(top: 16),
          child: result,
        );

        return result;
      },
    );
  }

  int _mapWorkflowStateToInt(WorkflowState workflowState) =>
      switch (workflowState) {
        FillMatrixState() => 0,
        RobotRosettenState() => 1,
        PappeState() => 2,
        RobotGewindeState() => 3,
        BoxState() => 4,
      };

  void _startRobotRosetten() {
    debugPrint("startRobotRosetten");
    ref.read(workflowServiceProvider).enterNextState();
    ref
        .read(robotRepositoryProvider)
        .sendRobotCommand(RobotCommand.packeRosetten);
    ref
        .read(animationStateProvider.notifier)
        .changeState(AnimState.rosettenRunning);
    setState((){_awaitRobotRunningStatus = true;});
  }

  void _startRobotGewinde() {
    debugPrint("startRobotGewinde");
    ref.read(workflowServiceProvider).enterNextState();
    ref
        .read(robotRepositoryProvider)
        .sendRobotCommand(RobotCommand.packeGewinde);
    ref
        .read(animationStateProvider.notifier)
        .changeState(AnimState.gewindeRunning);
    setState((){_awaitRobotRunningStatus = true;});
  }
}
