import 'dart:math';
import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bg_blur_filter.dart';
import '../x_y_inputfield.dart';
import 'file_utils.dart';
import 'neural_network_solution_home.dart';
import 'neural_network_solution_results.dart';

class NeuralNetworkSolution extends StatefulWidget {
  @override
  _NeuralNetworkSolutionState createState() => _NeuralNetworkSolutionState();
}

class _NeuralNetworkSolutionState extends State<NeuralNetworkSolution> {
  bool showCircularProgressIndicator = false;
  FocusNode _iterationFocusNode = FocusNode();
  final TextEditingController _controllerIteration = TextEditingController();
  String warningText = '';

  @override
  void initState() {
    super.initState();
    _controllerIteration.clear();
    warningText = '';
  }

  @override
  void dispose() {
    _controllerIteration.dispose();
    _iterationFocusNode.dispose();
    super.dispose();
  }

  /////////////////////////////////////////////
  ///Kronometre
  ///
  Stopwatch stopwatch = new Stopwatch();

  bool isStopwatchStarted = false;
  bool isDatasetParametersCorrect = true;
  bool isIterationSet = true;
  bool isDataSet = false;

  startStopWatch() {
    if (isStopwatchStarted) {
      stopwatch.start();
    }
  }

  recordTimeResult() {
    int elapsedTime = stopwatch.elapsedMilliseconds;

    timeResult = (elapsedTime / 1000).toStringAsFixed(2);
  }

  /////////////////////////////////////////////
  ///Normalizasyon
  ///
  void createNormalizedList({listNumber}) {
    for (var item in mainDatasetMatrix[listNumber]) {
      mainNormalizedMatrix[listNumber].add((normalization(
              girisDegeri: (item.toDouble()), listNumber: listNumber))
          .toDouble());
    }
  }

  double normalization({num girisDegeri, int listNumber}) {
    // var tempList = datasetMatrix[listNumber].toSet();
    var tempMatrix = mainDatasetMatrix[listNumber];
    var maxVar = tempMatrix.reduce(max).toDouble();
    var minVar = tempMatrix.reduce(min).toDouble();

    return (((girisDegeri.toDouble()) - minVar) / (maxVar - minVar));
  }

  //////////////////////////////////////////
  ///
  ///Random Ağırlık ve BIAS Değerleri Seçme
  Random random = new Random();

  createRandomNumber({double min, double max}) {
    double randomNumber = random.nextDouble() * (max - min) + min;
    // return double.parse(randomNumber.toStringAsFixed(2));
    return randomNumber.toStringAsFixed(2);

    //Kullanım Senaryosu:
    // String text = createRandomNumber(min: (-1.0), max: (1.0));
  }

  createRandomList({List list, int listLength, double min, double max}) {
    for (int i = 0; i < listLength; i++) {
      double randomNumber =
          double.parse(createRandomNumber(min: min, max: max));
      list.add(randomNumber);
    }
  }

  ////////////////////////////////TOPLAM FONKSİYONLARI//////////////////////////
  ///
  ///Toplam Fonksiyonları Hesaplama
  ///
  /////Input-Hiddens I * W çarpımları
  girisCarpiAgirlikCalcInputsHiddens(
      {int list1Count,
      int list2Count,
      List girisList,
      List carpimList,
      List weights,
      int iteration}) {
    carpimList.clear();
    for (int i = 0; i < list1Count * list2Count; i++) {
      // carpimList.add((weights[0][i] * weights[1][i]));
      carpimList.add((girisList[i % list1Count]
              [iteration % girisList[0].length] *
          weights[i]));
    }
  }

  /////Input-Hiddens I * W çarpımları
  girisCarpiAgirlikCalcHiddensOutputs({
    int list1Count,
    int list2Count,
    List girisList,
    List carpimList,
    List weights,
  }) {
    carpimList.clear();
    for (int i = 0; i < list1Count * list2Count; i++) {
      // carpimList.add((weights[0][i] * weights[1][i]));
      carpimList.add((girisList[i % list1Count] * weights[i]));
    }
  }

  /////Input-Hiddens I * W çarpımlarının toplamları
  toplamFonksiyonu(
      {int list1Count,
      int list2Count,
      List carpimList,
      List girisList,
      List biasList}) {
    // double toplam = 0;
    for (int i = 0; i < list1Count * list2Count; i = i + list1Count) {
      double toplam = 0;
      for (int j = 0; j < list1Count; j++) {
        toplam = carpimList[i + j] + toplam;
      }
      girisList.add(toplam);
    }
    print(
        'PRINT mainInputsHiddensToplamFonkList WITHOUT BIAS: $mainInputsHiddensToplamFonkList');
    if (isWithBias) {
      for (int i = 0; i < girisList.length; i++) {
        girisList[i] = girisList[i] + biasList[i];
      }
    }
  }

