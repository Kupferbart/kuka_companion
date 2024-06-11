import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../data/matirx_model.dart';
import '../data/matrix_repository.dart';

class MatrizePage extends StatelessWidget {
  const MatrizePage({super.key});

  @override
  Widget build(BuildContext context) {
    final WebSocketChannel channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.events'),
    );
    final MatrixRepository repository = MatrixRepository(channel: channel);

    return StreamBuilder<MatrixModel>(
      stream: repository.getMatrixStatusStream(),
      builder: (BuildContext context, AsyncSnapshot<MatrixModel> snapshot) {
        if (snapshot.hasData) {
          // Daten wurden empfangen
          return Text(snapshot.data.toString());
        } else if (snapshot.hasError) {
          // Fehler beim Empfangen der Daten
          debugPrint('Fehler beim Laden der Daten: ${snapshot.error}');
          return Text('Fehler beim Laden der Daten: ${snapshot.error}');
        } else {
          // Daten werden noch geladen
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
