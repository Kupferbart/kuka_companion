import 'package:kuka_companion/src/features/user_management/domain/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_user_controller.g.dart';

@riverpod
class SelectedUserController extends _$SelectedUserController {
  @override
  AppUser? build() => null;

  void selectUser(AppUser? user) {
    state = user;
  }

  bool isUserSelected(AppUser user) => user == state;
}
