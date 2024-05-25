import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/user_management/presentation/controllers/selected_user_controller.dart';

import '../../domain/app_user.dart';

class UserListTile extends ConsumerWidget {
  final AppUser user;

  const UserListTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUser = ref.watch(selectedUserControllerProvider);

    Widget result;

    result = ListTile(
      title: Text(user.firstName.value),
      selected: selectedUser == user,
      onTap: () =>
          ref.read(selectedUserControllerProvider.notifier).selectUser(user),
    );

    result = Material(
      borderRadius: BorderRadius.circular(4),
      clipBehavior: Clip.hardEdge,
      child: result,
    );

    return result;
  }
}
