import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/features/matrix/data/matrix_repo.dart';
import 'package:kuka_companion/src/features/matrix/domain/matrix_id.dart';
import 'package:rive/rive.dart';
import '../../matrizeState/matritze_model_notifier.dart';
import '../data/matrix_repository.dart';
import '../domain/matrix.dart';




class MatrizePage extends ConsumerWidget {
  MatrizePage({super.key});

  late SMIInput<bool> _boolRosette1;
  late SMIInput<bool> _boolRosette2;
  late SMIInput<bool> _boolGewinde1;
  late SMIInput<bool> _boolGewinde2;
  late SMIInput<bool>_boolBox;

  bool isInitialized = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //final matrixNotifier = ref.watch(matrixStateProvider.notifier);
    final matrixModels = ref.watch(matrixModelsProvider);
    final matrixStateA = ref.watch(matrixModelsProvider)['matrixA'];
    final repository = ref.watch(matrixRepositoryProvider);
    final matrixAsync = ref.watch(matrixStreamProvider);

    const Matrix matrixDummy = Matrix(id: MatrixID('matrixA'), rosetteA: false, rosetteB: false, gewindeA: false, gewindeB: false, box: false);

    final Matrix matrix = matrixAsync.when(data: (matrix) => matrix, error: (error, stacktrace) => matrixDummy, loading: () => matrixDummy);

    debugPrint("MatrixStateA Build null");

    // if (isInitialized && matrixStateA != null) {
    //   _boolRosette1.value = matrixStateA.isRossetteA;
    //   _boolRosette2.value = matrixStateA.isRossetteB;
    //   _boolGewinde1.value = matrixStateA.isGewindeA;
    //   _boolGewinde2.value = matrixStateA.isGewindeB;
    //   _boolBox.value = matrixStateA.isKarton;
    // }

    if (isInitialized) {
      _boolRosette1.value = matrix.rosetteA;
      _boolRosette2.value = matrix.rosetteB;
      _boolGewinde1.value = matrix.gewindeA;
      _boolGewinde2.value = matrix.gewindeB;
      _boolBox.value = matrix.box;
    }

    // void _updateRiveInputs() {
    //   final matrixStateA = ref.watch(matrixModelsProvider)['matrixA'];
    //   if (matrixStateA != null) {
    //     _boolRosette1.value = matrixStateA.isRossetteA;
    //     _boolRosette2.value = matrixStateA.isRossetteB;
    //     _boolGewinde1.value = matrixStateA.isGewindeA;
    //     _boolGewinde2.value = matrixStateA.isGewindeB;
    //     _boolBox.value = matrixStateA.isKarton;
    //   }
    // }

    void _updateRiveInputs() {
      _boolRosette1.value = matrix.rosetteA;
      _boolRosette2.value = matrix.rosetteB;
      _boolGewinde1.value = matrix.gewindeA;
      _boolGewinde2.value = matrix.gewindeB;
      _boolBox.value = matrix.box;

    }

    void _onRiveInit1(Artboard artboard) {

      final controller = StateMachineController.fromArtboard(artboard, 'Matrize Statemachine');
      if (controller != null) {
        artboard.addController(controller);
        _boolGewinde1 = controller.findInput<bool>('Schraube1')!;
        _boolGewinde2 = controller.findInput<bool>('Schraube2')!;
        _boolRosette1 = controller.findInput<bool>('Rosette1')!;
        _boolRosette2 = controller.findInput<bool>('Rosette2')!;
        _boolBox = controller.findInput<bool>('Box')!;
        isInitialized = true;
        _updateRiveInputs();
      }
    }

    return ListView(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 350,
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: RiveAnimation.asset(
              'assets/square_guy_team_30_06.riv',
              artboard: "Matrize",
              onInit: _onRiveInit1,
            ),
          ),
        ),
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
                  // Text('Matrix: ${entry.key}'),
                  // Text('Rossette A: ${entry.value.isRossetteA}'),
                  // Text('Rossette B: ${entry.value.isRossetteB}'),
                  // Text('Gewinde A: ${entry.value.isGewindeA}'),
                  // Text('Gewinde B: ${entry.value.isGewindeB}'),
                  // Text('Karton: ${entry.value.isKarton}'),
                  Text('Matrix: ${matrix.id.value}'),
                  Text('Rossette A: ${matrix.rosetteA}'),
                  Text('Rossette B: ${matrix.rosetteB}'),
                  Text('Gewinde A: ${matrix.gewindeA}'),
                  Text('Gewinde B: ${matrix.gewindeB}'),
                  Text('Karton: ${matrix.box}'),

                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {

                      // Beispiel für das Senden einer JSON-Nachricht
                      //repository.sendJson({'matrixId': entry.key, 'rosette_A': true, 'rosette_B': true, 'gewinde_A': true, 'gewinde_B': true, 'box': true});
                      //repository.sendJson({'matrixId': entry.key, 'rosette_A': true, 'rosette_B': true, 'gewinde_A': true, 'gewinde_B': true, 'box': true, 'status': "error"});
                      //debugPrint("run_rosetten");
                    },
                    child: const Text('Bestätigen'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}