import '../../matrix/domain/matrix.dart';

sealed class WorkflowState {
  bool isReady(Matrix matrix);
}

final class FillMatrixState extends WorkflowState {
  @override
  bool isReady(Matrix matrix) => matrix.alles;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FillMatrixState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

final class RobotRosettenState extends WorkflowState {
  @override
  bool isReady(Matrix matrix) =>
      !matrix.rosetten && matrix.gewinde && matrix.box;
}

final class PappeState extends WorkflowState {
  @override
  bool isReady(Matrix matrix) =>
      !matrix.rosetten && matrix.gewinde && matrix.box;
}

final class RobotGewindeState extends WorkflowState {
  @override
  bool isReady(Matrix matrix) => !matrix.alleBauteile && matrix.box;
}

final class BoxState extends WorkflowState {
  @override
  bool isReady(Matrix matrix) => !matrix.alles;
}
