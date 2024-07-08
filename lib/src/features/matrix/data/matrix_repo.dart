import 'dart:convert';

import 'package:kuka_companion/src/environment/environment_configuration.dart';
import 'package:kuka_companion/src/features/websocket/data/websocket_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:websocket_universal/websocket_universal.dart';

import '../domain/matrix.dart';

part 'matrix_repo.g.dart';

@riverpod
MatrixRepo matrixRepo(MatrixRepoRef ref) => MatrixRepo(ref);

@riverpod
Stream<Matrix> matrixStream(MatrixStreamRef ref) =>
    ref.watch(matrixRepoProvider).watchMatrixStream();

class MatrixRepo {
  // final IWebSocketHandler<String, String> _handler;
  //
  // MatrixRepo(MatrixRepoRef ref) : _handler = _createHandler(ref);
  //
  // static IWebSocketHandler<String, String> _createHandler(MatrixRepoRef ref) {
  //   final matrixRepositoryConfiguration =
  //       ref.watch(environmentConfigurationProvider).matrix.repository;
  //
  //   const connectionOptions = SocketConnectionOptions(
  //       pingIntervalMs: 3000,
  //       timeoutConnectionMs: 4000,
  //       skipPingMessages: false,
  //       pingRestrictionForce: true);
  //
  //   final IMessageProcessor<String, String> textSocketProcessor =
  //       SocketSimpleTextProcessor();
  //
  //   final IWebSocketHandler<String, String> textSocketHandler =
  //       IWebSocketHandler<String, String>.createClient(
  //     matrixRepositoryConfiguration.websocketUrl,
  //     textSocketProcessor,
  //     connectionOptions: connectionOptions,
  //   );
  //
  //   textSocketHandler.connect();
  //
  //   if (matrixRepositoryConfiguration.logOutgoingMessages) {
  //     textSocketHandler.outgoingMessagesStream.listen((inMsg) {
  //       print('> webSocket sent text message to server: "$inMsg"'
  //           '[ping: ${textSocketHandler.pingDelayMs}]');
  //     });
  //   }
  //
  //   if (matrixRepositoryConfiguration.logIncomingMessages) {
  //     textSocketHandler.incomingMessagesStream
  //
  //           .listen((inMsg) {
  //         print('> webSocket got text message from server: "$inMsg" '
  //             '[ping: ${textSocketHandler.pingDelayMs}]');
  //       });
  //   }
  //
  //   return textSocketHandler;
  // }
  //
  // Stream<Matrix> watchMatrixStream() => _handler.incomingMessagesStream
  //     .map((event) => Matrix.fromJson(jsonDecode(event)))
  //     .asBroadcastStream();
  //
  // // Stream<Matrix> watchMatrixStream() => _handler.incomingMessagesStream
  // //     .map((event) => jsonDecode(event) as Map<String, dynamic>)
  // //     .where((event) => event.keys.contains('rosette_A'))
  // //     .map((event) => Matrix.fromJson(event));
  //
  // void sendMatrixUpdate(Matrix matrix) {
  //   _handler.sendMessage(jsonEncode(matrix.toJson()));
  // }

  final WebSocketRepository _webSocketRepository;

  MatrixRepo(MatrixRepoRef ref)
      : _webSocketRepository = ref.watch(webSocketRepositoryProvider);

  Stream<Matrix> watchMatrixStream() =>
      _webSocketRepository.watchWebSocketStream().where(
        (event) {
          try {
            final json = jsonDecode(event) as Map<String, dynamic>;
            if (json.keys.contains('messageType') && json['messageType'] == 'matrix_status') {
              return true;
            }
            return false;
          } on FormatException catch (_) {
            return false;
          }
        },
      ).map((event) {
        final Map<String, dynamic> json = jsonDecode(event);
        return Matrix.fromJson(json['matrix']);
      });

  void sendMatrixUpdate(Matrix matrix) {
    final Map<String, dynamic> message = {
      'messageType': 'matrix_status',
      'matrix': matrix.toJson(),
    };
    _webSocketRepository.sendMessage(jsonEncode(message));
  }
}

// class MatrixRepo {
//   late WebSocketChannel _channel;
//   String url = 'wss://ws.postman-echo.com/raw';
//
//   MatrixRepo() {
//     _channel = initChannel();
//   }
//
//   void sendData(dynamic data) => _channel.sink.add(data);
//
//   initChannel() {
//     WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(url));
//     channel.stream.listen(
//       (event) => print(event),
//       onDone: () {
//         print('DONE: ${channel.closeCode} ${channel.closeReason}');
//       },
//     );
//
//     return channel;
//   }
// }

class UniversalWebsocketTest {
  static const String url = 'wss://ws.postman-echo.com/raw';

  // static const String url = 'wss://echo.websocket.events';

