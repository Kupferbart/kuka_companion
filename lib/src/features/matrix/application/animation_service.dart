
import 'package:kuka_companion/src/features/robot/data/robot_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../robot/domain/robot.dart';
import '../../robot/domain/robot_state.dart';

part 'animation_service.g.dart';

@riverpod
void setAnimState(SetAnimStateRef ref) {
  final robotAsync = ref.watch(robotStreamProvider);
  final robot = robotAsync.hasValue
      ? robotAsync.value!
      : const Robot(state: RobotState.error);

  final animState = ref.watch(animationStateProvider);

  if(robot.state == RobotState.ready) {
    if(animState == AnimState.rosettenRunning) {
      ref.read(animationStateProvider.notifier).changeState(AnimState.rosettenFinished);
    }
  }
}

@riverpod
class AnimationState extends _$AnimationState{
  @override
  AnimState build() => AnimState.ready;

  void changeState(AnimState state) => this.state = state;

  AnimState get animState => state;
}

enum AnimState {
  ready,
  rosettenRunning,
  rosettenFinished,
  gewindeRunning,
  gewindeFinished,
}