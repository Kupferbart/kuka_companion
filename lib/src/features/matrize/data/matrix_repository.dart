import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../../matrizeState/matritze_model_notifier.dart';
import '../../matrizeState/matrize_state_notifier.dart';

class MatrixRepository {
  final WebSocketChannel channel;
  final Ref ref;

  MatrixRepository({required this.channel, required this.ref}) {
    channel.stream.listen((data) {
      if (data is String && data.isNotEmpty) {
        debugPrint("Data from repo:$data");
        final jsonData = jsonDecode(data);
        final matrixId = jsonData['matrixId'];
        final status = jsonData['status'];

        if (matrixId != null && (matrixId == 'matrixA' || matrixId == 'matrixB')) {
          debugPrint("I am here");
          ref.read(matrixModelsProvider.notifier).updateFromJson(matrixId, jsonData);

          // Aktualisiere Status, anhand der Message des Servers
          switch (status) {
            case 'rosettenPacked':
              ref.read(matrixStateProvider.notifier).updateState(matrixId, MatrixState.rosettenPacked);
              break;
            case 'pappePacked':
              ref.read(matrixStateProvider.notifier).updateState(matrixId, MatrixState.pappePacked);
              break;
            case 'allPacked':
              ref.read(matrixStateProvider.notifier).updateState(matrixId, MatrixState.allPacked);
              break;
          }
        }
      }
    });
  }

  void sendJson(Map<String, dynamic> json) {
    final jsonString = jsonEncode(json);
    channel.sink.add(jsonString);
  }
}

// final matrixRepositoryProvider = Provider<MatrixRepository>((ref) {
//   final channel = WebSocketChannel.connect(
//         //Uri.parse('ws://10.42.0.1:8765')
//         Uri.parse('wss://echo.websocket.events')
//   );
//   return MatrixRepository(channel: channel, ref: ref);
// });