  ////////////////////////////////TRANSFER FONKSİYONLARI//////////////////////////
  ///
  ///Transfer Fonksiyonları Hesaplama
  ///
  sigmoidFonksiyonu({int list1Count, List girisList, List cikisList}) {
    for (int i = 0; i < list1Count; i++) {
      double sigmoid = 1 / (1 + pow(eSayisi, -girisList[i]));
      // print(sigmoid);
      cikisList.add(sigmoid);
    }
  }

////////////////////////////////GERİYE DOĞRU HESAPLAMA//////////////////////////
  ///
  ///Hata Hesaplama
  ///
  errorCalculation(
      {List beklenenList, List tahminData, List ciktiList, int iteration}) {
    for (int i = 0; i < outputsCount; i++) {
      // mainErrorList.add((beklenenList[2][iteration] - ciktiList[i]).abs()); //mutlak değer içine aldım ilk başta
      double error = (beklenenList[inputsCount + outputsCount - 1]
              [iteration % beklenenList[0].length] -
          ciktiList[i]);
      mainErrorList.add(error);
      allErrorsList.add(error);
    }
  }

  sigmaCalculation({List sigmaList, List ciktiList}) {
    for (int i = 0; i < outputsCount; i++) {
      double sigma = ciktiList[i] * (1 - ciktiList[i]) * mainErrorList[i];
      sigmaList.add(sigma);
    }
  }

  deltaWCalculationHO(
      {int list1Count, //soldaki hücre
      int list2Count, //sağdaki hücre
      List sigmaList,
      List ciktiList,
      List deltaHistory,
      List deltaWList}) {
    for (int i = 0; i < list2Count; i++) {
      for (int j = 0; j < list1Count; j++) {
        // double deltaW = (lambda * sigmaList[i] * ciktiList[j]) + (alpha * deltaHistory.last);  //Alfalı denedim.
        double deltaW = (lambda * sigmaList[i] * ciktiList[j]);
        deltaWList.add(deltaW);
      }
    }
  }

  deltaBiasCalculation({int count, List biasList, List sigmaList}) {
    for (int i = 0; i < count; i++) {
      double deltaBias = lambda * sigmaList[i];
      biasList.add(deltaBias);
    }
  }

  sigmaCalculationWithoutError({
    int list1Count,
    int list2Count,
    List weights,
    List sigmaSag,
    List sigmaSol,
    List ciktiList,
  }) {
    List toplamList = [];

    for (int i = 0; i < list1Count; i++) {
      double toplam = 0;
      int miniToplam = i;
      bool isFirstTime = true;

      for (int j = 0; j < list2Count; j++) {
        if (isFirstTime) {
          toplam = sigmaSag[j] * weights[i];
          isFirstTime = false;
        } else {
          miniToplam = miniToplam + list1Count;
          toplam = toplam + sigmaSag[j] * weights[miniToplam];
        }
      }
      toplamList.add(toplam); //hidden hücre sayısı kadar toplam
    }

    for (int i = 0; i < hiddensCount; i++) {
      double sigma = ciktiList[i] * (1 - ciktiList[i]) * toplamList[i];
      sigmaSol.add(sigma);
    }
  }

  deltaWCalculationIH(
      {int list1Count, //soldaki hücre
      int list2Count, //sağdaki hücre
      List sigmaList,
      List ciktiList,
      List deltaHistory,
      List deltaWList,
      int iteration}) {
    for (int i = 0; i < list2Count; i++) {
      for (int j = 0; j < list1Count; j++) {
        // double deltaW = (lambda * sigmaList[i] * ciktiList[j][iteration]) + (alpha * deltaHistory.last); //Alfalı denedim.
        double deltaW = (lambda *
            sigmaList[i] *
            ciktiList[j][iteration % ciktiList[0].length]);
        deltaWList.add(deltaW);
      }
    }
  }

