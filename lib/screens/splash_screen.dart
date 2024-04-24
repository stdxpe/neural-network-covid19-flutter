import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../video_background.dart';
import 'package:basit_dogrusal_regresyon_01/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          VideoBG(),
          Container(
            height: size.height,
            width: double.infinity,
            child: Image.asset(
              'assets/images/12.png',
              fit: BoxFit.cover,
              alignment: Alignment(0.0, 0),
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.pink.withOpacity(0.1)
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'COVID19',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 60,
                      letterSpacing: -5,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Yapay Sinir Ağları',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.5,
                    // fontFamily: 'Montserrat-Bold',
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: 60,
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0, bottom: 150.0),
                  child: Text(
                    'PROJE  :  Çok Katmanlı YSA Mimarisi',
                    style: TextStyle(
                      color: Colors.white54,
                      // fontFamily: 'Montserrat-Medium',
                      fontSize: 11,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false, // set to false for transparent videoBG
                      pageBuilder: (_, __, ___) => OnBoardingPage(),
                    ),
                  );
                },
                child: Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.red.withOpacity(0.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
