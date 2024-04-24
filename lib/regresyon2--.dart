import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:basit_dogrusal_regresyon_01/regresyon3--.dart';
import 'package:basit_dogrusal_regresyon_01/standart_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Regresyon2 extends StatefulWidget {
  @override
  _Regresyon2State createState() => _Regresyon2State();
}

class _Regresyon2State extends State<Regresyon2> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text('Basit Doğrusal Regresyon'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bağımlı değişken ismini giriniz:',
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
            CupertinoButton(
              child: StandartText(text: 'Kaydet'),
              onPressed: () {
                degiskenIsimleriX.add(_controller.text);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => Regresyon3(),
                  ),
                );
              },
            ),

            // Text(
            //   '5',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            // Text(
            //   '5',
            //   style: Theme.of(context).textTheme.headline5,
            // ),
          ],
        ),
      ),
    );
  }
}
