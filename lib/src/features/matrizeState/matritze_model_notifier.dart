import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../matrize/data/matirx_model.dart';
import 'matrize_state_notifier.dart';



class MatrixModelsNotifier extends StateNotifier<Map<String, MatrixModel>> {
  final Ref ref;

  MatrixModelsNotifier(this.ref) : super({

    'matrixA': const MatrixModel(isRossetteA: false, isRossetteB: false, isGewindeA: false, isGewindeB: false, isKarton: false, matrixId: 'matrixA'),
    'matrixB': const MatrixModel(isRossetteA: false, isRossetteB: false, isGewindeA: false, isGewindeB: false, isKarton: false, matrixId: 'matrixB'),
  });

  void updateMatrix(String matrixId, MatrixModel updatedModel) {
    state = {
      ...state,
      matrixId: updatedModel,
    };
    ref.read(matrixStateProvider.notifier).checkAndUpdateState(matrixId, updatedModel, ref.read(matrixStateProvider)[matrixId]!);
    
  }

  void updateFromJson(String matrixId, Map<String, dynamic> json) {
    final updatedModel = MatrixModel.fromJson(json);
    updateMatrix(matrixId, updatedModel);
  }

}

final matrixModelsProvider = StateNotifierProvider<MatrixModelsNotifier, Map<String, MatrixModel>>((ref) => MatrixModelsNotifier(ref));
