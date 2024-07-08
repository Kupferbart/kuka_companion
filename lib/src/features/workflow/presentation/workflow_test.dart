import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/matrix/data/matrix_repo.dart';
import 'package:kuka_companion/src/features/workflow/data/workflow_repository.dart';

import '../../matrix/domain/matrix.dart';

class WorkflowTest extends ConsumerStatefulWidget {
  const WorkflowTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkflowTestState();
}

class _WorkflowTestState extends ConsumerState<WorkflowTest> {
  String _stateName = "";

  @override
  Widget build(BuildContext context) {
    final matrixAsync = ref.watch(matrixStreamProvider);

    final matrix =
        matrixAsync.hasValue ? matrixAsync.value! : const Matrix.dummy();

    Widget result;

    final label = Text(_stateName);
    // final ElevatedButton transitionButton = ElevatedButton(
    //     onPressed: () {
    //       ref.read(workflowRepositoryProvider).transition(matrix);
    //       setState(() {
    //         _stateName =
    //             ref.read(workflowRepositoryProvider).currentState.toString();
    //       });
    //     },
    //     child: const Text('TRANSITION'));

    result = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        label,
        // transitionButton,
      ],
    );

    return result;
  }
}
