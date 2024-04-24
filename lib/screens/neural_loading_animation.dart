import 'package:flutter/material.dart';

class NeuralLoadingAnimation extends StatefulWidget {
  final Widget whereTo;
  final int duration;
  NeuralLoadingAnimation({this.whereTo, this.duration});

  @override
  _NeuralLoadingAnimationState createState() => _NeuralLoadingAnimationState();
}

class _NeuralLoadingAnimationState extends State<NeuralLoadingAnimation> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: widget.duration), () {
      Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => widget.whereTo,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 225,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/ysa.gif',
                  fit: BoxFit.fitHeight,
                  alignment: Alignment(0.0, 0),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Lütfen bekleyiniz',
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.red.withOpacity(0.3),
                ],
                begin: const FractionalOffset(0.5, 1),
                end: const FractionalOffset(0, 0),
                stops: [0.0, 0.5],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'assets/images/12.png',
              fit: BoxFit.cover,
              alignment: Alignment(0.0, 0),
              color: Colors.redAccent.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
