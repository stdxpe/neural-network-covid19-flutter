import 'package:basit_dogrusal_regresyon_01/screens/basit_dogrusal_regresyon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bg_blur_filter.dart';
import '../constants.dart';
import 'file_utils.dart';

class ImportFilePage extends StatefulWidget {
  @override
  _ImportFilePageState createState() => _ImportFilePageState();
}

class _ImportFilePageState extends State<ImportFilePage> {
  String content = 'No Data';
  String path = 'No Path';
  bool isDataSet = false;
  String warningText = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          BGBlurFilter(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.1)
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.13,
                    ),
                    Text(
                      'Dataset\nYükleme',
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
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Basit Doğrusal Regresyon için yüklenecek verilerin 1 giriş ve 1 çıkışa sahip olması gerekir. JSON ya da TXT formatında veri yükleyebilirsiniz.\nJSON için Path:  x.dataset[0].x  şeklinde oluşturulmalıdır. TXT için, sütunlar 1\'er boşluk ile ayrılmış şekilde kaydedilmelidir.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 30.0,
                        horizontal: 18,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Image.asset(
                              'assets/images/json2.png',
                            ),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            flex: 1,
                            child: Image.asset(
                              'assets/images/dataset_ex3.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          warningText,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 100.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  FileUtils.pickFile().then((returnedPath) {
                                    setState(() {
                                      path = returnedPath;

                                      FileUtils.myReadFromFileMethod(path)
                                          .then((returnedContent) {
                                        setState(() {
                                          content = returnedContent;
                                        });
                                      });

                                      FileUtils.myJsonMethod(path)
                                          .then((returnedContent) {
                                        setState(() {
                                          if (isRegressionJSONParametersCorrect &&
                                              datasetMatrix[0].length > 0) {
                                            warningText = "Yükleme başarılı!";
                                          } else if (isRegressionTXTParametersCorrect ==
                                              false) {
                                            warningText =
                                                "Dosya ve parametreler uyumlu değil!\nLütfen uygulamayı tekrar başlatınız!";
                                          } else {
                                            warningText =
                                                "Lütfen tekrar deneyiniz!";
                                          }
                                          isDataSet = true;
                                        });
                                        if (isDataSet) {
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              opaque: false, // set to false
                                              pageBuilder: (_, __, ___) =>
                                                  BasitDogrusalRegresyon(),
                                            ),
                                          );
                                        }
                                      });
                                    });
                                  });
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: kPrimaryColor,
                                      radius: 28,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: SvgPicture.asset(
                                          'assets/images/upload.svg',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'JSON Yükle',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      content = 'No Data';
                                      FileUtils.pickFile().then((returnedPath) {
                                        setState(() {
                                          path = returnedPath;

                                          FileUtils.myReadFromFileMethod(path)
                                              .then((returnedContent) {
                                            setState(() {
                                              content = returnedContent;
                                            });
                                          });

                                          FileUtils.myTxtReadMethodForRegresyon(
                                                  path)
                                              .then((returnedContent) {
                                            setState(() {
                                              if (isRegressionTXTParametersCorrect &&
                                                  datasetMatrix[0].length > 0) {
                                                warningText =
                                                    "Yükleme başarılı!";
                                              } else if (isRegressionTXTParametersCorrect ==
                                                  false) {
                                                warningText =
                                                    "Dosya ve parametreler uyumlu değil!\nLütfen uygulamayı tekrar başlatınız!";
                                              } else {
                                                warningText =
                                                    "Lütfen tekrar deneyiniz!";
                                              }
                                              isDataSet = true;
                                            });

                                            if (isDataSet) {
                                              Navigator.pop(context);
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  opaque: false, // set to false
                                                  pageBuilder: (_, __, ___) =>
                                                      BasitDogrusalRegresyon(),
                                                ),
                                              );
                                            }
                                          });
                                        });
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: kSecondaryColor,
                                      radius: 28,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: SvgPicture.asset(
                                          'assets/images/upload.svg',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'TXT Yükle',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
