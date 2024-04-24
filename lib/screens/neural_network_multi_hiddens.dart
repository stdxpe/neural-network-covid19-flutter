import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bg_blur_filter.dart';
import '../constants.dart';
import '../painter.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'neural_network_solution_home.dart';
import 'neural_network_solution_results.dart';

class NeuralNetworkMultiHiddens extends StatefulWidget {
  @override
  _NeuralNetworkMultiHiddensState createState() =>
      _NeuralNetworkMultiHiddensState();
}

class _NeuralNetworkMultiHiddensState extends State<NeuralNetworkMultiHiddens> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  double esikDeger = 1.5;
  final Map _globalKeysMap = {};
  bool firstCalculationSet = false;
  int countInputsHiddens = 0;
  int countHiddens2Outputs = 0;
  int countHiddensHiddens2 = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => getRelativePositionsOfCircles(category: 'inputs', list: inputs));
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        getRelativePositionsOfCircles(category: 'hiddens', list: hiddens));
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        getRelativePositionsOfCircles(category: 'hiddens2', list: hiddens2));
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        getRelativePositionsOfCircles(category: 'outputs', list: outputs));
    WidgetsBinding.instance.addPostFrameCallback((_) => createLines());

    hintTextEditorInputsHiddens(list1: inputs, list2: hiddens);
    hintTextEditorHiddensHiddens2(list1: hiddens, list2: hiddens2);
    hintTextEditorHiddens2Outputs(list1: hiddens2, list2: outputs);
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  /////Hücreler
  List<Widget> createCircle({int count, String category}) {
    List<Widget> widgetsCircles = [];
    widgetsCircles.clear();

    for (int i = 0; i < count; i++) {
      GlobalKey keyName = GlobalKey();
      _globalKeysMap['$category$i'] = keyName;
      widgetsCircles.add(
        CustomPaint(
          key: _globalKeysMap['$category$i'],
          painter: MyCircle(),
        ),
      );
    }

    return widgetsCircles;
  }

  /////Çizgiler
  Widget createLines({String text, String list1, String list2}) {
    return CustomPaint(
      painter: LinePainter2(hintText: text, list1: list1, list2: list2),
    );
  }

  /////Çemberlerin göreceli konumunu hesaplar
  getRelativePositionsOfCircles({String category, List list}) {
    for (int i = 0; i < list.length; i++) {
      RenderBox _cardBox =
          _globalKeysMap['$category$i'].currentContext.findRenderObject();
      offsetsPositionsMap['$category$i'] = _cardBox.localToGlobal(Offset.zero);
    }
  }

  /////Hint Text'ler için String listeyi doldurur / Inputs-Hiddens
  hintTextEditorInputsHiddens({List list1, List list2}) {
    for (int i = 0; i < list2.length; i++) {
      for (int j = 0; j < list1.length; j++) {
        hintTextsInputsHiddens[0].add('I$j');
        hintTextsInputsHiddens[1].add('I$j-H$i');
      }
    }
  }

  /////Hint Text'ler için String listeyi doldurur / Inputs-Hiddens
  hintTextEditorHiddensHiddens2({List list1, List list2}) {
    for (int i = 0; i < list2.length; i++) {
      for (int j = 0; j < list1.length; j++) {
        hintTextsHiddensHiddens2[0].add('H$j');
        hintTextsHiddensHiddens2[1].add('H$j-2$i');
      }
    }
  }

  /////Hint Text'ler için String listeyi doldurur / Hiddens-Outputs
  hintTextEditorHiddens2Outputs({List list1, List list2}) {
    for (int i = 0; i < list2.length; i++) {
      for (int j = 0; j < list1.length; j++) {
        hintTextsHiddens2Outputs[0].add('2$j');
        hintTextsHiddens2Outputs[1].add('2$j-O$i');
      }
    }
  }

  /////Input-Hiddens I * W çarpımları
  girisCarpiAgirlikCalc(
      {List list1, List list2, List carpimList, List weights}) {
    carpimList.clear();
    for (int i = 0; i < list1.length * list2.length; i++) {
      carpimList.add((weights[0][i] * weights[1][i]));
    }
  }

  /////Random girdi ve ağırlıklar
  Random random = new Random();
  createRandomNumber({double min, double max}) {
    double randomNumber = random.nextDouble() * (max - min) + min;

    // return double.parse(randomNumber.toStringAsFixed(2));
    return randomNumber.toStringAsFixed(2);
  }

