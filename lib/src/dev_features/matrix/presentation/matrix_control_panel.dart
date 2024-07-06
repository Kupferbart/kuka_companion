import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/matrix/data/matrix_repo.dart';
import 'package:kuka_companion/src/features/matrix/domain/matrix_id.dart';

import '../../../features/matrix/domain/matrix.dart';

class MatrixControlPanel extends ConsumerWidget {
  const MatrixControlPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matrixAsyncValue = ref.watch(matrixStreamProvider);

    Widget result;

    result = matrixAsyncValue.when(
      data: (Matrix matrix) => buildOnData(context, ref, matrix),
      loading: () => buildOnData(
        context,
        ref,
        const Matrix(
            id: MatrixID('matrixA'),
            rosetteA: false,
            rosetteB: false,
            gewindeA: false,
            gewindeB: false,
            box: false),
      ),
      error: (Object error, StackTrace stackTrace) => Text('ERROR: $error'),
    );

    result = Column(
      children: [
        result,
      ],
    );

    return result;
  }

  Widget buildOnData(BuildContext context, WidgetRef ref, Matrix matrix) {
    Widget result;

    final rosetteARow = SwitchRow(
        label: 'Rosette A',
        currentValue: matrix.rosetteA,
        onChanged: (newValue) =>
            ref.read(matrixRepoProvider).sendMatrixUpdate(matrix.copyWith(
                  rosetteA: newValue,
                )));

    final rosetteBRow = SwitchRow(
        label: 'Rosette B',
        currentValue: matrix.rosetteB,
        onChanged: (newValue) =>
            ref.read(matrixRepoProvider).sendMatrixUpdate(matrix.copyWith(
                  rosetteB: newValue,
                )));

    final gewindeARow = SwitchRow(
        label: 'Gewinde A',
        currentValue: matrix.gewindeA,
        onChanged: (newValue) =>
            ref.read(matrixRepoProvider).sendMatrixUpdate(matrix.copyWith(
                  gewindeA: newValue,
                )));

    final gewindeBRow = SwitchRow(
        label: 'Gewinde B',
        currentValue: matrix.gewindeB,
        onChanged: (newValue) =>
            ref.read(matrixRepoProvider).sendMatrixUpdate(matrix.copyWith(
                  gewindeB: newValue,
                )));

    final boxRow = SwitchRow(
        label: 'Box',
        currentValue: matrix.box,
        onChanged: (newValue) =>
            ref.read(matrixRepoProvider).sendMatrixUpdate(matrix.copyWith(
                  box: newValue,
                )));

    result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Matrix Control Panel',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        rosetteARow,
        rosetteBRow,
        gewindeARow,
        gewindeBRow,
        boxRow,
      ],
    );

    return result;
  }
}

class SwitchRow extends StatelessWidget {
  final String _label;
  final bool _currentValue;
  final Function(bool)? _onChanged;

  const SwitchRow({
    super.key,
    required String label,
    required bool currentValue,
    Function(bool)? onChanged,
  })  : _label = label,
        _currentValue = currentValue,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    Widget result;

    final label = Text(_label);
    final switchControl = Switch(value: _currentValue, onChanged: _onChanged);

    result = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: label,
        ),
        switchControl,
      ],
    );

    return result;
  }
}
