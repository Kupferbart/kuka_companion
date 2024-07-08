import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/robot/data/robot_repository.dart';
import 'package:kuka_companion/src/features/robot/domain/robot.dart';
import 'package:kuka_companion/src/features/robot/domain/robot_state.dart';

import '../../../features/robot/data/robot_command.dart';

class RobotControlPanel extends ConsumerWidget {
  const RobotControlPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final robotAsync = ref.watch(robotStreamProvider);

    Widget result;

    final sendRobotReadyStatusCommandButton = _CommandButton(
      () => ref
          .read(robotRepositoryProvider)
          .sendRobotStatusUpdate(const Robot(state: RobotState.ready)),
      'Robot ready',
    );

    final sendRobotRunningStatusCommandButton = _CommandButton(
          () => ref
          .read(robotRepositoryProvider)
          .sendRobotStatusUpdate(const Robot(state: RobotState.running)),
      'Robot running',
    );

    final sendRobotErrorStatusCommandButton = _CommandButton(
          () => ref
          .read(robotRepositoryProvider)
          .sendRobotStatusUpdate(const Robot(state: RobotState.error)),
      'Robot error',
    );



    final sendPackeRosettenCommandButton = _CommandButton(
      () => ref
          .read(robotRepositoryProvider)
          .sendRobotCommand(RobotCommand.packeRosetten),
      'Packe Rosetten',
    );

    final sendPackeGewindeCommandButton = _CommandButton(
      () => ref
          .read(robotRepositoryProvider)
          .sendRobotCommand(RobotCommand.packeGewinde),
      'Packe Gewinde',
    );

    final sendStopCommand = _CommandButton(
      () =>
          ref.read(robotRepositoryProvider).sendRobotCommand(RobotCommand.stop),
      'Stop',
    );

    final sendResumeCommandButton = _CommandButton(
      () => ref
          .read(robotRepositoryProvider)
          .sendRobotCommand(RobotCommand.resume),
      'Resume',
    );

    final sendResetCommandButton = _CommandButton(
      () => ref
          .read(robotRepositoryProvider)
          .sendRobotCommand(RobotCommand.reset),
      'Reset',
    );

    result = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Robot Control Panel',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 16),
        Text('RobotStatus: ${robotAsync.value?.state.name}'),
        const SizedBox(height: 8),
        sendRobotReadyStatusCommandButton,
        const SizedBox(height: 8),
        sendRobotRunningStatusCommandButton,
        const SizedBox(height: 8),
        sendRobotErrorStatusCommandButton,
        const SizedBox(height: 16),
        sendPackeRosettenCommandButton,
        const SizedBox(height: 8),
        sendPackeGewindeCommandButton,
        const SizedBox(height: 8),
        sendStopCommand,
        const SizedBox(height: 8),
        sendResumeCommandButton,
        const SizedBox(height: 8),
        sendResetCommandButton,
      ],
    );

    return result;
  }
}

class _CommandButton extends StatelessWidget {
  final Function() onPressed;
  final String label;

  const _CommandButton(
    this.onPressed,
    this.label,
  );

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      );
}
