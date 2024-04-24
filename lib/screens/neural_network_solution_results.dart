import 'package:flutter/material.dart';
import '../bg_blur_filter.dart';
import '../constants.dart';
import 'neural_network_multi_hiddens.dart';

class NeuralNetworkSolutionResults extends StatelessWidget {
  createList() {
    List<Widget> tempList = [];
    for (int i = 0; i < iterationCount; i = i + 1000) {
      tempList.add(Text(
          '$i.İTERASYON BEKLENEN SONUÇ: ${mainNormalizedMatrix[inputsCount + outputsCount - 1][i]}'));
      tempList.add(Text('$i.İTERASYON ÇIKAN SONUÇ: ${expectedResults[i]}'));
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    double successRate = ((100 - percentageMAPEError));

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BGBlurFilter(),
          Container(
            color: Colors.black.withOpacity(0.9),
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Neural Network has trained \nwith %${successRate.toStringAsFixed(2)} success rate.',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'ITERATION: $iterationCount',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'STEPS: ${iterationCount * mainNormalizedMatrix[0].length}',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'ERROR: %${percentageMAPEError.toStringAsFixed(5)}',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'TIME: $timeResult sec',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    child: Text(
                      'See more',
                      style: TextStyle(fontSize: 13, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) =>
                              NeuralNetworkMultiHiddens(),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
