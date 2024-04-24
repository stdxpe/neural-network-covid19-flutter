import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:basit_dogrusal_regresyon_01/rounded_button.dart';
import 'package:basit_dogrusal_regresyon_01/rounded_input_field.dart';
import 'package:basit_dogrusal_regresyon_01/screens/neural_loading_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bg_blur_filter.dart';
import 'basit_dogrusal_regresyon.dart';

class Regresyon1 extends StatefulWidget {
  @override
  _Regresyon1State createState() => _Regresyon1State();
}

String message = '';

class _Regresyon1State extends State<Regresyon1> {
  TextEditingController _controllerX = TextEditingController();
  TextEditingController _controllerY = TextEditingController();

  bool isTextFieldSet = false;
  bool isSaved = false;

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
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 140),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
                    child: Text(
                      'Lütfen hesaplamak istediğiniz bağımlı ve bağımsız değişken isimlerini giriniz.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RoundedInputField(
                    hintText: 'Bağımsız Değişken',
                    controller: _controllerX,
                    icon: Icon(
                      Icons.close,
                    ),
                  ),
                  RoundedInputField(
                    hintText: 'Bağımlı Değişken',
                    controller: _controllerY,
                    icon: Icon(
                      Icons.adjust,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RoundedButton(
                    buttonText: 'KAYDET',
                    color: kPrimaryColor,
                    onPressed: () {
                      setState(() {
                        if ((_controllerX.text.isNotEmpty &&
                            (_controllerY.text.isNotEmpty))) {
                          degiskenIsimleriX.add(_controllerX.text);
                          degiskenIsimleriY.add(_controllerY.text);

                          isSaved = true;
                          message = 'Kaydedildi!';
                        } else if ((_controllerX.text.isEmpty &&
                            (_controllerY.text.isEmpty))) {
                          message = 'Lütfen değişkenleri doldurunuz!';
                        }
                      });
                    },
                  ),
                  RoundedButton(
                      buttonText: 'HESAPLA',
                      color: kSecondaryColor,
                      onPressed: () {
                        if (isSaved) {
                          message = '';
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) =>
                                  NeuralLoadingAnimation(
                                whereTo: BasitDogrusalRegresyon(),
                                duration: 5000,
                              ),
                            ),
                          );
                        } else if (_controllerX.text.isEmpty &&
                            _controllerY.text.isEmpty) {
                          setState(() {
                            message = 'Lütfen değişkenleri doldurunuz!';
                          });
                        } else {
                          setState(() {
                            message = 'Lütfen değişkenleri kaydediniz!';
                          });
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
