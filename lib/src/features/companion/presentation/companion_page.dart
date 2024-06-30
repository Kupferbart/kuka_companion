import 'package:flutter/material.dart';
import 'package:kuka_companion/src/features/companion/presentation/widgets/animation_container.dart';
//import 'package:rive/rive.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../matrize/presenation/matrize_page.dart';

class CompanionPage extends StatelessWidget {

  const CompanionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget result;

    result = const AnimationContainer();

    result = Padding(
      padding: const EdgeInsets.all(64),
      child: result,
    );

    result = Center(
      child: result,
    );

    result = SafeArea(child: result);

    result = Scaffold(
      /*appBar: AppBar(
        title: const Text('Menschenzentrierte Robotik - RALF',),
        backgroundColor: const Color.fromRGBO(0, 53,96, 1.0), // RUB - BLAU: rgb (0,53,96); RUB - Grün: rgb (141, 174, 16);  RUB- Grau: rgb (231, 231, 231)
      ),*/
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromRGBO(0, 53, 96, 1.0)),
        title: const Text('Menschenzentrierte Robotik - RALF',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(0, 53, 96, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 220,
              height: MediaQuery.of(context).size.height,
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: const Color.fromRGBO(231, 231, 231, 1.0),
                child:



                SimpleCircularProgressBar(
                  mergeMode: true,
                  progressColors: const [
                    Color.fromRGBO(141, 174, 16, 0.5),
                    Color.fromRGBO(141, 174, 16, 1.0)
                  ],
                  onGetText: (double value) {
                    return Text(
                      '${value.toInt()}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 53, 96, 1.0),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: const Color.fromRGBO(231, 231, 231, 1.0),
                child: Container(
                  child: result,
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 500,
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Color.fromRGBO(231, 231, 231, 1.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: MatrizePage(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return result;
  }
}
