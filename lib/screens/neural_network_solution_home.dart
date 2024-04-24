import 'package:basit_dogrusal_regresyon_01/bg_blur_filter.dart';
import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:basit_dogrusal_regresyon_01/screens/neural_network_solution.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../rounded_button.dart';
import '../x_y_inputfield.dart';
import 'neural_loading_animation.dart';

class NeuralNetworkSolutionHome extends StatefulWidget {
  @override
  _NeuralNetworkSolutionHomeState createState() =>
      _NeuralNetworkSolutionHomeState();
}

class _NeuralNetworkSolutionHomeState extends State<NeuralNetworkSolutionHome> {
  final TextEditingController _controllerInput = TextEditingController();
  final TextEditingController _controllerHidden = TextEditingController();
  final TextEditingController _controllerHidden2 = TextEditingController();
  final TextEditingController _controllerOutput = TextEditingController();

  int toplamFuncSelected = 0;
  int transferFuncSelected = 0;
  bool isTextFieldsAllSet = true;

  @override
  void dispose() {
    _controllerInput.dispose();
    _controllerHidden.dispose();
    _controllerHidden2.dispose();
    _controllerOutput.dispose();
    super.dispose();
  }

  List<String> toplamaFuncList = [
    'Toplam',
    'Çarpım',
    'Maksimum',
    'Minimum',
    'Çoğunluk',
    'Kümülatif'
  ];
  List<String> transferFuncList = [
    'Sigmoid',
    'Adım/Step',
    'Tanjant',
    'Eşik Değer',
  ];

  List<Widget> createFuncList({List list}) {
    List<Widget> tempList = [];
    for (int i = 0; i < list.length; i++) {
      tempList.add(
        Container(
          padding: EdgeInsets.only(top: 10),
          constraints: BoxConstraints(minHeight: 50, maxHeight: 50),
          child: Text(
            list[i],
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      );
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BGBlurFilter(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.10,
                    ),
                    Text(
                      'Yapay\nSinir\nAğları',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 50,
                        height: 0.9,
                        letterSpacing: -1,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 22.2,
                      ),
                      child: Text(
                        "Bu adımda, birazdan yükleyeceğiniz datasete ait giriş ve çıkış katmanlarındaki hücre sayılarını doğru girmeniz gerekmektedir. Aksi takdirde uygulama çıktı vermeyecektir. Ara katmanlardaki hücre sayılarını ise ideal işlem süresi için 2-8 arasında seçebilirsiniz. Ayrıca uygulamada çıkış katmanında izin verilen hücre sayısı 1 ile sınırlı tutulmuştur. Bu yüzden mutlaka çıktı sayısı 1 olan dataset seçilmelidir. Hücre sayılarını belirledikten sonra hesaplamalarda kullanılacak Toplam/Transfer fonksiyonlarını seçiniz.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.4),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20,
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: XYInputField(
                                controller: _controllerInput,
                                hintText: 'Giriş\nHücre',
                                autoFocus: true,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: XYInputField(
                                controller: _controllerHidden,
                                hintText: 'Ara\nHücre',
                                autoFocus: true,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: XYInputField(
                                controller: _controllerHidden2,
                                hintText: 'Ara\nHücre',
                                autoFocus: true,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: XYInputField(
                                controller: _controllerOutput,
                                hintText: 'Çıkış\nHücre',
                                autoFocus: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: 150,
                              width: 250,
                              child: CupertinoPicker(
                                onSelectedItemChanged: (value) {
                                  toplamFuncSelected = value;
                                },
                                itemExtent: 70,
                                diameterRatio: 1.1,
                                offAxisFraction: 0,
                                looping: true,
                                children: createFuncList(list: toplamaFuncList),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: 150,
                              width: 250,
                              child: CupertinoPicker(
                                onSelectedItemChanged: (value) {
                                  transferFuncSelected = value;
                                },
                                useMagnifier: true,
                                itemExtent: 70,
                                diameterRatio: 1.1,
                                offAxisFraction: 0,
                                looping: true,
                                children:
                                    createFuncList(list: transferFuncList),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      isTextFieldsAllSet
                          ? ''
                          : 'Lütfen hücre sayılarını doldurunuz!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent.withOpacity(1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      buttonText: 'Model Yarat',
                      color: kPrimaryColor,
                      onPressed: () {
                        if (_controllerInput.text.isEmpty ||
                            _controllerHidden.text.isEmpty ||
                            _controllerHidden2.text.isEmpty ||
                            _controllerOutput.text.isEmpty) {
                          print("PRINTED Lütfen hücre sayılarını doldurunuz!");

                          setState(() {
                            isTextFieldsAllSet = false;
                          });
                        } else {
                          print(
                              "PRINTED Hücre sayıları dolduruldu, hesaplamaya geçiliyor.");

                          setState(() {
                            isTextFieldsAllSet = true;
                          });
                          inputs.clear();
                          hiddens.clear();
                          hiddens2.clear();
                          outputs.clear();

                          for (int i = 0;
                              i < int.parse(_controllerInput.text);
                              i++) {
                            inputs.add(0);
                          }
                          for (int i = 0;
                              i < int.parse(_controllerHidden.text);
                              i++) {
                            hiddens.add(0);
                          }
                          for (int i = 0;
                              i < int.parse(_controllerHidden2.text);
                              i++) {
                            hiddens2.add(0);
                          }
                          for (int i = 0;
                              i < int.parse(_controllerOutput.text);
                              i++) {
                            outputs.add(0);
                          }

                          inputsCount = int.parse(_controllerInput.text);
                          hiddensCount = int.parse(_controllerHidden.text);
                          outputsCount = int.parse(_controllerOutput.text);

                          selectedFunctions['Toplama Fonksiyonu'] =
                              toplamaFuncList[toplamFuncSelected];
                          selectedFunctions['Transfer Fonksiyonu'] =
                              transferFuncList[transferFuncSelected];

                          print(inputs);
                          print(hiddens);
                          print(outputs);
                          print(selectedFunctions['Toplama Fonksiyonu']);
                          print(selectedFunctions['Transfer Fonksiyonu']);

                          Navigator.pop(context);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) =>
                                  NeuralLoadingAnimation(
                                whereTo: NeuralNetworkSolution(),
                                duration: 3000,
                              ),
                            ),
                          );
                        }
                      },
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
