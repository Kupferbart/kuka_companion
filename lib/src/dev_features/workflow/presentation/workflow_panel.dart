import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kuka_companion/src/features/workflow/application/workflow_service.dart';
import 'package:kuka_companion/src/features/workflow/data/workflow_repository.dart';

import '../../../features/workflow/domain/workflow_state.dart';

class WorkflowPanel extends ConsumerStatefulWidget {
  const WorkflowPanel({super.key});

  @override
  ConsumerState<WorkflowPanel> createState() => _WorkFlowPanelState();
}

class _WorkFlowPanelState extends ConsumerState<WorkflowPanel> {
  WorkflowState? _workflowState;

  @override
  Widget build(BuildContext context) {
    final currentWorkflow = ref.watch(workflowStateHolderProvider);
    final readyStateAsync = ref.watch(workFlowReadyStateProvider).value;

    Widget result;

    final workflowState = Text('Current State: $currentWorkflow');
    final workflowReadyState = Text('WorkflowState: $readyStateAsync');
    final enterNextStateButton = ElevatedButton(
      onPressed: readyStateAsync == true
          ? ref.read(workflowServiceProvider).enterNextState
          : null,
      child: Text('Enter Next State'),
    );

    result = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        workflowState,
        const Gap(8),
        workflowReadyState,
        const Gap(8),
        enterNextStateButton,
      ],
    );

    return result;
  }

  void _action() async {
    ref.read(workflowServiceProvider).enterNextState();
    final workflowstate = await ref.read(workflowServiceProvider).currentWorkflowState();
    setState(()  {
      _workflowState = workflowstate;

    });
  }
}
