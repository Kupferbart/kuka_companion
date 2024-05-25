import 'package:kuka_companion/src/features/user_management/domain/user_first_name.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/app_user.dart';

part 'user_repository.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) => const MockUserRepository();

abstract class UserRepository {
  const UserRepository();

  List<AppUser> getUserList();
}

class MockUserRepository extends UserRepository {
  final _userList = const [
    AppUser(firstName: UserFirstName("Alishan")),
    AppUser(firstName: UserFirstName("Ben")),
    AppUser(firstName: UserFirstName("Joe")),
    AppUser(firstName: UserFirstName("Jona")),
    AppUser(firstName: UserFirstName("Max")),
    AppUser(firstName: UserFirstName("Ralf")),
    AppUser(firstName: UserFirstName("Sebastian")),
  ];

  const MockUserRepository();

  @override
  List<AppUser> getUserList() {
    return List.unmodifiable(_userList);
  }
}
