import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:rive/rive.dart';

import '../matrize/data/matirx_model.dart';
import 'matrize_state_notifier.dart';

//import '../companion/presentation/widgets/animation_container.dart';


class MatrixModelsNotifier extends StateNotifier<Map<String, MatrixModel>> {
  final Ref ref;

  //SMIBool? _boolSchraube1;
  //SMIBool? _boolSchraube2;
  //SMIBool? _boolGewinde1;
  //SMIBool? _boolGewinde2;


  MatrixModelsNotifier(this.ref) : super({

    'matrixA': const MatrixModel(isRossetteA: false, isRossetteB: false, isGewindeA: false, isGewindeB: false, isKarton: false, matrixId: 'matrixA'),
    'matrixB': const MatrixModel(isRossetteA: false, isRossetteB: false, isGewindeA: false, isGewindeB: false, isKarton: false, matrixId: 'matrixB'),
  });

  void updateMatrix(String matrixId, MatrixModel updatedModel) {
    state = {
      ...state,
      matrixId: updatedModel,
    };
    ref.read(matrixStateProvider.notifier).checkAndUpdateState(matrixId, updatedModel);

    //updateParametersForRive();
    
  }

  void updateFromJson(String matrixId, Map<String, dynamic> json) {
    final updatedModel = MatrixModel.fromJson(json);
    updateMatrix(matrixId, updatedModel);
  }
}

final matrixModelsProvider = StateNotifierProvider<MatrixModelsNotifier, Map<String, MatrixModel>>((ref) => MatrixModelsNotifier(ref));
