final class MatrixID {
  final String value;

  const MatrixID(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatrixID &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}