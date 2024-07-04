import 'package:kuka_companion/src/features/robot/domain/robot_state.dart';

typedef Json = Map<String, dynamic>;

class Robot {
  final RobotState state;

  const Robot({required this.state});

  Robot copyWith({RobotState? state}) => Robot(
        state: state ?? this.state,
      );

  factory Robot.fromJson(Json json) {
    if (json case {'robotState': String robotState}) {
      return Robot(
        state: RobotState.values.byName(robotState),
      );
    }

    return const Robot(state: RobotState.error);
  }

  Json toJson() => {
        'robotState': state.name,
      };
}
