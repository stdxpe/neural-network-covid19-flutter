import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:basit_dogrusal_regresyon_01/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bg_blur_filter.dart';
import '../big_grey_container.dart';
import '../listile_mid.dart';
import '../listile_top.dart';
import 'regresyon5.dart';
import 'regresyon6.dart';

class Regresyon4 extends StatefulWidget {
  @override
  _Regresyon4State createState() => _Regresyon4State();
}

class _Regresyon4State extends State<Regresyon4> {
  double a = 0,
      b = 0,
      xOrt = 0,
      yOrt = 0,
      xKarelerToplami = 0,
      toplamXCarpiY = 0,
      girilenX = 6,
      beklenenY = 0;

  void bBulFonksiyonu() {
    for (int i = 0; i < bagimsizX.length; i++) {
      xOrt = (bagimsizX[i] / bagimsizX.length) + xOrt;

      yOrt = (bagimliY[i] / bagimliY.length) + yOrt;

      xKarelerToplami = (bagimsizX[i] * bagimsizX[i]) + xKarelerToplami;
      toplamXCarpiY = (bagimsizX[i] * bagimliY[i]) + toplamXCarpiY;
    }

    b = (toplamXCarpiY - (bagimsizX.length * xOrt * yOrt)) /
        (xKarelerToplami - (bagimsizX.length * xOrt * xOrt));

    a = yOrt - b * xOrt;

    beklenenY = tahminX.isEmpty ? 0 : a + b * tahminX[tahminX.length - 1];
    print(xOrt);
    print(yOrt);
    print(xKarelerToplami);
    print(toplamXCarpiY);
    print(beklenenY);
  }

  @override
  void initState() {
    bBulFonksiyonu();
    super.initState();
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
                  height: 30,
                ),
                ListileTop(
                  title: degiskenIsimleriX.last.toUpperCase(),
                  subtitle: 'Bağımsız Değişken - X',
                  result: tahminX.isEmpty
                      ? bagimsizX.last.toString()
                      : tahminX.last.toString(),
                  photoUrl: 'ico2.png',
                ),
                SizedBox(
                  height: 10,
                ),
                ListileTop(
                  title: degiskenIsimleriY.last.toUpperCase(),
                  subtitle: 'Bağımlı Değişken - Y',
                  result: tahminX.isEmpty
                      ? bagimliY.last.toString()
                      : beklenenY.round().toString(),
                  photoUrl: 'ico3.png',
                ),
                Expanded(
                  child: ListView(
                    children: [
                      BigGreyContainer(
                        child: Column(
                          children: [
                            ListileMid(
                              title: 'Ortalama X',
                              result: '${xOrt.toStringAsFixed(2)}',
                              backgroundColor: Colors.red,
                            ),
                            ListileMid(
                              title: 'Ortalama Y',
                              result: '${yOrt.toStringAsFixed(2)}',
                              backgroundColor: Colors.purple,
                            ),
                            ListileMid(
                              title: 'X ^ 2 Toplamı ',
                              result: '${xKarelerToplami.toStringAsFixed(2)}',
                              backgroundColor: Colors.pink,
                            ),
                            ListileMid(
                              title: 'X * Y Toplamı',
                              result: '${toplamXCarpiY.toStringAsFixed(2)}',
                              backgroundColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: RoundedButton(
                          buttonText: 'EKLE',
                          color: kPrimaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) => Regresyon5(),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: RoundedButton(
                          buttonText: 'SIFIRLA',
                          color: kSecondaryColor,
                          onPressed: () {
                            // degiskenIsimleri.clear();
                            bagimsizX.clear();
                            bagimliY.clear();
                            // tahminX.clear();
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) => Regresyon5(),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 30),
                        child: Text(
                          'Y = A + B * X\n\n B = ${b.toStringAsFixed(15)} \n A = ${a.toStringAsFixed(15)}',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              // fontFamily: 'Montserrat-Bold',
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20),
                        child: Divider(
                          thickness: 2,
                          color: Colors.white12,
                        ),
                      ),
                      MaterialButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 30),
                          child: Text(
                            'Normalizasyon işlemi için tıklayınız.',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                // fontFamily: 'Montserrat-Bold',
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        splashColor: Colors.red,
                        // highlightColor: Colors.yellow,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) => Regresyon6(),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20),
                        child: Divider(
                          thickness: 2,
                          color: Colors.white12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30, bottom: 0),
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
                        padding: const EdgeInsets.only(right: 30, bottom: 30),
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        itemCount: bagimsizX.length,
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
                                    '${bagimsizX[index]}',
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
                                    '${bagimliY[index]}',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
