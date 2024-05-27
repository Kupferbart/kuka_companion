import 'package:flutter/material.dart';
import 'package:kuka_companion/src/features/companion/presentation/widgets/animation_container.dart';


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
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(0, 53, 96, 1.0)),
          title: const Text('Menschenzentrierte Robotik - RALF',
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(0, 53, 96, 1.0),
        ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), //  Abstand zum Rand
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 220,
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: const Color.fromRGBO(231, 231, 231, 1.0),
                child: Container(

                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
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
              width: 220,
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: const Color.fromRGBO(231, 231, 231, 1.0),
                child: Container(

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
