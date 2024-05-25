import 'package:flutter/material.dart';
import 'package:kuka_companion/src/features/companion/presentation/widgets/animation_container.dart';

class CompanionPage extends StatelessWidget {
  const CompanionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget result;

    result = const AnimationContainer();

    result = Center(
      child: result,
    );

    result = SafeArea(child: result);

    result = Scaffold(
      body: result,
    );

    return result;
  }
}
