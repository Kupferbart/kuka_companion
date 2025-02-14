import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../matrize/data/matirx_model.dart';

// Enum für die verschiedenen Zustände der Matrize
enum MatrixState {
  notFilled,
  filled,
  waitRosettenPacked,
  rosettenPacked,
  waitPappePacked,
  waitGewindePacked,
  allPacked,
  finished,
  error
}


class MatrixStateNotifier extends StateNotifier<Map<String, MatrixState>> {
  MatrixStateNotifier() : super({
    'matrixA': MatrixState.notFilled,
    'matrixB': MatrixState.notFilled,
  });

  void updateState(String matrixId, MatrixState newState) {
    state = {
      ...state,
      matrixId: newState,
    };
  }

  void checkAndUpdateState(String matrixId, MatrixModel model, MatrixState currentState) {
    //final matrixState = ref.watch(matrixStateProvider)[matrixId] ?? MatrixState.notFilled;
    //if(matrixState == MatrixState.notFilled) {
    if(currentState == MatrixState.notFilled)
      if (model.isFilled) {
        updateState(matrixId, MatrixState.filled);
      }
    //}
  }
  /*
  void setAllComponentsTrue(String matrixId) {
    MatrixModel model = MatrixModel(matrixId: matrixId, isRossetteA: true, isRossetteB: true, isGewindeA: true, isGewindeB: true, isKarton: true); // Beispielmodell mit allen Werten auf TRUE
    checkAndUpdateState(matrixId, model, ref);
  }*/

  void resetState(String matrixId) {
    updateState(matrixId, MatrixState.notFilled);
  }

}

final matrixStateProvider = StateNotifierProvider<MatrixStateNotifier, Map<String, MatrixState>>((ref) => MatrixStateNotifier());
