import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kuka_companion/src/features/user_management/data/user_repository.dart';
import 'package:kuka_companion/src/features/user_management/domain/app_user.dart';
import 'package:kuka_companion/src/features/user_management/presentation/widgets/user_list_tile.dart';

class UserListView extends ConsumerWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<AppUser> userList =
        ref.read(userRepositoryProvider).getUserList();

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) =>
          UserListTile(user: userList[index]),
      separatorBuilder: (BuildContext context, int index) => const Gap(8),
    );
  }
}
