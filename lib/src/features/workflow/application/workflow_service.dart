import 'package:kuka_companion/src/features/matrix/data/matrix_repo.dart';
import 'package:kuka_companion/src/features/robot/data/robot_repository.dart';
import 'package:kuka_companion/src/features/workflow/domain/workflow_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../robot/domain/robot_state.dart';

part 'workflow_service.g.dart';

@riverpod
WorkflowService workflowService(WorkflowServiceRef ref) => WorkflowService(ref);

@riverpod
Future<bool> workFlowReadyState(WorkFlowReadyStateRef ref) =>
    ref.watch(workflowServiceProvider).isStateReady();



class WorkflowService {
  final WorkflowServiceRef ref;


  WorkflowService(this.ref);

  Future<WorkflowState> currentWorkflowState() {
    return Future<WorkflowState>.value(ref.read(workflowStateHolderProvider));
  }

  Future<bool> isStateReady() {
    final matrixAsync = ref.watch(matrixStreamProvider);
    final robotAsync = ref.watch(robotStreamProvider);

    if (matrixAsync.hasValue && robotAsync.hasValue) {
      final matrix = matrixAsync.value!;
      final robot = robotAsync.value!;

      return Future<bool>.value(
          ref.read(workflowStateHolderProvider).isReady(matrix) && robot.state == RobotState.ready);
    }

    return Future<bool>.value(false);
  }

  Future<void> enterNextState() async {
    if (await isStateReady()) {
      final nextState = switch (ref.read(workflowStateHolderProvider)) {
        FillMatrixState() => RobotRosettenState(),
        RobotRosettenState() => PappeState(),
        PappeState() => RobotGewindeState(),
        RobotGewindeState() => BoxState(),
        BoxState() => FillMatrixState(),
      };

      ref.read(workflowStateHolderProvider.notifier).setWorkflowState(nextState);
    }
  }
}

@riverpod
class WorkflowStateHolder extends _$WorkflowStateHolder {
  @override
  WorkflowState build() {
    return FillMatrixState();
  }

  void setWorkflowState(WorkflowState workflowState) {
    state = workflowState;
  }
}
