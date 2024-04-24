import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:basit_dogrusal_regresyon_01/screens/basit_dogrusal_regresyon.dart';
import 'importFilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bg_blur_filter.dart';
import '../x_y_inputfield.dart';

class BasitDogrusalRegresyonDataEkle extends StatefulWidget {
  final double a;
  final double b;

  const BasitDogrusalRegresyonDataEkle(
      {Key key, @required this.a, @required this.b})
      : super(key: key);

  @override
  _BasitDogrusalRegresyonDataEkleState createState() =>
      _BasitDogrusalRegresyonDataEkleState();
}

class _BasitDogrusalRegresyonDataEkleState
    extends State<BasitDogrusalRegresyonDataEkle> {
  TextEditingController _controllerX = TextEditingController();
  TextEditingController _controllerY = TextEditingController();

  bool isTextFieldSet = false;
  FocusNode focusNodeX = FocusNode();
  FocusNode focusNodeY = FocusNode();

  double a, b;
  @override
  void initState() {
    a = widget.a;
    b = widget.b;
    super.initState();
  }

  @override
  void dispose() {
    _controllerX.dispose();
    _controllerY.dispose();
    focusNodeX.dispose();
    focusNodeY.dispose();
    super.dispose();
  }

  void setTextField() {
    setState(() {
      if (_controllerX != null && _controllerY != null) isTextFieldSet = true;
    });
  }

  /////Tahmin ekleme işlemi / X ve Y için
  ///
  void tahminMatrixElemanEkle() {
    if (_controllerX.text.isNotEmpty && _controllerY.text.isEmpty) {
      tahminMatrix[0].add(double.parse(_controllerX.text));
      tahminMatrix[1].add(a + (b * tahminMatrix[0].last.toDouble()));
    }
    if (_controllerX.text.isEmpty && _controllerY.text.isNotEmpty) {
      tahminMatrix[1].add(double.parse(_controllerY.text));
      tahminMatrix[0].add(((tahminMatrix[1].last - a) / b));
    }
    if ((_controllerX.text.isEmpty && _controllerY.text.isEmpty) ||
        (_controllerX.text.isNotEmpty && _controllerY.text.isNotEmpty)) {}
    print(tahminMatrix[0].last ?? 0);
    print(tahminMatrix[1].last ?? 0);
  }

  /////Data ekleme işlemi
  ///
  void dataEkle() {
    if (_controllerX.text.isNotEmpty && _controllerY.text.isNotEmpty) {
      datasetMatrix[0].add(double.parse(_controllerX.text));
      datasetMatrix[1].add(double.parse(_controllerY.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          BGBlurFilter(),
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Basit\nDoğrusal\nRegresyon',
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
                    height: 15,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 30.0, left: 25.0, right: 25.0),
                    child: Text(
                      'Datasetinize veri eklemek için bağımlı ve bağımsız değişken değerlerini giriniz.',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                    ),
                    child: XYInputField(
                      hintText: degiskenIsimleriX.last.toUpperCase(),
                      controller: _controllerX,
                      focusNode: focusNodeX,
                      autoFocus: true,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                    ),
                    child: XYInputField(
                      hintText: degiskenIsimleriY.last.toUpperCase(),
                      controller: _controllerY,
                      focusNode: focusNodeY,
                      autoFocus: true,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          isTextFieldSet
                              ? 'Listenin ${datasetMatrix[0].length}. elemanı\nkaydedildi.'
                              : '',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 17,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(28),
                        onTap: () {
                          setTextField();
                          FocusScope.of(context).requestFocus(focusNodeX);
                          dataEkle();
                          print(datasetMatrix[0].last);
                          print(datasetMatrix[1].last);
                          _controllerX.clear();
                          _controllerY.clear();
                        },
                        child: CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          radius: 28,
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.0, left: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) =>
                                    BasitDogrusalRegresyon(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: kTextFieldBgColor,
                            radius: 28,
                            child: Icon(
                              Icons.check,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 180,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          tahminMatrixElemanEkle();

                          Navigator.pop(context);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) =>
                                  BasitDogrusalRegresyon(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: kSecondaryColor,
                          radius: 28,
                          child: Container(
                            height: 25,
                            width: 25,
                            child: SvgPicture.asset(
                              'assets/images/magnifying-glass.svg',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) => ImportFilePage(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          radius: 28,
                          child: Container(
                            height: 25,
                            width: 25,
                            child: SvgPicture.asset(
                              'assets/images/download.svg',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 45.0, left: 25.0, right: 25.0),
                    child: Text(
                      'Datasetinizden yola çıkarak veri tahmini yapmak için yalnızca gerekli değişkeni doldurup soldaki büyüteç simgesine tıklayınız. Cihazınızdan dataset yüklemek için sağdaki simgeye tıklayınız.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.5,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 8,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
