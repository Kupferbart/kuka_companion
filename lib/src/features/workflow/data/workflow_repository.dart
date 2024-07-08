import 'package:kuka_companion/src/features/workflow/data/workflow_state_machine.dart';
import 'package:kuka_companion/src/features/workflow/domain/workflow_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../matrix/domain/matrix.dart';

part 'workflow_repository.g.dart';

@riverpod
WorkflowRepository workflowRepository(WorkflowRepositoryRef ref) =>
    WorkflowRepository();

class WorkflowRepository {
  // final WorkflowStateMachine _stateMachine;

  // WorkflowRepository() : _stateMachine = WorkflowStateMachine.init();

  // WorkflowState get currentState => _stateMachine.currentState;
  //
  // void transition(Matrix matrix) => _stateMachine.transition(matrix);
}
