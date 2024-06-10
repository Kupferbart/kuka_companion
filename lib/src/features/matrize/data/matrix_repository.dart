import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'matirx_model.dart';


class MatrixRepository {
  //Websocket Channel for communication
  final WebSocketChannel channel;

  //Konstruktor
  MatrixRepository({required this.channel});

  //wandle Datenstrom zu MatrixModel um
  Stream<MatrixModel> getMatrixStatusStream() {
    return channel.stream.map((data) {
      debugPrint('Empfangene Daten: $data');
      try {
        if (data is String && data.isNotEmpty) {
          final jsonData = jsonDecode(data);
          debugPrint('Dekodierte Daten: $jsonData');
          if (jsonData.containsKey('componentsFilled') && jsonData['componentsFilled'] is List<bool>) {
            return MatrixModel.fromJson(jsonData);
          } else {
            throw Exception('Ungültiges JSON-Format für MatrixModel');
          }
        } else {
          throw Exception('Ungültiges Datenformat: $data');
        }
      } catch (e) {
        debugPrint('Fehler beim Verarbeiten der JSON-Daten: $e');
        return MatrixModel(componentsFilled: List.filled(5, false));
      }
    });
  }

  //wandle Datenstrom zu MatrixModel um
  Stream getMatrixStream() {
    return channel.stream;
  }

}

