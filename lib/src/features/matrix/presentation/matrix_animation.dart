import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/matrix/data/matrix_repo.dart';
import 'package:kuka_companion/src/features/matrix/domain/matrix.dart';
import 'package:kuka_companion/src/features/matrix/domain/matrix_id.dart';
import 'package:rive/rive.dart';

class MatrixAnimation extends ConsumerStatefulWidget {
  const MatrixAnimation({super.key});

  @override
  ConsumerState createState() => _MatrixAnimationState();
}

class _MatrixAnimationState extends ConsumerState<MatrixAnimation> {
  static const String _pathToRiveAsset = 'assets/square_guy_team_30_06.riv';
  static const String _artboardName = 'Matrize';
  static const String _statemachineName = 'Matrize Statemachine';

  static const String _statemachineRosetteAInputName = 'Rosette1';
  static const String _statemachineRosetteBInputName = 'Rosette2';
  static const String _statemachineGewindeAInputName = 'Schraube1';
  static const String _statemachineGewindeBInputName = 'Schraube2';
  static const String _statemachineBoxInputName = 'Box';

  static const String _matrixID = 'matrixA';

  SMIBool? _rosetteA;
  SMIBool? _rosetteB;
  SMIBool? _gewindeA;
  SMIBool? _gewindeB;
  SMIBool? _box;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, _statemachineName);
    artboard.addController(controller!);
    _rosetteA = controller.getBoolInput(_statemachineRosetteAInputName);
    _rosetteB = controller.getBoolInput(_statemachineRosetteBInputName);
    _gewindeA = controller.getBoolInput(_statemachineGewindeAInputName);
    _gewindeB = controller.getBoolInput(_statemachineGewindeBInputName);
    _box = controller.getBoolInput(_statemachineBoxInputName);
  }

  @override
  Widget build(BuildContext context) {
    final matrixAsync = ref.watch(matrixStreamProvider);
    final matrix = matrixAsync.hasValue
        ? matrixAsync.value!
        : const Matrix(
            id: MatrixID(_matrixID),
            rosetteA: false,
            rosetteB: false,
            gewindeA: false,
            gewindeB: false,
            box: false,
          );

    _updateMatrixAnimation(matrix);

    Widget result;

    result = RiveAnimation.asset(
      _pathToRiveAsset,
      artboard: _artboardName,
      onInit: _onRiveInit,
    );

    result = AspectRatio(
      aspectRatio: 16 / 9,
      child: result,
    );

    return result;
  }

  void _updateMatrixAnimation(Matrix matrix) {
    _rosetteA?.value = matrix.rosetteA;
    _rosetteB?.value = matrix.rosetteB;
    _gewindeA?.value = matrix.gewindeA;
    _gewindeB?.value = matrix.gewindeB;
    _box?.value = matrix.box;
  }
}
