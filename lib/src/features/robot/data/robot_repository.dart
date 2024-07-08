import 'dart:convert';

import 'package:kuka_companion/src/features/robot/data/robot_command.dart';
import 'package:kuka_companion/src/features/websocket/data/websocket_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:websocket_universal/websocket_universal.dart';

import '../../../environment/environment_configuration.dart';
import '../domain/robot.dart';
import '../domain/robot_state.dart';

part 'robot_repository.g.dart';

@riverpod
RobotRepository robotRepository(RobotRepositoryRef ref) => RobotRepository(ref);

@riverpod
Stream<Robot> robotStream(RobotStreamRef ref) =>
    ref.watch(robotRepositoryProvider).watchRobotStatusStream();

class RobotRepository {
  final WebSocketRepository _webSocketRepository;

  RobotRepository(RobotRepositoryRef ref)
      : _webSocketRepository = ref.watch(webSocketRepositoryProvider) {
    final matrixRepositoryConfiguration =
        ref.watch(environmentConfigurationProvider).matrix.repository;

    // if (matrixRepositoryConfiguration.logOutgoingMessages) {
    //   textSocketHandler.outgoingMessagesStream.listen((inMsg) {
    //     print('> webSocket sent text message to server: "$inMsg"'
    //         '[ping: ${textSocketHandler.pingDelayMs}]');
    //   });
    // }
  }

  static IWebSocketHandler<String, String> _createHandler(
      RobotRepositoryRef ref) {
    final matrixRepositoryConfiguration =
        ref.watch(environmentConfigurationProvider).matrix.repository;

    const connectionOptions = SocketConnectionOptions(
        pingIntervalMs: 3000,
        timeoutConnectionMs: 4000,
        skipPingMessages: false,
        pingRestrictionForce: true);

    final IMessageProcessor<String, String> textSocketProcessor =
        SocketSimpleTextProcessor();

    final IWebSocketHandler<String, String> textSocketHandler =
        IWebSocketHandler<String, String>.createClient(
      matrixRepositoryConfiguration.websocketUrl,
      textSocketProcessor,
      connectionOptions: connectionOptions,
    );

    textSocketHandler.connect();

    // if (matrixRepositoryConfiguration.logOutgoingMessages) {
    //   textSocketHandler.outgoingMessagesStream.listen((inMsg) {
    //     print('> webSocket sent text message to server: "$inMsg"'
    //         '[ping: ${textSocketHandler.pingDelayMs}]');
    //   });
    // }

    // if (matrixRepositoryConfiguration.logIncomingMessages) {
    //   textSocketHandler.incomingMessagesStream.listen((inMsg) {
    //     print('> webSocket got text message from server: "$inMsg" '
    //         '[ping: ${textSocketHandler.pingDelayMs}]');
    //   });
    // }

    return textSocketHandler;
  }

  Stream<Robot> watchRobotStatusStream() =>
      _webSocketRepository.watchWebSocketStream().where(
        (event) {
          try {
            final json = jsonDecode(event) as Map<String, dynamic>;
            if (json.keys.contains('messageType') &&
                json['messageType'] == 'robot_status') {
              return true;
            }
            return false;
          } on FormatException catch (_) {
            return false;
          }
        },
      ).map((event) {
        final Map<String, dynamic> json = jsonDecode(event);
        return Robot.fromJson(json['robot']);
      });

  void sendRobotStatusUpdate(Robot robot) {
    final Map<String, dynamic> message = {
      'messageType': 'robot_status',
      'robot': robot.toJson(),
    };
    _webSocketRepository.sendMessage(jsonEncode(message));
  }

  void sendRobotCommand(RobotCommand command) {
    final json = {
      'messageType': 'robotCommand',
      'command': command.name,
    };

    _webSocketRepository.sendMessage(jsonEncode(json));
  }
}
