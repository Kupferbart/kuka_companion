import 'package:equatable/equatable.dart';

class MatrixModel extends Equatable {
  final List<bool> componentsFilled;

  //sicherstellen, dass bei Erstellung eines MatrixModels eine bool Liste verwendet wird
  const MatrixModel({required this.componentsFilled});

  //gebraucht, um durch equatable zu bestimmen, dass zwei Instanzen gleich sind
  @override
  List<Object> get props => [componentsFilled];

  //Factory Konstruktor, um aus eine MatrixModel Instanz aus der JSON zu generieren (auslesen der Daten der Matritze)
  factory MatrixModel.fromJson(Map<String, dynamic> json) {
    return MatrixModel(
        componentsFilled:  List<bool>.from(json['componentsFilled'])  //Extrahiere Wert von "componentsFilled" der JSON, um neue Instanz von MatrixModel zu erstellen
    );
  }

  //Konvertiert ein MatrixModel zu einem JSON Objekt (senden an X)
  Map<String, dynamic> toJson() {
    return {
      'componentsFilled': componentsFilled
    };
  }
}
