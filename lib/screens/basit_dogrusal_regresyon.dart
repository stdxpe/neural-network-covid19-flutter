import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:basit_dogrusal_regresyon_01/rounded_button.dart';
import 'package:basit_dogrusal_regresyon_01/screens/normalizasyon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../bg_blur_filter.dart';
import '../big_grey_container.dart';
import '../listile_mid.dart';
import '../listile_top.dart';
import 'basit_dogrusal_regresyon_data_ekle.dart';

class BasitDogrusalRegresyon extends StatefulWidget {
  @override
  _BasitDogrusalRegresyonState createState() => _BasitDogrusalRegresyonState();
}

class _BasitDogrusalRegresyonState extends State<BasitDogrusalRegresyon> {
  double a = 0,
      b = 0,
      xOrt = 0,
      yOrt = 0,
      xKarelerToplami = 0,
      toplamXCarpiY = 0;

  @override
  void initState() {
    bBulFonksiyonu();
    super.initState();
  }

  bBulFonksiyonu() {
    for (int i = 0; i < (datasetMatrix[0].length).toInt(); i++) {
      xOrt = (datasetMatrix[0][i] / datasetMatrix[0].length) + xOrt;
      yOrt = (datasetMatrix[1][i] / datasetMatrix[1].length) + yOrt;

      xKarelerToplami =
          (datasetMatrix[0][i] * datasetMatrix[0][i]) + xKarelerToplami;
      toplamXCarpiY =
          (datasetMatrix[0][i] * datasetMatrix[1][i]) + toplamXCarpiY;

      b = (toplamXCarpiY - (datasetMatrix[0].length * xOrt * yOrt)) /
          (xKarelerToplami - (datasetMatrix[0].length * xOrt * xOrt));

      a = yOrt - b * xOrt;
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
                  result: tahminMatrix[0].isEmpty
                      ? (datasetMatrix[0].isEmpty
                          ? '?'
                          : datasetMatrix[0].last.toString())
                      : tahminMatrix[0].last.toStringAsFixed(1),
                  photoUrl: 'ico2.png',
                ),
                SizedBox(
                  height: 10,
                ),
                ListileTop(
                  title: degiskenIsimleriY.last.toUpperCase(),
                  subtitle: 'Bağımlı Değişken - Y',
                  result: tahminMatrix[1].isEmpty
                      ? (datasetMatrix[1].isEmpty
                          ? '?'
                          : datasetMatrix[1].last.toString())
                      : tahminMatrix[1].last.toStringAsFixed(1),
                  photoUrl: 'ico3.png',
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: BigGreyContainer(
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
                                pageBuilder: (_, __, ___) =>
                                    BasitDogrusalRegresyonDataEkle(a: a, b: b),
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
                            degiskenIsimleriX.clear();
                            degiskenIsimleriY.clear();
                            degiskenIsimleriX.add('?');
                            degiskenIsimleriY.add('?');

                            datasetMatrix[0].clear();
                            datasetMatrix[1].clear();
                            tahminMatrix[0].clear();
                            tahminMatrix[1].clear();

                            normalizedMatrix[0].clear();
                            normalizedMatrix[1].clear();

                            Navigator.pop(context);
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) =>
                                    BasitDogrusalRegresyonDataEkle(
                                  a: 0,
                                  b: 0,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Icon(Icons.more_vert, color: Colors.white, size: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 30),
                        child: Text(
                          'Y = A + B * X\n\n B = ${b.toStringAsFixed(15)} \n A = ${a.toStringAsFixed(15)}',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
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
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) => Normalizasyon(),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 20,
                        ),
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
                          right: 30,
                          bottom: 30,
                        ),
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        itemCount: datasetMatrix[0].length ?? 1,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            key: Key(datasetMatrix[0].toString()),
                            background: Container(
                              width: 100,
                              color: Colors.red.withOpacity(0.5),
                              child: Padding(
                                padding: EdgeInsets.all(40.0),
                                child: SvgPicture.asset(
                                  'assets/images/close-icon.svg',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {
                                datasetMatrix[0].removeAt(index);
                                datasetMatrix[1].removeAt(index);
                                bBulFonksiyonu();
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    color: kPrimaryColor.withOpacity(0.8),
                                    child: Center(
                                        child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        '${datasetMatrix[0][index]}',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
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
                                        child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        '${datasetMatrix[1][index]}',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 25.0,
                          horizontal: 30,
                        ),
                        child: Text(
                          'İstediğiniz veriyi silmek için sola kaydırınız.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
