import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dev_features/dev_panel/presentation/dev_panel.dart';

class MatrixTestPage extends ConsumerWidget {
  const MatrixTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget result;

    result = const DevPanel();

    result = Center(
      child: result,
    );

    result = Scaffold(
      body: result,
    );

    return result;
  }
}
