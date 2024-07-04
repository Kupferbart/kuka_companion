import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kuka_companion/src/dev_features/matrix/presentation/matrix_control_panel.dart';
import 'package:kuka_companion/src/dev_features/robot/presentation/robot_control_panel.dart';
import 'package:kuka_companion/src/dev_features/workflow/presentation/workflow_panel.dart';
import 'package:kuka_companion/src/features/workflow/data/workflow_repository.dart';
import 'package:kuka_companion/src/features/workflow/presentation/workflow_test.dart';

class DevPanel extends StatelessWidget {
  const DevPanel({super.key});

  @override
  Widget build(BuildContext context) {
    Widget result;

    const matrixControlPanel = MatrixControlPanel();
    const robotControlPanel = RobotControlPanel();

    // result = const Column(
    //   children: [
    //     matrixControlPanel,
    //     const Gap(24),
    //     robotControlPanel,
    //   ],
    // );

    result = ListView(
      children: [
        matrixControlPanel,
        const Gap(24),
        robotControlPanel,
        const Gap(24),
        WorkflowPanel(),
      ],
    );

    result = Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: result,
    );

    return result;
  }
}
