
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/matrizeState/matrize_state_notifier.dart';
import 'package:rive/rive.dart';
import '../../matrizeState/matritze_model_notifier.dart';
import '../data/matrix_repository.dart';


class MatrizePage extends ConsumerWidget {
  const MatrizePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final matrixNotifier = ref.watch(matrixStateProvider.notifier);
    final matrixModels = ref.watch(matrixModelsProvider);
    final repository = ref.watch(matrixRepositoryProvider);


    //SMIBool? _boolSchraube1;
    //SMIBool? _boolSchraube2;
    //SMIBool? _boolGewinde1;
    //SMIBool? _boolGewinde2;


    void _onRiveInit(Artboard artboard) {
      final controller = StateMachineController.fromArtboard(
      artboard, 'Matrize Statemachine');
      artboard.addController(controller!);
      //_boolSchraube1 = controller.getBoolInput('Schraube1');
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
                      repository.sendJson({'action': 'run_rosetten', 'matrixId': entry.key});
                      matrixNotifier.setAllComponentsTrue('matrixA');
                      debugPrint("run_rosetten");
                    },
                    child: const Text('Bestätigen'),
                  ),
                ],
              ),
            ),
          ),
        Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RiveAnimation.asset(
                  'assets/square_guy_team_17_06.riv',
                  artboard: "Matrize",
                  onInit: _onRiveInit,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}