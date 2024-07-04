import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:websocket_universal/websocket_universal.dart';

import '../../../environment/environment_configuration.dart';

part 'websocket_repository.g.dart';

@riverpod
WebSocketRepository webSocketRepository(WebSocketRepositoryRef ref) => WebSocketRepository(ref);

class WebSocketRepository {
  final IWebSocketHandler<String, String> _handler;

  WebSocketRepository(WebSocketRepositoryRef ref) : _handler = _createHandler(ref);

  static IWebSocketHandler<String, String> _createHandler(
      WebSocketRepositoryRef ref) {
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

    if (matrixRepositoryConfiguration.logOutgoingMessages) {
      textSocketHandler.outgoingMessagesStream.listen((inMsg) {
        print('> webSocket sent text message to server: "$inMsg"'
            '[ping: ${textSocketHandler.pingDelayMs}]');
      });
    }

    // if (matrixRepositoryConfiguration.logIncomingMessages) {
    //   textSocketHandler.incomingMessagesStream.listen((inMsg) {
    //     print('> webSocket got text message from server: "$inMsg" '
    //         '[ping: ${textSocketHandler.pingDelayMs}]');
    //   });
    // }

    return textSocketHandler;
  }

  Stream<String> watchWebSocketStream() =>
      _handler.incomingMessagesStream.asBroadcastStream();

  void sendMessage(String message) {
    _handler.sendMessage(message);
  }
}