  newWeightsUpdate() {
    for (int i = 0; i < mainWeightsInputsHiddens.length; i++) {
      mainWeightsInputsHiddens[i] =
          mainWeightsInputsHiddens[i] + mainDeltaWInputsHiddens[i];
    }

    for (int i = 0; i < mainBiasHiddens.length; i++) {
      mainBiasHiddens[i] = mainBiasHiddens[i] + mainDeltaBiasHiddens[i];
    }

    for (int i = 0; i < mainWeightsHiddensOutputs.length; i++) {
      mainWeightsHiddensOutputs[i] =
          mainWeightsHiddensOutputs[i] + mainDeltaWHiddensOutputs[i];
    }

    for (int i = 0; i < mainBiasOutputs.length; i++) {
      mainBiasOutputs[i] = mainBiasOutputs[i] + mainDeltaBiasOutputs[i];
    }
  }

  completedCalculations({int iteration}) {
    ////////////////////////////////INPUTS-HIDDENS BÜTÜN İŞLEMLER//////////////////////////
    ///
    ///

    girisCarpiAgirlikCalcInputsHiddens(
      list1Count: inputsCount,
      list2Count: hiddensCount,
      girisList: mainNormalizedMatrix,
      carpimList: mainInputsHiddensCarpimList,
      weights: mainWeightsInputsHiddens,
      iteration: iteration,
    );
    print('PRINT mainInputsHiddensCarpimList: $mainInputsHiddensCarpimList');

    toplamFonksiyonu(
      list1Count: inputsCount,
      list2Count: hiddensCount,
      carpimList: mainInputsHiddensCarpimList,
      girisList: mainInputsHiddensToplamFonkList,
      biasList: mainBiasHiddens,
    );
    print(
        'PRINT mainInputsHiddensToplamFonkList WITH BIAS: $mainInputsHiddensToplamFonkList');

    sigmoidFonksiyonu(
      list1Count: hiddensCount,
      girisList: mainInputsHiddensToplamFonkList,
      cikisList: mainInputsHiddensTransferFonkList,
    );

    print(
        'PRINT mainInputsHiddensTransferFonkList: $mainInputsHiddensTransferFonkList');

    ////////////////////////////////HIDDENS-OUTPUTS BÜTÜN İŞLEMLER//////////////////////////
    ///
    ///
    girisCarpiAgirlikCalcHiddensOutputs(
      list1Count: hiddensCount,
      list2Count: outputsCount,
      girisList: mainInputsHiddensTransferFonkList,
      carpimList: mainHiddensOutputsCarpimList,
      weights: mainWeightsHiddensOutputs,
    );
    print('PRINT mainHiddensOutputsCarpimList: $mainHiddensOutputsCarpimList');

    toplamFonksiyonu(
      list1Count: hiddensCount,
      list2Count: outputsCount,
      carpimList: mainHiddensOutputsCarpimList,
      girisList: mainHiddensOutputsToplamFonkList,
      biasList: mainBiasOutputs,
    );
    print(
        'PRINT mainHiddensOutputsToplamFonkList WITH BIAS: $mainHiddensOutputsToplamFonkList');

    sigmoidFonksiyonu(
      list1Count: outputsCount,
      girisList: mainHiddensOutputsToplamFonkList,
      cikisList: mainHiddensOutputsTransferFonkList,
    );

    print(
        'PRINT mainHiddensOutputsTransferFonkList: $mainHiddensOutputsTransferFonkList');
    errorCalculation(
      beklenenList: mainNormalizedMatrix,
      ciktiList: mainHiddensOutputsTransferFonkList,
      iteration: iteration,
    );
    print('PRINT mainErrorList: $mainErrorList');

    sigmaCalculation(
      sigmaList: mainSigmaOutputs,
      ciktiList: mainHiddensOutputsTransferFonkList,
    );

    print('PRINT mainSigmaOutputs: $mainSigmaOutputs');

    deltaWCalculationHO(
      list1Count: hiddensCount,
      list2Count: outputsCount,
      sigmaList: mainSigmaOutputs,
      ciktiList: mainInputsHiddensTransferFonkList,
      deltaHistory: mainDeltaWHistoryHO,
      deltaWList: mainDeltaWHiddensOutputs,
    );
    print('PRINT mainDeltaWHiddensOutputs: $mainDeltaWHiddensOutputs');

    deltaBiasCalculation(
        sigmaList: mainSigmaOutputs,
        biasList: mainDeltaBiasOutputs,
        count: outputsCount);
    print('PRINT mainDeltaBiasOutputs: $mainDeltaBiasOutputs');

    sigmaCalculationWithoutError(
      list1Count: hiddensCount,
      list2Count: outputsCount,
      sigmaSag: mainSigmaOutputs,
      sigmaSol: mainSigmaHiddens,
      weights: mainWeightsHiddensOutputs,
      ciktiList: mainInputsHiddensTransferFonkList,
    );
    print('PRINT mainSigmaHiddens: $mainSigmaHiddens');

    deltaWCalculationIH(
      list1Count: inputsCount,
      list2Count: hiddensCount,
      sigmaList: mainSigmaHiddens,
      ciktiList: mainNormalizedMatrix,
      // ciktiList: mainInputsHiddensTransferFonkList,
      deltaHistory: mainDeltaWHistoryIH,
      deltaWList: mainDeltaWInputsHiddens,
      iteration: iteration,
    );
    print('PRINT mainDeltaWInputsHiddens: $mainDeltaWInputsHiddens');

    deltaBiasCalculation(
      sigmaList: mainSigmaHiddens,
      biasList: mainDeltaBiasHiddens,
      count: hiddensCount,
    );
    print('PRINT mainDeltaBiasHiddens: $mainDeltaBiasHiddens');
    print(
        '//////PRINT ESKİ Giriş-Ara Ağırlıklar ESKİ mainWeightsInputsHiddens: $mainWeightsInputsHiddens');
    print('PRINT mainBiasHiddens: $mainBiasHiddens');
    print(
        '//////PRINT ESKİ Ara-Çıkış Ağırlıklar mainWeightsHiddensOutputs: $mainWeightsHiddensOutputs');
    print('PRINT mainBiasOutputs: $mainBiasOutputs');
    newWeightsUpdate();
    print(
        '///////PRINT Giriş-Ara Ağırlıklar mainWeightsInputsHiddens: $mainWeightsInputsHiddens');
    print('PRINT mainBiasHiddens: $mainBiasHiddens');
    print(
        '///////PRINT Ara-Çıkış Ağırlıklar mainWeightsHiddensOutputs: $mainWeightsHiddensOutputs');
    print('PRINT mainBiasOutputs: $mainBiasOutputs');

    // for(int i=0; i<mainNormalizedMatrix[0].length;i++){
    // allOutputsList.add(0);
    // }

    allOutputsList[iteration % mainNormalizedMatrix[0].length] =
        mainHiddensOutputsTransferFonkList.last;
  }

