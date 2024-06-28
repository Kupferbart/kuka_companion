import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../domain/matrix.dart';

part 'matrix_repo.g.dart';

@Riverpod(keepAlive: true)
MatrixRepo matrixRepository(MatrixRepositoryRef ref) => MockMatrixRepo(ref);

@Riverpod(keepAlive: true)
Stream<Matrix> matrix(MatrixRef ref) =>
    ref.watch(matrixRepositoryProvider).watchMatrix();

abstract class MatrixRepo {
  WebSocketChannel _channel;
  final String uri;

  MatrixRepo(MatrixRepositoryRef ref, this.uri)
      : _channel = WebSocketChannel.connect(Uri.parse(uri)) {
//     channel.stream.listen((data) {
//       if (data is String && data.isNotEmpty) {
//         debugPrint("Data from repo:$data");
//         final jsonData = jsonDecode(data);
//         final matrixId = jsonData['matrixId'];
//         final status = jsonData['status'];
//
//         if (matrixId != null &&
//             (matrixId == 'matrixA' || matrixId == 'matrixB')) {
//           debugPrint("I am here");
//           ref
//               .read(matrixModelsProvider.notifier)
//               .updateFromJson(matrixId, jsonData);
//
// // Aktualisiere Status, anhand der Message des Servers
//           switch (status) {
//             case 'rosettenPacked':
//               ref
//                   .read(matrixStateProvider.notifier)
//                   .updateState(matrixId, MatrixState.rosettenPacked);
//               break;
//             case 'pappePacked':
//               ref
//                   .read(matrixStateProvider.notifier)
//                   .updateState(matrixId, MatrixState.pappePacked);
//               break;
//             case 'allPacked':
//               ref
//                   .read(matrixStateProvider.notifier)
//                   .updateState(matrixId, MatrixState.allPacked);
//               break;
//           }
//         }
//       }
//     });
  }

  Stream<Matrix> watchMatrix() {
    // _channel.stream.listen((data) {
    //   Map<String, dynamic> json = jsonDecode(data);
    //   Matrix matrix = Matrix.fromJson(json);
    // },
    //   onDone: () => print('CONNECTION CLOSED'),
    // );

    return _channel.stream
        .map((matrixData) => Matrix.fromJson(jsonDecode(matrixData)));
  }

  Future<void> setMatrix(Matrix matrix) async {
    print('SET MATRIX');
    Map<String, dynamic> json = matrix.toJson();

    print(_channel.closeReason);
    _channel.sink.add(jsonEncode(json));
  }

  void sendJson(Map<String, dynamic> json) {
    final jsonString = jsonEncode(json);
    _channel.sink.add(jsonString);
  }
}

class WebSocketMatrixRepo extends MatrixRepo {
  WebSocketMatrixRepo(MatrixRepositoryRef ref)
      : super(ref, 'ws://10.42.0.1:8765');
}

class MockMatrixRepo extends MatrixRepo {
  MockMatrixRepo(MatrixRepositoryRef ref)
      : super(ref, 'wss://echo.websocket.events');
}