///////////////////////////////TOPLAMA FONKSİYONLARI////////////////////////////
  /////Input-Hiddens I * W çarpımlarının toplamları
  toplamFonksiyonu({List list1, List list2, List carpimList, List girisList}) {
    // double toplam = 0;
    for (int i = 0; i < list1.length * list2.length; i = i + list1.length) {
      double toplam = 0;
      for (int j = 0; j < list1.length; j++) {
        toplam = carpimList[i + j] + toplam;
      }
      girisList.add(toplam);
    }
  }

  carpimFonksiyonu({List list1, List list2, List carpimList, List girisList}) {
    // double toplam = 0;
    for (int i = 0; i < list1.length * list2.length; i = i + list1.length) {
      double toplam = 1;
      for (int j = 0; j < list1.length; j++) {
        toplam = carpimList[i + j] * toplam;
      }
      girisList.add(toplam);
    }
  }

  maksimumFonksiyonu(
      {List list1, List list2, List carpimList, List girisList}) {
    for (int i = 0; i < list1.length * list2.length; i = i + list1.length) {
      num maxVar = 0;
      List<num> tempList = [];
      for (int j = 0; j < list1.length; j++) {
        tempList.add(carpimList[i + j]);
        maxVar = tempList.reduce(max);
      }
      girisList.add(maxVar);
    }
  }

  minimumFonksiyonu({List list1, List list2, List carpimList, List girisList}) {
    for (int i = 0; i < list1.length * list2.length; i = i + list1.length) {
      num minVar = 0;
      List<num> tempList = [];
      for (int j = 0; j < list1.length; j++) {
        tempList.add(carpimList[i + j]);
        minVar = tempList.reduce(min);
      }
      girisList.add(minVar);
    }
  }

  cogunlukFonksiyonu(
      {List list1, List list2, List carpimList, List girisList}) {
    // List<num> tempMatrix = carpimList;
    // num minVar = tempMatrix.reduce(min);

    for (int i = 0; i < list1.length * list2.length; i = i + list1.length) {
      List positive = [];
      List negative = [];
      int posCount = 0;
      int negCount = 0;
      for (int j = 0; j < list1.length; j++) {
        carpimList[i + j] >= 0
            ? positive.add(carpimList[i + j])
            : negative.add(carpimList[i + j]);

        posCount = positive.length;
        negCount = negative.length;
      }
      posCount >= negCount ? girisList.add(posCount) : girisList.add(negCount);
    }
  }

  kumulatifToplamFonksiyonu(
      {List list1, List list2, List carpimList, List girisList}) {
    // double toplam = 0;
    for (int i = 0; i < list1.length * list2.length; i = i + list1.length) {
      double toplam = 0.0;
      for (int j = 0; j < list1.length; j++) {
        toplam = carpimList[i + j] + toplam;
      }
      double randomNumber =
          double.parse(createRandomNumber(min: (-1.0), max: (1.0)));
      girisList.add(toplam + randomNumber);
    }
  }

////////////////////////////---TOPLAMA FONKSİYONLARI---/////////////////////////
  ///
  ///
////////////////////////////////TRANSFER FONKSİYONLARI//////////////////////////
  sigmoidFonksiyonu({List list, List girisList, List cikisList}) {
    for (int i = 0; i < list.length; i++) {
      double sigmoid = 1 / (1 + pow(eSayisi, -girisList[i]));
      // print(sigmoid);
      cikisList.add(sigmoid);
    }
  }

  tanjantHiperbolikFonksiyonu({List list, List girisList, List cikisList}) {
    for (int i = 0; i < list.length; i++) {
      double tanjant =
          ((pow(eSayisi, girisList[i])) + (pow(eSayisi, -girisList[i]))) /
              ((pow(eSayisi, girisList[i])) - (pow(eSayisi, -girisList[i])));
      // print(sigmoid);
      cikisList.add(tanjant);
    }
  }

  esikDegerFonksiyonu({List list, List girisList, List cikisList}) {
    for (int i = 0; i < list.length; i++) {
      if (girisList[i] <= 0) {
        cikisList.add(0.0);
      } else if (girisList[i] > 0 && girisList[i] < 1) {
        cikisList.add(double.parse(girisList[i]));
      } else if (girisList[i] >= 1) {
        cikisList.add(1.0);
      }
    }
  }

  adimStepFonksiyonu({List list, List girisList, List cikisList}) {
    for (int i = 0; i < list.length; i++) {
      if (girisList[i] > esikDeger) {
        cikisList.add(1.0);
      } else if (girisList[i] <= esikDeger) {
        cikisList.add(0.0);
      }
    }
  }

