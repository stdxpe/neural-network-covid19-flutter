import 'dart:math';

import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bg_blur_filter.dart';
import 'regresyon4.dart';
import '../x_y_inputfield.dart';

class Regresyon6 extends StatefulWidget {
  @override
  _Regresyon6State createState() => _Regresyon6State();
}

class _Regresyon6State extends State<Regresyon6> {
  TextEditingController _controllerX = TextEditingController();

  bool isTextFieldSet = false;
  @override
  void initState() {
    for (var item in bagimsizX) {
      normalizedXList.add(normalizasyonInitStateFuncX(item));
    }
    for (var item in bagimliY) {
      normalizedYList.add(normalizasyonInitStateFuncY(item));
    }
    super.initState();
  }

  @override
  void dispose() {
    _controllerX.dispose();
    normalizedXList.clear();
    normalizedYList.clear();
    super.dispose();
  }

  double xNormalizedInitStateVar = 0;
  double yNormalizedInitStateVar = 0;
  double xNormalized = 0;

  bool normalizasyonVisible = false;

  double normalizasyonInitStateFuncX(int girisDegeri) {
    setState(() {
      xNormalizedInitStateVar =
          (girisDegeri - bagimsizX.fold(bagimsizX[0], min)) /
              ((bagimsizX.fold(bagimsizX[0], max)) -
                  (bagimsizX.fold(bagimsizX[0], min)));
    });
    return xNormalizedInitStateVar;
  }

  double normalizasyonInitStateFuncY(int girisDegeri) {
    setState(() {
      yNormalizedInitStateVar =
          (girisDegeri - bagimliY.fold(bagimliY[0], min)) /
              ((bagimliY.fold(bagimliY[0], max)) -
                  (bagimliY.fold(bagimliY[0], min)));
    });
    return yNormalizedInitStateVar;
  }

  void normalizasyon(int girisDegeri) {
    setState(() {
      xNormalized = (girisDegeri - bagimsizX.fold(bagimsizX[0], min)) /
          ((bagimsizX.fold(bagimsizX[0], max)) -
              (bagimsizX.fold(bagimsizX[0], min)));
      normalizasyonVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          BGBlurFilter(),
          Align(
            // alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 120.0),
                  child: Text(
                    'Normalizasyon',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 35,
                      height: 0.9,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 30.0, left: 25.0, right: 25.0),
                  child: Text(
                    'Verilerinize uygun şekilde normalize etmek istediğiniz Bağımsız Değişken değerini giriniz.',
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12.5,
                        // fontFamily: 'Montserrat-Bold',
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    softWrap: true,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.black.withOpacity(0),
                        Colors.grey.withOpacity(0.2)
                      ])),
                  child: XYInputField(
                    hintText: degiskenIsimleriX.last.toUpperCase(),
                    controller: _controllerX,
                    autoFocus: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            normalizasyonVisible
                                ? 'Normalize edilmiş değer'
                                : '',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                // height: 0
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            normalizasyonVisible
                                ? '${xNormalized.toStringAsFixed(5)}'
                                : '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                letterSpacing: 0,
                                height: 1.4,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        normalizasyon((int.parse(_controllerX.text)));
                      },
                      child: CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          radius: 28,
                          child: Container(
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset(
                                'assets/images/reload.svg',
                                color: Colors.white,
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) => Regresyon4(),
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
                ), //
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Divider(
                    thickness: 2,
                    color: Colors.white12,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                //height: 30,
                                width: 100,
                                // color: kPrimaryColor.withOpacity(0.8),
                                child: Center(
                                  child: Text(
                                    '${degiskenIsimleriX.last.toUpperCase()}',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                // height: 30,
                                width: 100,
                                // color: kPrimaryColor.withOpacity(0.8),
                                child: Center(
                                  child: Text(
                                    '${degiskenIsimleriY.last.toUpperCase()}',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            top: 20, right: 20, bottom: 20),
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        itemCount: normalizedXList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: kPrimaryColor.withOpacity(0.8),
                                  child: Center(
                                      child: Text(
                                    '${normalizedXList[index].toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: kSecondaryColor.withOpacity(0.8),
                                  child: Center(
                                      child: Text(
                                    '${normalizedYList[index].toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
