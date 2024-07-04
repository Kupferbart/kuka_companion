import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../matrizeState/matrize_state_notifier.dart';
import '../data/step_model.dart';


class VerticalStepper extends ConsumerStatefulWidget {
  final String matrixId;

  const VerticalStepper({super.key, required this.matrixId});

  @override
  _VerticalStepperState createState() => _VerticalStepperState();
}

class _VerticalStepperState extends ConsumerState<VerticalStepper> {
  int currentStep = 0;

  final List<StepModel> steps = [
    StepModel(title: 'Matrix befüllen', message: 'Bitte befülle die Matrix: Setze die zwei Rosetten, die zwei Gewinde und die Box in die jewilige Aussparung!'),
    StepModel(title: 'Matrix freigeben', message: 'Bitte gib die Matrix für den Roboter frei, indem du auf "Links freigeben" drückst'),
    StepModel(title: 'Roboter bearbeitet Rosetten', message: 'Warte, bis der Roboter die Rosetten eingepackt hat.'),
    StepModel(title: 'Pappe einlegen', message: 'Bitte lege die Pappe in die Box.'),
    StepModel(title: 'Roboter bearbeitet Gewinde', message: 'Warte, bis der Roboter die Gewinde eingepackt hat.'),
    StepModel(title: 'Box verschließen', message: 'Bitte schließ die Box und lege diese in das Lager. Drücke anschließend "Links freigeben"'),
  ];

  final List<String> todos = ["RunRosetten","RunGewinde"];

  @override
  Widget build(BuildContext context) {
    final matrixState = ref.watch(matrixStateProvider)[widget.matrixId] ?? MatrixState.notFilled;
    //final repository = ref.watch(matrixRepositoryProvider);

    // Hier die automatischen Übergänge
    if (matrixState == MatrixState.filled && currentStep == 0) {
      setState(() {
        steps[currentStep].isCompleted = true;
        currentStep++;
      });
    }

    if (matrixState == MatrixState.waitRosettenPacked && currentStep == 1) {
      setState(() {
        steps[currentStep].isCompleted = true;
        currentStep++;
      });
    }

    if (matrixState == MatrixState.rosettenPacked && currentStep == 2) {
      setState(() {
        steps[currentStep].isCompleted = true;
        currentStep++;
      });
    }

    if (matrixState == MatrixState.waitGewindePacked && currentStep == 3) {
      setState(() {
        steps[currentStep].isCompleted = true;
        currentStep++;
      });
    }

    if (matrixState == MatrixState.allPacked && currentStep == 4) {
      setState(() {
        steps[currentStep].isCompleted = true;
        currentStep++;
      });
    }

    // Nach Durchlauf des Arbeitszyklus von vorne beginnen
    if (matrixState == MatrixState.finished) {
      setState(() {
        for (var step in steps) {
          step.isCompleted = false;
        }
        currentStep = 0;
      });
    }


    return Column(
      children: [
        Stepper(
          type: StepperType.vertical,
          currentStep: currentStep,
          onStepContinue: null, /*() {
            if (currentStep < steps.length - 1) {
              repository.sendJson({'matrixId': widget.matrixId, 'status': todos[0]});
              setState(() {
                steps[currentStep].isCompleted = true;
                currentStep++;
              });
            } else {
              // Nach Durchlauf des Arbeitszyklus von vorne beginnen
              setState(() {
                for (var step in steps) {
                  step.isCompleted = false;
                }
                currentStep = 0;
              });
            }
          },*/
          onStepCancel: null, // Entferne Funktionalität des Cancel Button
          steps: steps.map((step) {
            return Step(
              title: Text(step.title),
              content: Text(step.isCompleted ? 'Erledigt' : step.message),
              isActive: currentStep >= steps.indexOf(step),
              state: step.isCompleted ? StepState.complete : StepState.indexed,
            );
          }).toList(),
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return const Row(
              children: <Widget>[
                /*if (currentStep > 0 && currentStep != 1 && currentStep != 2 && currentStep != 3)
                  ElevatedButton(
                    onPressed: controls.onStepContinue,
                    child: const Text('Weiter'),
                  ),*/
              ],
            );
          },
        ),
        if (matrixState == MatrixState.error)
          ElevatedButton(
            onPressed: () {
              setState(() {
                for (var step in steps) {
                  step.isCompleted = false;
                }
                currentStep = 0;
              });
              ref.read(matrixStateProvider.notifier).resetState(widget.matrixId);
            },
            child: const Text('Vorgang neu starten'),
          ),
      ],
    );
  }
}
