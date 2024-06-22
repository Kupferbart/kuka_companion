import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:kuka_companion/src/features/matrizeState/matrize_state_notifier.dart';
import 'package:rive/rive.dart';
import '../../matrizeState/matritze_model_notifier.dart';
import '../data/matrix_repository.dart';




class MatrizePage extends ConsumerWidget {
  const MatrizePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //final matrixNotifier = ref.watch(matrixStateProvider.notifier);
    final matrixModels = ref.watch(matrixModelsProvider);
    final repository = ref.watch(matrixRepositoryProvider);

    //SMIBool? _boolRosette1;
    //SMIBool? _boolRosette2;
    //SMIBool? _boolGewinde1;
    //SMIBool? _boolGewinde2;

    //bool value;

    /*void updateParametersForRive(){

      debugPrint("updateparametersForRive");

      for (var entry in matrixModels.entries) {
        //_boolRosette1?.value = entry.value.isRossetteA;
        //_boolRosette2?.value = entry.value.isRossetteB;
        //_boolGewinde1?.value = entry.value.isGewindeA;
        //_boolGewinde1?.value = entry.value.isGewindeB;
      }

    }*/


    void _onRiveInit1(Artboard artboard) {
      final controller = StateMachineController.fromArtboard(
          artboard, 'Matrize Statemachine');
      artboard.addController(controller!);
      //_boolGewinde1 = controller.getBoolInput('Schraube1');
      //_boolGewinde2 = controller.getBoolInput('Schraube2');
      //_boolRosette1 = controller.getBoolInput('Rosette1');
      //_boolRosette2 = controller.getBoolInput('Rosette2');

    }


    return ListView(
      children: [
        for (var entry in matrixModels.entries)

          Card(
            margin: const EdgeInsets.all(16.0),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Matrix: ${entry.key}'),
                  Text('Rossette A: ${entry.value.isRossetteA}'),
                  Text('Rossette B: ${entry.value.isRossetteB}'),
                  Text('Gewinde A: ${entry.value.isGewindeA}'),
                  Text('Gewinde B: ${entry.value.isGewindeB}'),
                  Text('Karton: ${entry.value.isKarton}'),



                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {

                      // Beispiel für das Senden einer JSON-Nachricht
                      //repository.sendJson({'action': 'run_rosetten', 'matrixId': entry.key});
                      repository.sendJson({'matrixId': entry.key, 'rosette_A': true, 'rosette_B': true, 'gewinde_A': true, 'gewinde_B': true, 'box': true});
                      //matrixNotifier.setAllComponentsTrue('matrixA');
                      //updateParametersForRive();
                      //value = entry.value.isRossetteA;
                      //_boolRosette1?.value = entry.value.isRossetteA;
                      //_boolRosette1?.value = value;

                      //_boolRosette2.value = true;

                      /*if(value){

                        debugPrint("value ${value}");
                        _boolRosette2?.value = true;

                      }*/
                      //_boolRosette2?.value = entry.value.isRossetteB;
                      //_boolGewinde1?.value = entry.value.isGewindeA;
                      //_boolGewinde1?.value = entry.value.isGewindeB;
                      //_boolGewinde1?.fire(entry.value.isRossetteA);
                      debugPrint("run_rosetten");
                    },
                    child: const Text('Bestätigen'),
                  ),
                ],
              ),
            ),
          ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 350,
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: RiveAnimation.asset(
              'assets/square_guy_team_17_06(2).riv',
              artboard: "Matrize",
              onInit: _onRiveInit1,
            ),
          ),
        ),
      ],
    );
  }
}