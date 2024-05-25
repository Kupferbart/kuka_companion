import 'package:flutter/material.dart';
import 'package:kuka_companion/src/features/user_management/presentation/widgets/login_button_area.dart';
import 'package:kuka_companion/src/features/user_management/presentation/widgets/login_header.dart';
import 'package:kuka_companion/src/features/user_management/presentation/widgets/user_list_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget result;

    result = const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LoginHeader(),
        Expanded(
          child: UserListView(),
        ),
        LoginButtonArea(),
      ],
    );

    result = Container(
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 600,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 32,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: result,
    );

    result = Center(
      child: result,
    );

    result = SafeArea(
      child: result,
    );

    result = Scaffold(
      body: result,
    );

    return result;
  }
}
