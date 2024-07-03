import 'package:equatable/equatable.dart';
import 'package:kuka_companion/src/features/matrizeState/matrize_state_notifier.dart';

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
      isRossetteA: json['rosette_A'] as bool,
      isRossetteB: json['rosette_B'] as bool,
      isGewindeA: json['gewinde_A'] as bool,
      isGewindeB: json['gewinde_B'] as bool,
      isKarton: json['box'] as bool,
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
