import 'dart:math';
import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:basit_dogrusal_regresyon_01/screens/basit_dogrusal_regresyon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bg_blur_filter.dart';
import '../x_y_inputfield.dart';

class Normalizasyon extends StatefulWidget {
  @override
  _NormalizasyonState createState() => _NormalizasyonState();
}

class _NormalizasyonState extends State<Normalizasyon> {
  TextEditingController _controller = TextEditingController();
  int cupertinoPickerSelectedItem = 0;
  bool normalizationVisibility = false;
  double normalizedValue = 0;

  @override
  void initState() {
    createNormalizedList(listNumber: 0);
    createNormalizedList(listNumber: 1);
    print(
        'norm değerimiz:  ${normalization(girisDegeri: 450.0, listNumber: 0)}');
    print(normalizedMatrix[0]);
    print(normalizedMatrix[1]);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    normalizedMatrix[0].clear();
    normalizedMatrix[1].clear();
    super.dispose();
  }

  double normalization({num girisDegeri, int listNumber}) {
    var tempMatrix = datasetMatrix[listNumber];
    var maxVar = tempMatrix.reduce(max).toDouble();
    var minVar = tempMatrix.reduce(min).toDouble();

    return (((girisDegeri.toDouble()) - minVar) / (maxVar - minVar));
  }

  void createNormalizedList({listNumber}) {
    for (var item in datasetMatrix[listNumber]) {
      normalizedMatrix[listNumber].add((normalization(
              girisDegeri: (item.toDouble()), listNumber: listNumber))
          .toDouble());
    }
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
                    'Datasetinize uygun şekilde normalize etmek istediğiniz değişkeni ve değerini giriniz.',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12.5,
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
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.grey.withOpacity(0.2)
                      ],
                    ),
                  ),
                  child: XYInputField(
                    hintText: '??',
                    controller: _controller,
                    autoFocus: true,
                  ),
                ),
                SizedBox(height: 20),
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
                            normalizationVisibility
                                ? 'Normalize edilmiş değer'
                                : '',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 200),
                            child: Text(
                              normalizationVisibility
                                  ? '${normalizedValue.toStringAsFixed(5)}'
                                  : '',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 25,
                                letterSpacing: 0,
                                height: 1.4,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        normalizedValue = normalization(
                            girisDegeri: double.parse(_controller.text),
                            listNumber: cupertinoPickerSelectedItem);
                        setState(() {
                          normalizationVisibility = true;
                        });
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
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 10),
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
                ), //
                SizedBox(
                  height: 15,
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
                                width: 100,
                                child: Center(
                                  child: Text(
                                    '${degiskenIsimleriX.last.toUpperCase()}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    '${degiskenIsimleriY.last.toUpperCase()}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
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
                          top: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        itemCount: normalizedMatrix[0].length,
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
                                      '${normalizedMatrix[0][index].toStringAsFixed(1)}',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
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
                                    child: Text(
                                      '${normalizedMatrix[1][index].toStringAsFixed(1)}',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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
          Positioned(
            left: 0,
            top: 125,
            child: SizedBox(
              width: 70,
              height: 280,
              child: CupertinoPicker(
                onSelectedItemChanged: (value) {
                  cupertinoPickerSelectedItem = value;
                },
                useMagnifier: true,
                itemExtent: 50,
                diameterRatio: 3,
                offAxisFraction: 6,
                looping: true,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    constraints: BoxConstraints(minHeight: 50, maxHeight: 50),
                    child: Text(
                      'X',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minHeight: 50, maxHeight: 50),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Y',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
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
