import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuka_companion/src/environment/environment_configuration.dart';
import 'package:kuka_companion/src/features/companion/presentation/widgets/animation_container.dart';
import 'package:kuka_companion/src/features/matrix/presentation/matrix_animation.dart';

//import 'package:rive/rive.dart';
//import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../../dev_features/dev_panel/presentation/dev_panel.dart';
import '../../matrix/presentation/matrize_page.dart';
import '../../vertical_stepper/presentation/matrix_stepper.dart';

class CompanionPage extends ConsumerWidget {
  const CompanionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devPanelConfiguration =
        ref.watch(environmentConfigurationProvider).devPanel;

    Widget result;

    // result = const AnimationContainer();
    //
    // result = Padding(
    //   padding: const EdgeInsets.all(64),
    //   child: result,
    // );
    //
    // result = Center(
    //   child: result,
    // );
    //
    // result = Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       SizedBox(
    //         width: 320,
    //         height: MediaQuery.of(context).size.height,
    //         child: const Card(
    //             elevation: 10,
    //             shadowColor: Colors.black,
    //             color: Color.fromRGBO(231, 231, 231, 1.0),
    //             child: VerticalStepper(
    //               matrixId: 'matrixA',
    //             )
    //
    //             /*SimpleCircularProgressBar(
    //               mergeMode: true,
    //               progressColors: const [
    //                 Color.fromRGBO(141, 174, 16, 0.5),
    //                 Color.fromRGBO(141, 174, 16, 1.0)
    //               ],
    //               onGetText: (double value) {
    //                 return Text(
    //                   '${value.toInt()}',
    //                   style: const TextStyle(
    //                     fontSize: 30,
    //                     fontWeight: FontWeight.bold,
    //                     color: Color.fromRGBO(0, 53, 96, 1.0),
    //                   ),
    //                 );
    //               },
    //             ),*/
    //             ),
    //       ),
    //       const SizedBox(width: 16),
    //       Expanded(
    //         flex: 1,
    //         child: Card(
    //           elevation: 50,
    //           shadowColor: Colors.black,
    //           color: const Color.fromRGBO(231, 231, 231, 1.0),
    //           child: Container(
    //             child: result,
    //           ),
    //         ),
    //       ),
    //       const SizedBox(width: 16),
    //       SizedBox(
    //         width: 500,
    //         child: Card(
    //           elevation: 10,
    //           shadowColor: Colors.black,
    //           color: const Color.fromRGBO(231, 231, 231, 1.0),
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Center(
    //               child: MatrizePage(),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    // Widget stepper = const VerticalStepper(matrixId: 'matrixA');
    Widget stepper = MatrixStepper();
    stepper = Container(
        width: 320,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        child: stepper);

    const companionAnimationWidget = AnimationContainer();
    final matrizePage = MatrizePage();

    result = Column(
      children: [
        const Expanded(child: companionAnimationWidget),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 320),
          child: const MatrixAnimation(),
        ),
      ],
    );

    result = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        stepper,
        const SizedBox(
          width: 32,
        ),
        Expanded(child: result),
      ],
    );

    result = Padding(
      padding: const EdgeInsets.all(16),
      child: result,
    );

    if (devPanelConfiguration.enabled) {
      result = Row(
        children: [
          const DevPanel(),
          Expanded(child: result),
        ],
      );
    }

    result = SafeArea(child: result);

    result = Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromRGBO(0, 53, 96, 1.0)),
        title: const Text('Menschenzentrierte Robotik - RALF',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(0, 53, 96, 1.0),
      ),
      body: result,
    );

    return result;
  }
}
