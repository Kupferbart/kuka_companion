import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/matrix/data/matrix_repo.dart';
import 'package:kuka_companion/src/features/matrix/domain/matrix.dart';
import 'package:kuka_companion/src/features/matrix/domain/matrix_id.dart';

class MatrixStepper extends ConsumerStatefulWidget {
  const MatrixStepper({super.key});

  @override
  ConsumerState<MatrixStepper> createState() => _MatrixStepperState();
}

class _MatrixStepperState extends ConsumerState<MatrixStepper> {
  int _currentStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    final matrixAsync = ref.watch(matrixStreamProvider);
    final matrix = matrixAsync.hasValue
        ? matrixAsync.value!
        : const Matrix(
            id: MatrixID('matrixA'),
            rosetteA: false,
            rosetteB: false,
            gewindeA: false,
            gewindeB: false,
            box: false,
          );

    final List<Step> stepList = List.empty(growable: true);

    final Step fillMatrixStep = Step(
      title: const Text('Matrix befüllen'),
      content: const Text(
          'Setze bitte beide Rosetten, Gewinde und die Box in die Matrize!'),
      isActive: _currentStepIndex == 0,
    );

    final Step robotRosettenStep = Step(
      title: const Text('Rosetten verpacken'),
      content:
          const Text('Bitte warte, bis der Roboter die Rosetten verpackt hat!'),
      isActive: _currentStepIndex == 1,
    );

    final Step pappeEinlegenStep = Step(
      title: const Text('Pappe einlegen'),
      content: const Text('Bitte lege die Pappe in die Box!'),
      isActive: _currentStepIndex == 2,
    );

    stepList.add(fillMatrixStep);
    stepList.add(robotRosettenStep);
    stepList.add(pappeEinlegenStep);

    return Stepper(
      currentStep: _currentStepIndex,
      steps: stepList,
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        Widget result;

        result = switch (details.currentStep) {
          0 => ElevatedButton(
              onPressed: matrix.alles ? () =>  setState(() => _currentStepIndex++) : null,
              child: const Text('Weiter'),
            ),
          _ => Container(),
        };

        result = Align(
          alignment: Alignment.center,
          child: result,
        );

        result = Padding(
          padding: const EdgeInsets.only(top: 16),
          child: result,
        );

        return result;
      },
    );
  }
}
