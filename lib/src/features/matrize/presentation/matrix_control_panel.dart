import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kuka_companion/src/features/matrize/data/matrix_repo.dart';

import '../domain/matrix.dart';

class MatrixControlPanel extends ConsumerWidget {
  const MatrixControlPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matrix = ref.watch(matrixProvider);

    print('IN BUILD');

    return matrix.when(
      data: (matrix) => buildOnData(context, ref, matrix),
      error: (error, stacktrace) => const Text('ERROR'),
      loading: () => const Text('LOADING'),
    );
  }

  Widget buildOnData(BuildContext context, WidgetRef ref, Matrix matrix) {
    Widget result;

    final rosetteARow = buildSwitchRow(
        label: 'RosetteA',
        switchValue: matrix.rosetteA,
        onChanged: (newSwitchValue) {
          print('BOOL: $newSwitchValue');

          ref.read(matrixRepositoryProvider).setMatrix(matrix.copyWith(
                rosetteA: newSwitchValue,
              ));
        });

    final rosetteBRow = buildSwitchRow(
        label: 'RosetteB',
        switchValue: matrix.rosetteB,
        onChanged: (newSwitchValue) =>
            ref.read(matrixRepositoryProvider).setMatrix(matrix.copyWith(
                  rosetteB: newSwitchValue,
                )));

    final gewindeARow = buildSwitchRow(
        label: 'GewindeA',
        switchValue: matrix.gewindeA,
        onChanged: (newSwitchValue) =>
            ref.read(matrixRepositoryProvider).setMatrix(matrix.copyWith(
                  gewindeA: newSwitchValue,
                )));

    final gewindeBRow = buildSwitchRow(
        label: 'GewindeB',
        switchValue: matrix.gewindeB,
        onChanged: (newSwitchValue) =>
            ref.read(matrixRepositoryProvider).setMatrix(matrix.copyWith(
                  gewindeB: newSwitchValue,
                )));

    final kartonRow = buildSwitchRow(
        label: 'Karton',
        switchValue: matrix.karton,
        onChanged: (newSwitchValue) =>
            ref.read(matrixRepositoryProvider).setMatrix(matrix.copyWith(
                  karton: newSwitchValue,
                )));

    result = Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(),
        1: IntrinsicColumnWidth(),
      },
      children: [
        rosetteARow,
        rosetteBRow,
        gewindeARow,
        gewindeBRow,
        kartonRow,
      ],
    );

    const headline = Text('Matrix Control Panel');

    result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headline,
        const Gap(32),
        result,
      ],
    );

    return result;
  }

  TableRow buildSwitchRow({
    required String label,
    required bool switchValue,
    required void Function(bool) onChanged,
  }) {
    final WidgetStateProperty<Icon?> thumbIcon =
        WidgetStateProperty.resolveWith<Icon?>(
      (states) => states.contains(WidgetState.selected)
          ? const Icon(Icons.check)
          : const Icon(Icons.close),
    );

    final Switch switchWidget = Switch(
      value: switchValue,
      onChanged: onChanged,
      thumbIcon: thumbIcon,
    );

    final Text labelWidget = Text(label);

    return TableRow(
      children: [
        labelWidget,
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: switchWidget,
        ),
      ],
    );
  }
}
