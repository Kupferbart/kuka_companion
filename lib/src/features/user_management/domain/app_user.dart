import 'package:kuka_companion/src/features/user_management/domain/user_first_name.dart';

class AppUser {
  final UserFirstName firstName;

  const AppUser({
    required this.firstName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName;

  @override
  int get hashCode => firstName.hashCode;
}
