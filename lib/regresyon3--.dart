import 'package:basit_dogrusal_regresyon_01/standart_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'listile_mid.dart';

class Regresyon3 extends StatefulWidget {
  @override
  _Regresyon3State createState() => _Regresyon3State();
}

class _Regresyon3State extends State<Regresyon3> {
  TextEditingController _controller = TextEditingController();

  List<int> bagimsizX = [2, 12, 5, 10, 0];

  List<int> bagimliY = [30, 65, 50, 80, 10];
  var list = [
    {'id': "123123", "date": "20/08/2016"},
    {'id': "123124", "date": "26/08/2016"},
    {'id': "123125", "date": "26/08/2016"}
  ];

  var list2 = [
    {'x': "123123", "y": "20/08/2016"},
    {'x': "123124", "y": "26/08/2016"},
    {'x': "123125", "y": "26/08/2016"}
  ];

  double a = 0,
      b = 0,
      xOrt = 0,
      yOrt = 0,
      xKarelerToplami = 0,
      toplamXCarpiY = 0,
      girilenX = 6,
      beklenenY = 0;

  void bBulFonksiyonu() {
    for (int i = 0; i < 5; i++) {
      xOrt = (bagimsizX[i] / bagimsizX.length) + xOrt;

      yOrt = (bagimliY[i] / bagimliY.length) + yOrt;

      xKarelerToplami = (bagimsizX[i] * bagimsizX[i]) + xKarelerToplami;
      toplamXCarpiY = (bagimsizX[i] * bagimliY[i]) + toplamXCarpiY;
    }

    b = (toplamXCarpiY - (bagimsizX.length * xOrt * yOrt)) /
        (xKarelerToplami - (bagimsizX.length * xOrt * xOrt));

    a = yOrt - b * xOrt;

    beklenenY = a + b * girilenX;
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text('Basit Doğrusal Regresyon'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$xOrt',
            ),
            Text(
              '$yOrt',
            ),
            Text(
              '$xKarelerToplami',
            ),
            Text(
              '$toplamXCarpiY',
            ),
            Text(
              '$b',
            ),
            Text(
              '$a',
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: TextField(
                controller: _controller,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Table(
                    border: TableBorder.all(color: Colors.black),
                    columnWidths: {
                      0: FixedColumnWidth(100.0),
                      1: FixedColumnWidth(100.0)
                    },
                    children: [
                      for (var item in bagimsizX)
                        TableRow(children: [
                          Text(
                            item.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                    ]),
                Table(
                    border: TableBorder.all(color: Colors.black),
                    columnWidths: {
                      0: FixedColumnWidth(100.0),
                      1: FixedColumnWidth(100.0)
                    },
                    children: [
                      for (var item in bagimliY)
                        TableRow(children: [
                          Text(
                            item.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                    ]),
              ],
            ),
            SizedBox(
              height: 100.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Table(
                    border: TableBorder.all(color: Colors.black),
                    columnWidths: {
                      0: FixedColumnWidth(100.0),
                      1: FixedColumnWidth(100.0)
                    },
                    children: [
                      for (var item in list)
                        TableRow(children: [
                          Text(
                            item['id'],
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            item['date'],
                            textAlign: TextAlign.center,
                          ),
                        ])
                    ]),
              ],
            ),
            SizedBox(
              height: 100.0,
            ),
            CupertinoButton(
              child: StandartText(text: 'Kaydet'),
              onPressed: () {
                setState(() {
                  bBulFonksiyonu();
                });
                // degiskenIsimleri.add(_controller.text);
                // Navigator.push(
                //   context,
                //   new MaterialPageRoute(
                //     builder: (context) => Regresyon3(),
                //   ),
                // );
              },
            ),

            // Text(
            //   '5',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            // Text(
            //   '5',
            //   style: Theme.of(context).textTheme.headline5,
            // ),BigGreyContainer(
            Column(
              children: [
                ListileMid(
                  title: 'Ortalama X',
                  result: '5.8',
                  backgroundColor: Colors.red,
                ),
                ListileMid(
                  title: 'Ortalama Y',
                  result: '47',
                  backgroundColor: Colors.purple,
                ),
                ListileMid(
                  title: 'X ^ 2 Toplamı ',
                  result: '273',
                  backgroundColor: Colors.pink,
                ),
                ListileMid(
                  title: 'X * Y Toplamı',
                  result: '1078',
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
            GridView.count(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                Container(
                  color: Colors.blueAccent,
                ),
                Container(
                  color: Colors.blueAccent,
                ),
                Container(
                  color: Colors.blueAccent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
