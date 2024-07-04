import 'package:kuka_companion/src/features/matrix/domain/matrix_id.dart';

typedef Json = Map<String, dynamic>;

class Matrix {
  final MatrixID id;
  final bool rosetteA;
  final bool rosetteB;
  final bool gewindeA;
  final bool gewindeB;
  final bool box;

  bool get rosetten => rosetteA && rosetteB;

  bool get gewinde => gewindeA && gewindeB;

  bool get alleBauteile => rosetten && gewinde;

  bool get alles => alleBauteile && box;

  const Matrix({
    required this.id,
    required this.rosetteA,
    required this.rosetteB,
    required this.gewindeA,
    required this.gewindeB,
    required this.box,
  });

  const Matrix.dummy()
      : id = const MatrixID('matrixA'),
        rosetteA = false,
        rosetteB = false,
        gewindeA = false,
        gewindeB = false,
        box = false;

  Matrix copyWith({
    bool? rosetteA,
    bool? rosetteB,
    bool? gewindeA,
    bool? gewindeB,
    bool? box,
  }) =>
      Matrix(
        id: id,
        rosetteA: rosetteA ?? this.rosetteA,
        rosetteB: rosetteB ?? this.rosetteB,
        gewindeA: gewindeA ?? this.gewindeA,
        gewindeB: gewindeB ?? this.gewindeB,
        box: box ?? this.box,
      );

  factory Matrix.fromJson(Json json) {
    if (json
        case {
          'rosette_A': bool rosetteA,
          'rosette_B': bool rosetteB,
          'gewinde_A': bool gewindeA,
          'gewinde_B': bool gewindeB,
          'box': bool box,
        }) {
      return Matrix(
        id: MatrixID('a'),
        rosetteA: rosetteA,
        rosetteB: rosetteB,
        gewindeA: gewindeA,
        gewindeB: gewindeB,
        box: box,
      );
    }
    return const Matrix(
      id: MatrixID("a"),
      rosetteA: false,
      rosetteB: false,
      gewindeA: false,
      gewindeB: false,
      box: false,
    );
  }

  Json toJson() => {
        'rosette_A': rosetteA,
        'rosette_B': rosetteB,
        'gewinde_A': gewindeA,
        'gewinde_B': gewindeB,
        'box': box,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Matrix && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
