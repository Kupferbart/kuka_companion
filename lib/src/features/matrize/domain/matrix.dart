final class Matrix {
  final bool gewindeA;
  final bool gewindeB;
  final bool rosetteA;
  final bool rosetteB;
  final bool karton;

  const Matrix({
    required this.gewindeA,
    required this.gewindeB,
    required this.rosetteA,
    required this.rosetteB,
    required this.karton,
  });

  Matrix copyWith({
    bool? gewindeA,
    bool? gewindeB,
    bool? rosetteA,
    bool? rosetteB,
    bool? karton,
  }) =>
      Matrix(
        gewindeA: gewindeA ?? this.gewindeA,
        gewindeB: gewindeB ?? this.gewindeB,
        rosetteA: rosetteA ?? this.rosetteA,
        rosetteB: rosetteB ?? this.rosetteB,
        karton: karton ?? this.karton,
      );

  factory Matrix.fromJson(Map<String, dynamic> data) {
    if (data
        case {
          'rosetteA': bool rosetteA,
          'rosetteB': bool rosetteB,
          'gewindeA': bool gewindeA,
          'gewindeB': bool gewindeB,
          'karton': bool karton,
        }) {
      return Matrix(
        rosetteA: rosetteA,
        rosetteB: rosetteB,
        gewindeA: gewindeA,
        gewindeB: gewindeB,
        karton: karton,
      );
    } else {
      throw FormatException('Invalid JSON: $data');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'rosetteA': rosetteA,
      'rosetteB': rosetteB,
      'gewindeA': gewindeA,
      'gewindeB': gewindeB,
      'karton': karton,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Matrix &&
          runtimeType == other.runtimeType &&
          gewindeA == other.gewindeA &&
          gewindeB == other.gewindeB &&
          rosetteA == other.rosetteA &&
          rosetteB == other.rosetteB &&
          karton == other.karton;

  @override
  int get hashCode =>
      gewindeA.hashCode ^
      gewindeB.hashCode ^
      rosetteA.hashCode ^
      rosetteB.hashCode ^
      karton.hashCode;
}
