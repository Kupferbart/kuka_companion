class UserFirstName {
  final String value;

  const UserFirstName(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserFirstName &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
