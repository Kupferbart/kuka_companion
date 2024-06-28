import 'package:flutter/material.dart';
import 'package:kuka_companion/src/features/companion/presentation/widgets/animation_container.dart';

import '../../dev_panel/presentation/dev_panel.dart';
import '../../matrize/presentation/matrize_page.dart';

class CompanionPage extends StatelessWidget {
  const CompanionPage({super.key});

  @override
  Widget build(BuildContext context) {
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
    // result = SafeArea(child: result);
    //
    // result = Scaffold(
    //   /*appBar: AppBar(
    //     title: const Text('Menschenzentrierte Robotik - RALF',),
    //     backgroundColor: const Color.fromRGBO(0, 53,96, 1.0), // RUB - BLAU: rgb (0,53,96); RUB - Grün: rgb (141, 174, 16);  RUB- Grau: rgb (231, 231, 231)
    //   ),*/
    //   appBar: AppBar(
    //     iconTheme: const IconThemeData(color: Color.fromRGBO(0, 53, 96, 1.0)),
    //     title: const Text('Menschenzentrierte Robotik - RALF',
    //         style: TextStyle(color: Colors.white)),
    //     backgroundColor: const Color.fromRGBO(0, 53, 96, 1.0),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 20),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         SizedBox(
    //           width: 220,
    //           height: MediaQuery.of(context).size.height,
    //           child: Card(
    //             elevation: 10,
    //             shadowColor: Colors.black,
    //             color: const Color.fromRGBO(231, 231, 231, 1.0),
    //             child:
    //
    //
    //
    //             SimpleCircularProgressBar(
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
    //             ),
    //           ),
    //         ),
    //         const SizedBox(width: 16),
    //         Expanded(
    //           flex: 1,
    //           child: Card(
    //             elevation: 50,
    //             shadowColor: Colors.black,
    //             color: const Color.fromRGBO(231, 231, 231, 1.0),
    //             child: Container(
    //               child: result,
    //             ),
    //           ),
    //         ),
    //         const SizedBox(width: 16),
    //         const SizedBox(
    //           width: 500,
    //           child: Card(
    //             elevation: 10,
    //             shadowColor: Colors.black,
    //             color: Color.fromRGBO(231, 231, 231, 1.0),
    //             child: Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Center(
    //                 child: MatrizePage(),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    result = buildContentArea(context);

    //TODO: Use Environment Variable as Condition
    if (true) {
      result = Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildDevPanelArea(context),
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

  Widget buildContentArea(BuildContext context) {
    // Widget result;
    //
    // // final AnimationContainer companionAnimation = const AnimationContainer();
    // //
    // // result = MatrizePage();
    // //
    // // result = SizedBox(
    // //   width: 500,
    // //     height: 500,
    // //   child: result,
    // // );
    //
    // return result;

    return const Row(
      children: [
        Flexible(
          flex: 2,
          child: AnimationContainer(),
        ),
        Flexible(
          flex: 1,
          child: MatrizePage(),
        ),
      ],
    );
  }

  Widget buildDevPanelArea(BuildContext context) => Container(
        width: 280,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        child: const DevPanel(),
      );
}