  double denormalization({num normGirisDegeri, int listNumber}) {
    // var tempList = datasetMatrix[listNumber].toSet();
    var tempMatrix = mainDatasetMatrix[listNumber];
    var maxVar = tempMatrix.reduce(max).toDouble();
    var minVar = tempMatrix.reduce(min).toDouble();

    return ((normGirisDegeri * (maxVar - minVar)) + minVar);
  }

  denormalizeOutputs({List outputs}) {
    for (int i = 0; i < outputs.length; i++) {
      double result = denormalization(
          normGirisDegeri: outputs[i],
          listNumber: (inputsCount + outputsCount - 1));
      allOutputsDenormalizedList.add(result);
    }
  }

  absoluteErrorCalculation({List expected, List outputs}) {
    double toplam = 0;
    List tempListAbsError = [];
    print('MAPE ERROR1 PATLAMADIK');
    for (int i = 0; i < outputs.length; i++) {
      tempListAbsError.add(
          (expected[inputsCount + outputsCount - 1][i] - outputs[i]).abs());
      toplam =
          (tempListAbsError[i] / expected[inputsCount + outputsCount - 1][i]) +
              toplam;
    }
    print('MAPE ERROR2 PATLAMADIK');
    percentageMAPEError =
        (toplam / expected[inputsCount + outputsCount - 1].length) * 100;
    print('MAPE ERROR : ${percentageMAPEError}');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String content = 'No Data';
    String path = 'No Path';

    int selectedIteration = 100;

    void showCircularProgressIndicatorMethod() {
      setState(() {
        showCircularProgressIndicator = true;
      });
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BGBlurFilter(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.1)
                  ],
                ),
              ),
              child: showCircularProgressIndicator != true
                  ? SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.13),
                          Text(
                            'Dataset\nYükleme',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 45,
                              height: 0.9,
                              letterSpacing: -1,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 30.0,
                              horizontal: 18,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Önceki adımda belirlediğiniz giriş ve çıkış katmanlarındaki hücre sayılarıyla uyumlu olan verilerinizi uygulamaya yükleyiniz. Şekilde 2 giriş hücresi ve 1 çıkış hücresi olan bir dataset örneği görülmektedir. Yükleyeceğiniz dosya örnekteki gibi, sütunları 1'er boşluk ile ayrılmış şekilde kaydedilmelidir. Ayrıca dosya formatı TXT olmalıdır.",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10.5,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  // height: 150,
                                  width: 150,
                                  child: Image.asset(
                                    'assets/images/dataset_ex.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.black.withOpacity(0.4),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: XYInputField(
                                          autoFocus: false,
                                          controller: _controllerIteration,
                                          focusNode: _iterationFocusNode,
                                          hintText: 'Iterasyon',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                warningText,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 25),
                              Padding(
                                padding: EdgeInsets.only(left: 100.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.of(context)
                                            .push(PageRouteBuilder(
                                          opaque: false, // set to false
                                          pageBuilder: (_, __, ___) =>
                                              NeuralNetworkSolutionHome(),
                                        ));
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: kBackgroundColor,
                                            radius: 28,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              child: SvgPicture.asset(
                                                'assets/images/reload.svg',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            'Yeniden Başla',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                    InkWell(
                                      onTap: () {
                                        mainDatasetMatrix.clear();
                                        mainNormalizedMatrix.clear();
                                        content = 'No Data';
                                        FileUtils.pickFile()
                                            .then((returnedPath) {
                                          setState(() {
                                            path = returnedPath;

                                            FileUtils.myReadFromFileMethod(path)
                                                .then((returnedContent) {
                                              setState(() {
                                                content = returnedContent;
                                              });
                                            });

                                            FileUtils.myTxtReadMethod(path)
                                                .then((returnedContent) {
                                              setState(() {
                                                if (isParametersCorrect &&
                                                    mainDatasetMatrix.length >
                                                        0) {
                                                  warningText =
                                                      "Yükleme başarılı!";
                                                } else if (isParametersCorrect ==
                                                    false) {
                                                  warningText =
                                                      "Dosya ve parametreler uyumlu değil!\nLütfen işleme yeniden başlayınız!";
                                                } else {
                                                  warningText =
                                                      "Lütfen tekrar deneyiniz!";
                                                }
                                                isDataSet = true;
                                              });
                                            });
                                          });
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: kPrimaryColor,
                                            radius: 28,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              child: SvgPicture.asset(
                                                'assets/images/upload.svg',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            'Cihazdan Yükle',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (isDataSet == true &&
                                                isParametersCorrect &&
                                                _controllerIteration
                                                    .text.isNotEmpty) {
                                              setState(() {
                                                isIterationSet = true;
                                              });

                                              selectedIteration = int.parse(
                                                  _controllerIteration.text);
                                              showCircularProgressIndicatorMethod();

                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                for (int i = 0;
                                                    i <
                                                        (inputsCount +
                                                            outputsCount);
                                                    i++) {
                                                  createNormalizedList(
                                                      listNumber: i);
                                                }

                                                print(
                                                    'PRINT Normalized Matrix: $mainNormalizedMatrix');

                                                mainWeightsInputsHiddens
                                                    .clear();
                                                mainWeightsHiddensOutputs
                                                    .clear();
                                                mainBiasHiddens.clear();
                                                mainBiasOutputs.clear();
                                                expectedResults.clear();
                                                allOutputsList.clear();
                                                allOutputsDenormalizedList
                                                    .clear();

                                                createRandomList(
                                                  list:
                                                      mainWeightsInputsHiddens,
                                                  listLength: inputsCount *
                                                      hiddensCount,
                                                  max: 1.0,
                                                  min: -1.0,
                                                );

                                                createRandomList(
                                                  list:
                                                      mainWeightsHiddensOutputs,
                                                  listLength: hiddensCount *
                                                      outputsCount,
                                                  max: 1.0,
                                                  min: -1.0,
                                                );
                                                createRandomList(
                                                  list: mainBiasHiddens,
                                                  listLength: hiddensCount,
                                                  max: 1.0,
                                                  min: 0.0,
                                                );
                                                createRandomList(
                                                  list: mainBiasOutputs,
                                                  listLength: outputsCount,
                                                  max: 1.0,
                                                  min: 0.0,
                                                );

                                                print(
                                                    'PRINT mainWeightsInputsHiddens: $mainWeightsInputsHiddens');
                                                print(
                                                    'PRINT mainWeightsHiddensOutputs: $mainWeightsHiddensOutputs');
                                                print(
                                                    'PRINT mainBiasHiddens: $mainBiasHiddens');
                                                print(
                                                    'PRINT mainBiasOutputs: $mainBiasOutputs');

                                                //çıktılar için boş data ekledik. amaç boyutu seçmek. sonra replace yapılacak.
                                                for (int i = 0;
                                                    i <
                                                        mainNormalizedMatrix[0]
                                                            .length;
                                                    i++) {
                                                  allOutputsList.add(0);
                                                }

                                                for (int i = 0;
                                                    i <
                                                        selectedIteration *
                                                            mainNormalizedMatrix[
                                                                    0]
                                                                .length;
                                                    i++) {
                                                  int currentListIndex = i %
                                                      mainNormalizedMatrix[0]
                                                          .length;
                                                  iterationCount =
                                                      selectedIteration;
                                                  totalComputationsCount = i;
                                                  stepsCount =
                                                      mainNormalizedMatrix[0]
                                                          .length;

                                                  print('///////');
                                                  print(
                                                      '///////////////////////////////PRINT DXPE $i.İTERASYON BAŞLADI /////////////////////////////// ');

                                                  // print(
                                                  //     '--------------PRINT DXPE HATA $i.İTERASYON HATA ORANI-------------- ');
                                                  print(
                                                      'PRINT DXPE $i.İTERASYON HATA: $mainErrorList');
                                                  print(
                                                      'PRINT DXPE $i.İTERASYON BEKLENEN SONUÇ: ${mainNormalizedMatrix[inputsCount + outputsCount - 1][currentListIndex]}');
                                                  print(
                                                      'PRINT DXPE $i.İTERASYON ÇIKAN SONUÇ: ${mainHiddensOutputsTransferFonkList}');

                                                  mainInputsHiddensCarpimList
                                                      .clear();
                                                  mainInputsHiddensToplamFonkList
                                                      .clear();
                                                  mainInputsHiddensTransferFonkList
                                                      .clear();

                                                  mainHiddensOutputsCarpimList
                                                      .clear();
                                                  mainHiddensOutputsToplamFonkList
                                                      .clear();
                                                  mainHiddensOutputsTransferFonkList
                                                      .clear();

                                                  mainErrorList.clear();

                                                  mainSigmaHiddens.clear();
                                                  mainSigmaOutputs.clear();

                                                  mainDeltaWInputsHiddens
                                                      .clear();
                                                  mainDeltaWHiddensOutputs
                                                      .clear();

                                                  mainDeltaBiasHiddens.clear();
                                                  mainDeltaBiasOutputs.clear();

                                                  print(
                                                      '///////////////////////////////PRINT DXPE $i.İTERASYON SONLANDI /////////////////////////////// ');

                                                  completedCalculations(
                                                      iteration: i);
                                                  isStopwatchStarted = true;
                                                  startStopWatch();

                                                  expectedResults.add(
                                                      mainHiddensOutputsTransferFonkList
                                                          .last);
                                                  // absoluteErrorList.add((mainErrorList.last).abs());

                                                }
                                                recordTimeResult();

                                                denormalizeOutputs(
                                                    outputs: allOutputsList);
                                                absoluteErrorCalculation(
                                                  expected: mainDatasetMatrix,
                                                  outputs:
                                                      allOutputsDenormalizedList,
                                                );

                                                Navigator.pop(context);
                                                Navigator.of(context)
                                                    .push(PageRouteBuilder(
                                                  opaque: false, // set to false
                                                  pageBuilder: (_, __, ___) =>
                                                      NeuralNetworkSolutionResults(),
                                                ));
                                              });
                                            } else {
                                              print(
                                                  'PRINT Hesaplama başarısız.');

                                              setState(() {
                                                isIterationSet = false;
                                                if (_controllerIteration
                                                    .text.isEmpty) {
                                                  warningText =
                                                      "Lütfen iterasyon sayısı giriniz!";
                                                } else if (isDataSet == false) {
                                                  warningText =
                                                      "Lütfen dosya yükleyiniz!";
                                                } else {
                                                  warningText =
                                                      'Bir hata oluştu.\nLütfen yeniden başlayınız!';
                                                }
                                              });
                                            }
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: kSecondaryColor,
                                            radius: 28,
                                            child: Icon(
                                              Icons.check,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          'Hesapla',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: Colors.black.withOpacity(0.3),
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.red[900],
                            ),
                            strokeWidth: 10,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'İşlem uzun sürebilir.\n\nLütfen bekleyiniz..',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
