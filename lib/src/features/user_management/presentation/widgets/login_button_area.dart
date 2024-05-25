import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/user_management/presentation/controllers/selected_user_controller.dart';

import '../../../../routing/routes.dart';

class LoginButtonArea extends ConsumerWidget {
  const LoginButtonArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUser = ref.watch(selectedUserControllerProvider);

    Widget result;

    result = ElevatedButton(
      onPressed: selectedUser == null ? null : () => const CompanionRoute().go(context),
      child: const Text("Los geht's!"),
    );

    result = Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 16,
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: result,
    );

    return result;
  }
}
