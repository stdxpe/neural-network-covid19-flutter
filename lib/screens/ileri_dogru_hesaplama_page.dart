import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../bg_blur_filter.dart';
import '../constants.dart';
import '../flex_listview_small.dart';
import '../painter.dart';
import '../x_y_inputfield.dart';

class IleriDogruHesaplamaPage extends StatefulWidget {
  @override
  _IleriDogruHesaplamaPageState createState() =>
      _IleriDogruHesaplamaPageState();
}

class _IleriDogruHesaplamaPageState extends State<IleriDogruHesaplamaPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  double esikDeger = 1.25;
  final Map _globalKeysMap = {};
  bool firstCalculationSet = false;
  int countInputsHiddens = 0;
  int countHiddensOutputs = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => getRelativePositionsOfCircles(category: 'inputs', list: inputs));
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        getRelativePositionsOfCircles(category: 'hiddens', list: hiddens));
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        getRelativePositionsOfCircles(category: 'outputs', list: outputs));
    WidgetsBinding.instance.addPostFrameCallback((_) => createLines());

    hintTextEditorInputsHiddens(list1: inputs, list2: hiddens);
    hintTextEditorHiddensOutputs(list1: hiddens, list2: outputs);
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
      painter: LinePainter(hintText: text, list1: list1, list2: list2),
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

  /////Hint Text'ler için String listeyi doldurur / Hiddens-Outputs
  hintTextEditorHiddensOutputs({List list1, List list2}) {
    for (int i = 0; i < list2.length; i++) {
      for (int j = 0; j < list1.length; j++) {
        hintTextsHiddensOutputs[0].add('H$j');
        hintTextsHiddensOutputs[1].add('H$j-O$i');
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BGBlurFilter(),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFF241332), Colors.black.withOpacity(0.1)],
                ),
              ),
              height: 400,
              width: size.width,
            ),
          ),
          countInputsHiddens < (inputs.length * hiddens.length)
              ? createLines(
                  text: countInputsHiddens < (inputs.length * hiddens.length)
                      ? hintTextsInputsHiddens[1][countInputsHiddens]
                      : '?',
                  list1: 'inputs',
                  list2: 'hiddens')
              : createLines(
                  text: countHiddensOutputs < (hiddens.length * outputs.length)
                      ? hintTextsHiddensOutputs[1][countHiddensOutputs]
                      : '?',
                  list1: 'hiddens',
                  list2: 'outputs'),

          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              // color: Colors.white60,
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
                        count: outputs.length, category: 'outputs'),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: 400,
          //   child: Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Container(
          //             alignment: Alignment.center,
          //             height: 50,
          //             width: size.width / 3,
          //             color: Colors.black.withOpacity(0.6),
          //             child: Text(
          //               'Inputs',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 15,
          //                   // fontFamily: 'Montserrat-Bold',
          //                   letterSpacing: 0,
          //                   fontWeight: FontWeight.normal),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //           Container(
          //             alignment: Alignment.center,
          //             height: 50,
          //             width: size.width / 3,
          //             color: Colors.black.withOpacity(0.5),
          //             child: Text(
          //               'Hiddens',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 15,
          //                   // fontFamily: 'Montserrat-Bold',
          //                   letterSpacing: 0,
          //                   fontWeight: FontWeight.normal),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //           Container(
          //             alignment: Alignment.center,
          //             height: 50,
          //             width: size.width / 3,
          //             color: Colors.black.withOpacity(0.4),
          //             child: Text(
          //               'Outputs',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 15,
          //                   // fontFamily: 'Montserrat-Bold',
          //                   letterSpacing: 0,
          //                   fontWeight: FontWeight.normal),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //         ],
          //       ),

          //       // Container(
          //       //   color: Colors.black.withOpacity(0.4),
          //       //   child: Padding(
          //       //     padding: EdgeInsets.symmetric(
          //       //       horizontal: 20.0,
          //       //       vertical: 20,
          //       //     ),
          //       //     child: Row(
          //       //       children: [
          //       //         Flexible(
          //       //           flex: 1,
          //       //           child: XYInputField(
          //       //             controller: _controller1,
          //       //             hintText: 'Giriş Hücre\nSayısı',
          //       //           ),
          //       //         ),
          //       //         Flexible(
          //       //           flex: 1,
          //       //           child: XYInputField(
          //       //             controller: _controller2,
          //       //             hintText: 'Ara Hücre\nSayısı',
          //       //           ),
          //       //         ),
          //       //       ],
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          Positioned(
            top: 420,
            child: Column(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.7),
                  height: 85,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: XYInputField(
                          controller: _controller1,
                          focusNode: focusNode1,
                          hintText: countInputsHiddens <
                                  (inputs.length * hiddens.length)
                              ? hintTextsInputsHiddens[0][countInputsHiddens]
                              : (countHiddensOutputs <
                                      (hiddens.length * outputs.length)
                                  ? hintTextsHiddensOutputs[0]
                                      [countHiddensOutputs]
                                  : 'Done'),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: XYInputField(
                          focusNode: focusNode2,
                          controller: _controller2,
                          hintText: countInputsHiddens <
                                  (inputs.length * hiddens.length)
                              ? hintTextsInputsHiddens[1][countInputsHiddens]
                              : (countHiddensOutputs <
                                      (hiddens.length * outputs.length)
                                  ? hintTextsHiddensOutputs[1]
                                      [countHiddensOutputs]
                                  : 'Done'),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context).requestFocus(focusNode1);

                            setState(() {
                              //count 0'dan count 11'e küçükeşite kadar gelmeli. 0-11 arası ekleme var. 11e eşitse count artmayacak.
                              if ((countInputsHiddens <
                                  (inputs.length * hiddens.length))) {
                                weightsInputsHiddens[0]
                                    .add(double.parse(_controller1.text));
                                weightsInputsHiddens[1]
                                    .add(double.parse(_controller2.text));
                                countInputsHiddens++;
                              } else if ((countHiddensOutputs <
                                  (hiddens.length * outputs.length))) {
                                weightsHiddensOutputs[0]
                                    .add(double.parse(_controller1.text));
                                weightsHiddensOutputs[1]
                                    .add(double.parse(_controller2.text));
                                countHiddensOutputs++;
                              }
                            });

                            print(countInputsHiddens);
                            print(weightsInputsHiddens[0]);
                            print(weightsInputsHiddens[1]);

                            if (countInputsHiddens ==
                                    (inputs.length * hiddens.length) &&
                                hiddensCikisList.isEmpty) {
                              inputsAndHiddensAllCalculations();
                            }

                            _controller1.clear();

                            if (countInputsHiddens ==
                                    inputs.length * hiddens.length &&
                                countHiddensOutputs !=
                                    hiddens.length * outputs.length &&
                                hiddensCikisList.isNotEmpty) {
                              _controller1.text = hiddensCikisList[
                                      countHiddensOutputs % hiddens.length]
                                  .toStringAsFixed(2);
                              FocusScope.of(context).requestFocus(focusNode2);
                            }
                            _controller2.clear();
                          },
                          child: CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            radius: 28,
                            child: Container(
                                child: Icon(
                              Icons.add,
                              size: 35,
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            if (_controller1.text.isEmpty) {
                              _controller1.text =
                                  createRandomNumber(min: (0.0), max: (1.0));
                            }
                            _controller2.text =
                                createRandomNumber(min: (-1.0), max: (1.0));
                          },
                          child: CircleAvatar(
                            // backgroundColor: Color(0xFF004976),
                            backgroundColor: Colors.deepPurple,
                            radius: 28,
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                'assets/images/dice5.png',
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              inputsAndHiddensAllCalculations();
                              FocusScope.of(context).unfocus();
                              hiddensAndOutputsAllCalculations();
                              FocusScope.of(context).unfocus();
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: kSecondaryColor,
                            radius: 28,
                            child: Container(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                'assets/images/arrow-right.svg',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          firstCalculationSet
              ? Positioned(
                  top: 530,
                  child: Container(
                    height: 330,
                    width: size.width,
                    child: Row(
                      children: [
                        FlexListViewSmall(
                          color: Colors.red.withOpacity(0.8),
                          // itemCount: weights[0].length,
                          itemCount: inputs.length,
                          height: 100, fontSize: 10,
                          function: (index) {
                            return 'I$index Giriş\n${weightsInputsHiddens[0][index]}';
                          },
                        ),
                        FlexListViewSmall(
                          color: Colors.red.withOpacity(0.6),
                          itemCount: weightsInputsHiddens[1].length,
                          height: 100,
                          fontSize: 10,
                          function: (index) {
                            return '${hintTextsInputsHiddens[1][index]}\n${index + 1}.Ağırlık\n${weightsInputsHiddens[1][index]}';
                          },
                        ),
                        FlexListViewSmall(
                          color: Colors.red.withOpacity(0.8),
                          itemCount: hiddensGirisList.length,
                          height: 100,
                          fontSize: 8.5,
                          function: (index) {
                            return 'H$index Giriş\n${selectedFunctions['Toplama Fonksiyonu']}\n${hiddensGirisList[index].toStringAsFixed(4)}';
                          },
                        ),
                        FlexListViewSmall(
                          color: Colors.red.withOpacity(0.6),
                          itemCount: hiddensCikisList.length,
                          height: 100,
                          fontSize: 10,
                          function: (index) {
                            return 'H$index Çıkış\n${selectedFunctions['Transfer Fonksiyonu']}\n${hiddensCikisList[index].toStringAsFixed(4)}';
                          },
                        ),
                        FlexListViewSmall(
                          color: Colors.red.withOpacity(0.8),
                          itemCount: weightsHiddensOutputs[1].length,
                          height: 100,
                          fontSize: 10,
                          function: (index) {
                            return '${hintTextsHiddensOutputs[1][index]}\n${index + 1}.Ağırlık\n${weightsHiddensOutputs[1][index]}';
                          },
                        ),
                        FlexListViewSmall(
                          color: Colors.red.withOpacity(0.6),
                          itemCount: outputsGirisList.length,
                          height: 100,
                          fontSize: 8.5,
                          function: (index) {
                            return 'O$index Giriş\n${selectedFunctions['Toplama Fonksiyonu']}\n${outputsGirisList[index].toStringAsFixed(4)}';
                          },
                        ),
                        FlexListViewSmall(
                          color: Colors.red.withOpacity(0.8),
                          itemCount: outputsCikisList.length,
                          height: 100,
                          fontSize: 10,
                          function: (index) {
                            return 'O$index Çıkış\n${selectedFunctions['Transfer Fonksiyonu']}\n${outputsCikisList[index].toStringAsFixed(4)}';
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
