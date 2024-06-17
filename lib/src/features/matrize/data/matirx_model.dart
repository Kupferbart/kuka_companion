import 'package:equatable/equatable.dart';

class MatrixModel extends Equatable {
  //final List<bool> componentsFilled;
  final String matrixId;
  final bool isRossetteA;
  final bool isRossetteB;
  final bool isGewindeA;
  final bool isGewindeB;
  final bool isKarton;

  //sicherstellen, dass bei Erstellung eines MatrixModels eine bool Liste verwendet wird
  const MatrixModel({
    required this.matrixId,
    required this.isRossetteA,
    required this.isRossetteB,
    required this.isGewindeA,
    required this.isGewindeB,
    required this.isKarton,
  });
  //gebraucht, um durch equatable zu bestimmen, dass zwei Instanzen gleich sind
  @override
  List<Object> get props => [isRossetteA, isRossetteB, isGewindeA, isGewindeB, isKarton];

  //Factory Konstruktor, um aus eine MatrixModel Instanz aus der JSON zu generieren (auslesen der Daten der Matritze)
  factory MatrixModel.fromJson(Map<String, dynamic> json) {
    return MatrixModel(
      matrixId: json['matrixId'],
      isRossetteA: json['isRossetteA'] as bool,
      isRossetteB: json['isRossetteB'] as bool,
      isGewindeA: json['isGewindeA'] as bool,
      isGewindeB: json['isGewindeB'] as bool,
      isKarton: json['isKarton'] as bool,
    );
  }

  //Konvertiert ein MatrixModel zu einem Map
  Map<String, dynamic> toJson() {
    return {
      'matrixId': matrixId,
      'isRossetteA': isRossetteA,
      'isRossetteB': isRossetteB,
      'isGewindeA': isGewindeA,
      'isGewindeB': isGewindeB,
      'isKarton': isKarton,
    };
  }



  bool get isFilled => isRossetteA && isRossetteB && isGewindeA && isGewindeB && isKarton;
}
