import 'package:basit_dogrusal_regresyon_01/screens/regresyon1.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../bg_blur_filter.dart';
import '../constants.dart';
import '../rounded_button.dart';
import 'neural_network_solution_home.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BGBlurFilter(),
          Container(color: Colors.black.withOpacity(0.5)),
          IntroductionScreen(
            animationDuration: 1200,
            curve: Curves.ease,
            pages: [
              PageViewModel(
                title: "",
                bodyWidget: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'YSA\nNedir?',
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
                          padding: EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 30),
                          child: Text(
                            "Yapay Sinir Ağları, insan beynini oluşturan biyolojik üniteler olan nöronların çalışma prensiplerinden esinlenerek, öğrenme sürecinin matematiksel olarak modellenmesi amacıyla oluşturulan yapay zeka sistemleridir.",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w100),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: size.width * 0.8,
                          child: Image.asset(
                            'assets/images/onboarding/ysa1.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PageViewModel(
                title: "",
                bodyWidget: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Ne işe yarar?',
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
                          padding: EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 30),
                          child: Text(
                            "Yapay Sinir Ağları, geçmiş deneyimlerden elde edilen veriler ile öğrenme gerçekleştikten sonra, istenen hassasiyette etkili tahminler yapmamızı sağlar. Girdiler, yüklenen veriler; çıktılar ise elde edilen tahminlerdir.",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w100),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: size.width * 0.8,
                          child: Image.asset(
                            'assets/images/onboarding/ysa6.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PageViewModel(
                title: "",
                bodyWidget: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Öğrenme\nnedir?',
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
                          padding: EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 30),
                          child: Text(
                            "Makine öğrenmesi olarak da bilinen bu işlem, ağın eğitilmesi sürecidir. Yapay sinir ağları, yüklenen veri seti ile tekrar tekrar çalışarak olayları öğrenebilir ve benzer olaylar karşısında mantıklı kararlar verebilir.",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w100),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: size.width * 0.8,
                          child: Image.asset(
                            'assets/images/onboarding/ysa3.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PageViewModel(
                title: "",
                bodyWidget: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Amaç nedir?',
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
                          padding: EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 30),
                          child: Text(
                            "Yapay Sinir Ağları'nda en temel amaç ideal ağırlık değerlerini bulmaktır. Ağın eğitilmesi, ideal ağırlıkların bulunması işlemidir. Eğitim süreci çok fazla tekrar (iterasyon) gerektirir.",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w100),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: size.width * 0.8,
                          child: Image.asset(
                            'assets/images/onboarding/ysa8.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PageViewModel(
                title: "",
                bodyWidget: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: size.height * 0.07,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Neden çok fazla iterasyon gerekiyor?',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: 30,
                            height: 0.9,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 16),
                          child: Text(
                            "Olasılık Teorisi'nin bir gereğidir. Örnek olarak; bir madeni para 10 kere havaya atıldığında 5 yazı ve 5 tura gelmesi beklenirken, 8 yazı ve 2 tura gelebilir. Ancak gerçek oran 0.5'tir ve hatalı bir sonuç elde edilmiştir. Bu problemi aşmak için madeni para 10000 kez havaya atılırsa, sonuçlar 5100 yazı ve 4900 tura gibi gerçek oran olan 0.5'a mutlaka yaklaşacaktır. Özet olarak, gerçek olasılık sonuçlarına yaklaşmak için, çok yüksek tekrar sayıları ile çalışmak zorundayız. Yapay Sinir Ağları için de aynı kural geçerlidir.",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w100),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: size.width * 0.8,
                          child: Image.asset(
                            'assets/images/onboarding/ysa7.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PageViewModel(
                title: "",
                bodyWidget: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: size.height * 0.06,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Regresyon\'dan\nfarkı nedir?',
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 16),
                          child: Text(
                            "Matematikte bir işlemin cevabını bulmak için, belirli bir formülde değişkenleri girip sonuca ulaşabiliriz. Ancak formül bilinmiyorsa Yapay Sinir Ağları ya da Basit/Çoklu Doğrusal Regresyon başvurulabilecek yöntemlerdendir. YSA gibi Regresyon ile de tahmin yapılabilir. Ancak elde edilen başarı sabit olur. Bu başarıyı etkileyen tek faktör yüklenen veri sayısıdır. Ancak YSA ile tahmin yaparken, istenen tahmin başarısı elde edilebilir. Çünkü tahmin başarısını etkileyen birçok etken vardır ve Regresyon'a göre daha etkili ve isabetli tahminler yapmamızı sağlar.",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13.5,
                                height: 1.33,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w100),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: size.width * 0.8,
                          child: Image.asset(
                            'assets/images/onboarding/ysa5.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PageViewModel(
                title: "",
                bodyWidget: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: size.height * 0.08,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Bu proje Yapay Sinir Ağları\ndersi için hazırlanmıştır.',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            height: 1.2,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          width: size.width * 0.8,
                          child: Image.asset(
                            'assets/images/onboarding/ysa.gif',
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.75),
                          ),
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20),
                          child: Text(
                            "Aşağıdaki butonlardan istediğiniz yöntemi seçerek başlayabilirsiniz. Basit Doğrusal Regresyon sayfasında örnek olarak \"Ülkeler için COVID19 Vaka Sayısı/İyileşen Oranları\" dataseti yüklenmiştir. Uygulama için gerekli şekil ve formatta olduğu sürece, istediğiniz dataseti yükleyerek çalışabilirsiniz.",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.3,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w100),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 70.0,
                        ),
                        RoundedButton(
                          buttonText: 'DOĞRUSAL REGRESYON',
                          color: kPrimaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) => Regresyon1(),
                              ),
                            );
                          },
                        ),
                        RoundedButton(
                          buttonText: 'YAPAY SİNİR AĞLARI',
                          color: kSecondaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) =>
                                    NeuralNetworkSolutionHome(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            onDone: () {},
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            skip: const Text('Atla', style: TextStyle(color: Colors.white)),
            next: const Icon(Icons.arrow_forward, color: Colors.white),
            done: const Text(''),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