  final IWebSocketHandler<String, String> _handler;

  UniversalWebsocketTest() : _handler = _createHandler();

  static IWebSocketHandler<String, String> _createHandler() {
    const websocketConnectionUri = url;
    const textMessageToServer = 'Hello Server!';
    const connectionOptions = SocketConnectionOptions(
        pingIntervalMs: 3000,
        timeoutConnectionMs: 4000,
        skipPingMessages: false,
        pingRestrictionForce: true);

    final IMessageProcessor<String, String> textSocketProcessor =
        SocketSimpleTextProcessor();

    final IWebSocketHandler<String, String> textSocketHandler =
        IWebSocketHandler<String, String>.createClient(
      websocketConnectionUri,
      textSocketProcessor,
      connectionOptions: connectionOptions,
    );

    // textSocketHandler.socketHandlerStateStream.listen((stateEvent) {
    //   print('> status changed to ${stateEvent.status}');
    // });

    textSocketHandler.socketStateStream.listen((stateEvent) {
      print('> status changed to ${stateEvent.status}');
    });

    textSocketHandler.incomingMessagesStream.listen((inMsg) {
      print('> webSocket got text message from server: "$inMsg" '
          '[ping: ${textSocketHandler.pingDelayMs}]');
    });

    textSocketHandler.logEventStream.listen((debugEvent) {
      print('> debug event: ${debugEvent.socketLogEventType}'
          '[ping=${debugEvent.pingMs} ms]. Debug message=${debugEvent.message}');
    });

    textSocketHandler.outgoingMessagesStream.listen((inMsg) {
      print('> webSocket sent text message to server: "$inMsg"'
          '[ping: ${textSocketHandler.pingDelayMs}]');
    });

    return textSocketHandler;
  }

  void sendMessage(String message) {
    _handler.sendMessage(message);
    print('> Status: ${_handler.socketState.status}');
  }

  Future<void> connect() async {
    await _handler.connect();
  }

  Future<void> disconnect() async {
    await _handler.disconnect('manual disconnect');
  }

  Future<void> close() async {
    await disconnect();
    _handler.close();
  }

  Future<void> init() async {
    const websocketConnectionUri = 'wss://ws.postman-echo.com/raw';
    const textMessageToServer = 'Hello server!';
    const connectionOptions = SocketConnectionOptions(
      pingIntervalMs: 3000, // send Ping message every 3000 ms
      timeoutConnectionMs: 4000, // connection fail timeout after 4000 ms
      /// see ping/pong messages in [logEventStream] stream
      skipPingMessages: false,

      /// Set this attribute to `true` if do not need any ping/pong
      /// messages and ping measurement. Default is `false`
      pingRestrictionForce: false,
    );

    /// Example with simple text messages exchanges with server
    /// (not recommended for applications)
    /// [<String, String>] generic types mean that we receive [String] messages
    /// after deserialization and send [String] messages to server.
    final IMessageProcessor<String, String> textSocketProcessor =
        SocketSimpleTextProcessor();
    final textSocketHandler = IWebSocketHandler<String, String>.createClient(
      websocketConnectionUri, // Postman echo ws server
      textSocketProcessor,
      connectionOptions: connectionOptions,
    );

    // Listening to webSocket status changes
    textSocketHandler.socketHandlerStateStream.listen((stateEvent) {
      // ignore: avoid_print
      print('> status changed to ${stateEvent.status}');
    });

    // Listening to server responses:
    textSocketHandler.incomingMessagesStream.listen((inMsg) {
      // ignore: avoid_print
      print('> webSocket  got text message from server: "$inMsg" '
          '[ping: ${textSocketHandler.pingDelayMs}]');
    });

    // Listening to debug events inside webSocket
    textSocketHandler.logEventStream.listen((debugEvent) {
      // ignore: avoid_print
      print('> debug event: ${debugEvent.socketLogEventType}'
          ' [ping=${debugEvent.pingMs} ms]. Debug message=${debugEvent.message}');
    });

    // Listening to outgoing messages:
    textSocketHandler.outgoingMessagesStream.listen((inMsg) {
      // ignore: avoid_print
      print('> webSocket sent text message to   server: "$inMsg" '
          '[ping: ${textSocketHandler.pingDelayMs}]');
    });

    // Connecting to server:
    final isTextSocketConnected = await textSocketHandler.connect();
    if (!isTextSocketConnected) {
      // ignore: avoid_print
      print('Connection to [$websocketConnectionUri] failed for some reason!');
      return;
    }

    textSocketHandler.sendMessage(textMessageToServer);

    await Future<void>.delayed(const Duration(seconds: 5));
    // Disconnecting from server:
    await textSocketHandler.disconnect('manual disconnect');
    // Disposing webSocket:
    textSocketHandler.close();
  }
}
