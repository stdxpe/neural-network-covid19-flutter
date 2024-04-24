import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bg_blur_filter.dart';
import 'regresyon4.dart';
import '../x_y_inputfield.dart';

class Regresyon5 extends StatefulWidget {
  @override
  _Regresyon5State createState() => _Regresyon5State();
}

class _Regresyon5State extends State<Regresyon5> {
  TextEditingController _controllerX = TextEditingController();
  TextEditingController _controllerY = TextEditingController();

  bool isTextFieldSet = false;

  @override
  void dispose() {
    _controllerX.dispose();
    _controllerY.dispose();
    super.dispose();
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
                    height: 115,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   child: Image.asset(
                  //     'assets/images/ysa.gif',
                  //     fit: BoxFit.fill,
                  //     alignment: Alignment(0.0, 0),
                  //     // color: Colors.black.withOpacity(0.1),
                  //   ),
                  // ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      // borderRadius: kBorderRadiusProfile,
                    ),
                    child: XYInputField(
                      hintText: degiskenIsimleriX.last.toUpperCase(),
                      controller: _controllerX,
                      autoFocus: false,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      // borderRadius: kBorderRadiusProfile,
                    ),
                    child: XYInputField(
                      hintText: degiskenIsimleriY.last.toUpperCase(),
                      controller: _controllerY,
                      autoFocus: false,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          isTextFieldSet
                              ? 'Listenin ${bagimsizX.length}. elemanı\nkaydedildi.'
                              : '',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17,
                              // fontFamily: 'Montserrat-Bold',
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(28),
                        onTap: () {
                          bagimsizX.add(int.parse(_controllerX.text));
                          bagimliY.add(int.parse(_controllerY.text));

                          setState(() {
                            isTextFieldSet = true;
                          });

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
                  ),
                  SizedBox(
                    height: 180,
                  ),
                  InkWell(
                    onTap: () {
                      tahminX.add(int.parse(_controllerX.text));
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => Regresyon4(),
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
                            ))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 45.0, left: 15.0, right: 15.0),
                    child: Text(
                      'Dataset listenizden yola çıkarak veri tahmini yapmak için "Bağımsız Değişkeni" doldurup tıklayınız.',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.5,
                          // fontFamily: 'Montserrat-Bold',
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                      maxLines: 3,
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