////////////////////////////---TRANSFER FONKSİYONLARI---////////////////////////
  ///
  ///

  /////Bütün İşlemler / Input-Hiddens
  inputsAndHiddensAllCalculations() {
    firstCalculationSet = true;

    girisCarpiAgirlikCalc(
        list1: inputs,
        list2: hiddens,
        carpimList: inputsHiddensCarpimList,
        weights: weightsInputsHiddens);
    print('Inputs-Hiddens Çarpım List: $inputsHiddensCarpimList');

    hiddensGirisList.clear();

    if (selectedFunctions['Toplama Fonksiyonu'] == 'Toplam') {
      toplamFonksiyonu(
          list1: inputs,
          list2: hiddens,
          carpimList: inputsHiddensCarpimList,
          girisList: hiddensGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Çarpım') {
      carpimFonksiyonu(
          list1: inputs,
          list2: hiddens,
          carpimList: inputsHiddensCarpimList,
          girisList: hiddensGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Maksimum') {
      maksimumFonksiyonu(
          list1: inputs,
          list2: hiddens,
          carpimList: inputsHiddensCarpimList,
          girisList: hiddensGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Minimum') {
      minimumFonksiyonu(
          list1: inputs,
          list2: hiddens,
          carpimList: inputsHiddensCarpimList,
          girisList: hiddensGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Çoğunluk') {
      cogunlukFonksiyonu(
          list1: inputs,
          list2: hiddens,
          carpimList: inputsHiddensCarpimList,
          girisList: hiddensGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Kümülatif') {
      kumulatifToplamFonksiyonu(
          list1: inputs,
          list2: hiddens,
          carpimList: inputsHiddensCarpimList,
          girisList: hiddensGirisList);
    }

    print('Hiddens Giris List: $hiddensGirisList');

    hiddensCikisList.clear();

    if (selectedFunctions['Transfer Fonksiyonu'] == 'Sigmoid') {
      sigmoidFonksiyonu(
          list: hiddens,
          girisList: hiddensGirisList,
          cikisList: hiddensCikisList);
    } else if (selectedFunctions['Transfer Fonksiyonu'] == 'Tanjant') {
      tanjantHiperbolikFonksiyonu(
          list: hiddens,
          girisList: hiddensGirisList,
          cikisList: hiddensCikisList);
    } else if (selectedFunctions['Transfer Fonksiyonu'] == 'Eşik Değer') {
      tanjantHiperbolikFonksiyonu(
          list: hiddens,
          girisList: hiddensGirisList,
          cikisList: hiddensCikisList);
    } else if (selectedFunctions['Transfer Fonksiyonu'] == 'Adım/Step') {
      adimStepFonksiyonu(
          list: hiddens,
          girisList: hiddensGirisList,
          cikisList: hiddensCikisList);
    }

    print('Hiddens Çıkış List: $hiddensCikisList');
  }

  /////Bütün İşlemler / Hiddens-Outputs
  hiddensAndOutputsAllCalculations() {
    girisCarpiAgirlikCalc(
        list1: hiddens,
        list2: outputs,
        carpimList: hiddensOutputsCarpimList,
        weights: weightsHiddensOutputs);
    print('Hiddens-Outputs Çarpım List: $hiddensOutputsCarpimList');

    outputsGirisList.clear();

    if (selectedFunctions['Toplama Fonksiyonu'] == 'Toplam') {
      toplamFonksiyonu(
          list1: hiddens,
          list2: outputs,
          carpimList: hiddensOutputsCarpimList,
          girisList: outputsGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Çarpım') {
      carpimFonksiyonu(
          list1: hiddens,
          list2: outputs,
          carpimList: hiddensOutputsCarpimList,
          girisList: outputsGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Maksimum') {
      maksimumFonksiyonu(
          list1: hiddens,
          list2: outputs,
          carpimList: hiddensOutputsCarpimList,
          girisList: outputsGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Minimum') {
      minimumFonksiyonu(
          list1: hiddens,
          list2: outputs,
          carpimList: hiddensOutputsCarpimList,
          girisList: outputsGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Çoğunluk') {
      cogunlukFonksiyonu(
          list1: hiddens,
          list2: outputs,
          carpimList: hiddensOutputsCarpimList,
          girisList: outputsGirisList);
    } else if (selectedFunctions['Toplama Fonksiyonu'] == 'Kümülatif') {
      kumulatifToplamFonksiyonu(
          list1: hiddens,
          list2: outputs,
          carpimList: hiddensOutputsCarpimList,
          girisList: outputsGirisList);
    }

    print('Outputs Giris List: $outputsGirisList');

    outputsCikisList.clear();

    if (selectedFunctions['Transfer Fonksiyonu'] == 'Sigmoid') {
      sigmoidFonksiyonu(
          list: outputs,
          girisList: outputsGirisList,
          cikisList: outputsCikisList);
    } else if (selectedFunctions['Transfer Fonksiyonu'] == 'Tanjant') {
      tanjantHiperbolikFonksiyonu(
          list: outputs,
          girisList: outputsGirisList,
          cikisList: outputsCikisList);
    } else if (selectedFunctions['Transfer Fonksiyonu'] == 'Eşik Değer') {
      tanjantHiperbolikFonksiyonu(
          list: outputs,
          girisList: outputsGirisList,
          cikisList: outputsCikisList);
    } else if (selectedFunctions['Transfer Fonksiyonu'] == 'Adım/Step') {
      adimStepFonksiyonu(
          list: outputs,
          girisList: outputsGirisList,
          cikisList: outputsCikisList);
    }

    print('Outputs Çıkış List: $outputsCikisList');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BGBlurFilter(),
          Container(
            color: Colors.black.withOpacity(0.9),
            height: 400,
            width: size.width,
          ),
          Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF391326).withOpacity(0.9),
                    Colors.black.withOpacity(0.1)
                  ],
                ),
              ),
              height: 400,
              width: size.width,
            ),
          ),
          createLines(
              text: countInputsHiddens < (inputs.length * hiddens.length)
                  ? hintTextsInputsHiddens[1][countInputsHiddens]
                  : '?',
              list1: 'inputs',
              list2: 'hiddens'),
          createLines(
              text: countHiddens2Outputs < (hiddens2.length * outputs.length)
                  ? hintTextsHiddens2Outputs[1][countHiddens2Outputs]
                  : '?',
              list1: 'hiddens2',
              list2: 'outputs'),
          createLines(
              text: countHiddensHiddens2 < (hiddens.length * hiddens2.length)
                  ? hintTextsHiddensHiddens2[1][countHiddensHiddens2]
                  : '?',
              list1: 'hiddens',
              list2: 'hiddens2'),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              height: 400,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        createCircle(count: inputs.length, category: 'inputs'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: createCircle(
                        count: hiddens.length, category: 'hiddens'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: createCircle(
                        count: hiddens2.length, category: 'hiddens2'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: createCircle(
                        count: outputs.length, category: 'outputs'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 363,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(PageRouteBuilder(
                      opaque: false, // set to false
                      pageBuilder: (_, __, ___) => NeuralNetworkSolutionHome(),
                    ));
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset(
                      'assets/images/reload.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(PageRouteBuilder(
                      opaque: false, // set to false
                      pageBuilder: (_, __, ___) =>
                          NeuralNetworkSolutionResults(),
                    ));
                  },
                  child:
                      Icon(Icons.info_rounded, size: 30, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            top: 410,
            child: Container(
              height: 450,
              width: size.width,
              child: Flexible(
                flex: 1,
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  child: DraggableScrollbar.semicircle(
                    alwaysVisibleScrollThumb: false,
                    heightScrollThumb: 80,
                    labelTextBuilder: (offset) {
                      final int currentItem = _scrollController.hasClients
                          ? (_scrollController.offset /
                                  _scrollController.position.maxScrollExtent *
                                  expectedResults.length)
                              .floor()
                          : 0;
                      return Text("$currentItem");
                    },
                    controller: _scrollController,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        right: 5,
                        bottom: 30,
                        left: 5,
                      ),
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      controller: _scrollController,
                      itemCount: expectedResults.length,
                      itemBuilder: (context, index) {
                        int currentListIndex =
                            index % mainNormalizedMatrix[0].length;
                        int currentIteration =
                            (index / mainNormalizedMatrix[0].length).floor();

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 100,
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Step: ${currentListIndex + 1} / ${mainNormalizedMatrix[0].length}\nIteration: ${currentIteration + 1}\nError: ${allErrorsList[index].toStringAsFixed(10)}',
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                color: kPrimaryColor.withOpacity(0.8),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Expected:',
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${mainNormalizedMatrix[inputsCount + outputsCount - 1][currentListIndex].toStringAsFixed(10)}',
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                color: kSecondaryColor.withOpacity(0.8),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Result:',
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${expectedResults[index].toStringAsFixed(10)}',
                                          overflow: TextOverflow.fade,
                                          // textAlign: TextAlign.center,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
