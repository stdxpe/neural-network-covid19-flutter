import 'package:basit_dogrusal_regresyon_01/bg_blur_filter.dart';
import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:basit_dogrusal_regresyon_01/screens/ileri_dogru_hesaplama_multi_hiddens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../rounded_button.dart';
import '../x_y_inputfield.dart';

class IleriDogruHesaplamaHome extends StatefulWidget {
  @override
  _IleriDogruHesaplamaHomeState createState() =>
      _IleriDogruHesaplamaHomeState();
}

class _IleriDogruHesaplamaHomeState extends State<IleriDogruHesaplamaHome> {
  final TextEditingController _controllerInput = TextEditingController();
  final TextEditingController _controllerHidden = TextEditingController();
  final TextEditingController _controllerOutput = TextEditingController();

  int toplamFuncSelected = 0;
  int transferFuncSelected = 0;

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
              // height: 1,
              // letterSpacing: -1,
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        // alignment: Alignment.topCenter,
        children: [
          BGBlurFilter(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 125,
                    ),
                    Text(
                      'İleri Doğru\nHesaplama',
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
                    SizedBox(
                      height: 180,
                    ),
                    // ListileTop(
                    //   title: 'TITLE',
                    //   subtitle: 'Bağımsız Değişken - X',
                    //   result: '132',
                    //   photoUrl: 'ico2.png',
                    // ),
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
                                hintText: 'Giriş Hücre\nSayısı',
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: XYInputField(
                                controller: _controllerHidden,
                                hintText: 'Ara Hücre\nSayısı',
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: XYInputField(
                                controller: _controllerOutput,
                                hintText: 'Çıkış Hücre\nSayısı',
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
                                // squeeze: 2,
                                // useMagnifier: true,
                                itemExtent: 70,
                                diameterRatio: 1.1,
                                // magnification: 1.05,
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

                                // squeeze: 1.5,
                                useMagnifier: true,
                                itemExtent: 70,
                                diameterRatio: 1.1,
                                // magnification: 1.02,
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
                      height: 30,
                    ),
                    RoundedButton(
                      buttonText: 'Model Yarat',
                      color: kPrimaryColor,
                      onPressed: () {
                        inputs.clear();
                        hiddens.clear();
                        outputs.clear();
                        // selectedFunctions.clear();

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
                            i < int.parse(_controllerOutput.text);
                            i++) {
                          outputs.add(0);
                        }

                        // selectedFunctions[0]
                        //     .add(toplamaFuncList[toplamFuncSelected]);
                        // selectedFunctions[1]
                        //     .add(transferFuncList[transferFuncSelected]);
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
                                // NeuralNetworkSolution(),
                                // IleriDogruHesaplamaPage(),
                                IleriDogruHesaplamaMultiHiddens(),
                            // IleriDogruHesaplamaSliverAppBar(),
                          ),
                        );
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
