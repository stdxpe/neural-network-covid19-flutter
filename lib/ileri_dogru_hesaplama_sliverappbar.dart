// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../bg_blur_filter.dart';
// import '../constants.dart';
// import '../flex_listview_small.dart';
// import '../painter.dart';
// import '../x_y_inputfield.dart';
// import 'basit_dogrusal_regresyon.dart';

// class IleriDogruHesaplamaSliverAppBar extends StatefulWidget {
//   @override
//   _IleriDogruHesaplamaSliverAppBarState createState() =>
//       _IleriDogruHesaplamaSliverAppBarState();
// }

// class _IleriDogruHesaplamaSliverAppBarState
//     extends State<IleriDogruHesaplamaSliverAppBar> {
//   final TextEditingController _controller1 = TextEditingController();
//   final TextEditingController _controller2 = TextEditingController();
//   FocusNode focusNode1 = FocusNode();
//   FocusNode focusNode2 = FocusNode();
//   String hintText1 = 'I0';
//   String hintText2 = 'I0-H0';
//   final Map _globalKeysMap = {};
//   bool isLinesSet = true;
//   bool isTextFieldSet = false;
//   int count = 0;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback(
//         (_) => getRelativePositionsOfCircles(category: 'inputs', list: inputs));
//     WidgetsBinding.instance.addPostFrameCallback((_) =>
//         getRelativePositionsOfCircles(category: 'hiddens', list: hiddens));
//     WidgetsBinding.instance.addPostFrameCallback((_) =>
//         getRelativePositionsOfCircles(category: 'outputs', list: outputs));
//     WidgetsBinding.instance.addPostFrameCallback((_) => createLines());

//     hintTextEditor(list1: inputs, list2: hiddens);
//   }

//   List<Widget> createCircle({int count, String category}) {
//     List<Widget> widgetsCircles = [];
//     widgetsCircles.clear();

//     for (int i = 0; i < count; i++) {
//       GlobalKey keyName = GlobalKey();
//       _globalKeysMap['$category$i'] = keyName;
//       widgetsCircles.add(
//         CustomPaint(
//           key: _globalKeysMap['$category$i'],
//           painter: MyCircle(),
//         ),
//       );
//     }

//     return widgetsCircles;
//   }

//   /////Çizgiler
//   Widget createLines() {
//     return CustomPaint(
//       painter: LinePainter(),
//     );
//   }

//   /////Çemberlerin göreli konumunu hesaplar
//   getRelativePositionsOfCircles({String category, List list}) {
//     for (int i = 0; i < list.length; i++) {
//       RenderBox _cardBox =
//           _globalKeysMap['$category$i'].currentContext.findRenderObject();
//       offsetsPositionsMap['$category$i'] = _cardBox.localToGlobal(Offset.zero);
//     }
//   }

//   // // /////Hint Text'ler için String listeyi doldurur
//   // // hintTextEditor({List list1, List list2}) {
//   // //   for (int i = 0; i < list1.length; i++) {
//   // //     for (int j = 0; j < list2.length; j++) {
//   // //       // hintText1 = 'I$i';
//   // //       // hintText2 = 'I$i-H$j';
//   // //       hintTexts[0].add('I$i');
//   // //       hintTexts[1].add('I$i-H$j');
//   // //     }
//   // //   }
//   // // }

//   /////Hint Text'ler için String listeyi doldurur
//   hintTextEditor({List list1, List list2}) {
//     for (int i = 0; i < list2.length; i++) {
//       for (int j = 0; j < list1.length; j++) {
//         // hintText1 = 'I$i';
//         // hintText2 = 'I$i-H$j';
//         hintTexts[0].add('I$j');
//         hintTexts[1].add('I$j-H$i');

//         // inputsHiddensCarpimList
//         //     .add(double.parse(weights[0][j] * weights[1][i]));
//       }
//     }
//   }

//   /////Input-Hiddens I * W çarpımları
//   inputHiddenCalc({List list1, List list2}) {
//     inputsHiddensCarpimList.clear();
//     for (int i = 0; i < list1.length * list2.length; i++) {
//       inputsHiddensCarpimList.add((weights[0][i] * weights[1][i]));
//     }
//   }

//   /////Input-Hiddens I * W çarpımlarının toplamları
//   toplamFonksiyonu({List list1, List list2}) {
//     // double toplam = 0;
//     for (int i = 0; i < list1.length * list2.length; i = i + list1.length) {
//       double toplam = 0;
//       for (int j = 0; j < list1.length; j++) {
//         toplam = inputsHiddensCarpimList[i + j] + toplam;
//       }
//       hiddensGirisList.add(toplam);
//     }
//   }

//   sigmoidFonksiyonu({List list}) {
//     for (int i = 0; i < list.length; i++) {
//       double sigmoid = 1 / (1 + pow(eSayisi, -hiddensGirisList[i]));
//       // print(sigmoid);
//       hiddensCikisList.add(sigmoid);
//     }
//     print(hiddensCikisList);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return <Widget>[
//             SliverAppBar(
//               backgroundColor: Colors.transparent,
//               expandedHeight: 375.0,
//               // collapsedHeight: 200,
//               floating: false,
//               pinned: false,
//               flexibleSpace: FlexibleSpaceBar(
//                 collapseMode: CollapseMode.parallax,
//                 centerTitle: true,
//                 background: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(0.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                             colors: [
//                               Color(0xFF241332),
//                               Colors.black.withOpacity(0.1)
//                             ],
//                           ),
//                         ),
//                         height: 400,
//                         width: size.width,
//                       ),
//                     ),
//                     createLines(),
//                     Padding(
//                       padding: const EdgeInsets.all(0.0),
//                       child: Container(
//                         // color: Colors.white60,
//                         height: 400,
//                         width: size.width,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: createCircle(
//                                   count: inputs.length, category: 'inputs'),
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: createCircle(
//                                   count: hiddens.length, category: 'hiddens'),
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: createCircle(
//                                   count: outputs.length, category: 'outputs'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ];
//         },
//         body: Stack(
//           children: [
//             BGBlurFilter(),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //   crossAxisAlignment: CrossAxisAlignment.center,
//             //   children: [
//             //     Container(
//             //       alignment: Alignment.center,
//             //       height: 50,
//             //       // width: size.width / 3,
//             //       // color: Colors.black.withOpacity(0.6),
//             //       child: Text(
//             //         'Inputs',
//             //         style: TextStyle(
//             //             color: Colors.white,
//             //             fontSize: 10,
//             //             // fontFamily: 'Montserrat-Bold',
//             //             letterSpacing: 0,
//             //             fontWeight: FontWeight.normal),
//             //         textAlign: TextAlign.center,
//             //       ),
//             //     ),
//             //     Container(
//             //       alignment: Alignment.center,
//             //       height: 50,
//             //       // width: size.width / 3,
//             //       // color: Colors.black.withOpacity(0.5),
//             //       child: Text(
//             //         'Hiddens',
//             //         style: TextStyle(
//             //             color: Colors.white,
//             //             fontSize: 10,
//             //             // fontFamily: 'Montserrat-Bold',
//             //             letterSpacing: 0,
//             //             fontWeight: FontWeight.normal),
//             //         textAlign: TextAlign.center,
//             //       ),
//             //     ),
//             //     Container(
//             //       alignment: Alignment.center,
//             //       height: 50,
//             //       // width: size.width / 3,
//             //       // color: Colors.black.withOpacity(0.4),
//             //       child: Text(
//             //         'Outputs',
//             //         style: TextStyle(
//             //             color: Colors.white,
//             //             fontSize: 10,
//             //             // fontFamily: 'Montserrat-Bold',
//             //             letterSpacing: 0,
//             //             fontWeight: FontWeight.normal),
//             //         textAlign: TextAlign.center,
//             //       ),
//             //     ),
//             //   ],
//             // ),

//             Positioned(
//               top: 20,
//               child: Column(
//                 children: [
//                   Container(
//                     color: Colors.black.withOpacity(0.7),
//                     height: 85,
//                     width: size.width,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Flexible(
//                           flex: 1,
//                           child: XYInputField(
//                             controller: _controller1,
//                             focusNode: focusNode1,
//                             hintText: count < (inputs.length * hiddens.length)
//                                 ? hintTexts[0][count]
//                                 : '?',
//                           ),
//                         ),
//                         Flexible(
//                           flex: 1,
//                           child: XYInputField(
//                             focusNode: focusNode2,
//                             controller: _controller2,
//                             hintText: count < (inputs.length * hiddens.length)
//                                 ? hintTexts[1][count]
//                                 : '?',
//                           ),
//                         ),
//                         Flexible(
//                           flex: 1,
//                           child: InkWell(
//                             onTap: () {
//                               FocusScope.of(context).requestFocus(focusNode1);
//                               // hintTextEditor(list1: inputs, list2: hiddens);
//                               print(hintTexts);
//                               setState(
//                                 () {
//                                   //count 0'dan count 11'e küçükeşite kadar gelmeli. 0-11 arası ekleme var. 11e eşitse count artmayacak.
//                                   if ((count <
//                                       (inputs.length * hiddens.length))) {
//                                     weights[0]
//                                         .add(double.parse(_controller1.text));
//                                     weights[1]
//                                         .add(double.parse(_controller2.text));
//                                     count++;
//                                   }
//                                 },
//                               );

//                               print(count);
//                               print(weights[0]);
//                               print(weights[1]);

//                               _controller1.clear();
//                               _controller2.clear();
//                             },
//                             child: CircleAvatar(
//                               backgroundColor: kPrimaryColor,
//                               radius: 28,
//                               child: Container(
//                                   child: Icon(
//                                 Icons.add,
//                                 size: 35,
//                                 color: Colors.white,
//                               )),
//                             ),
//                           ),
//                         ),
//                         Flexible(
//                           flex: 1,
//                           child: InkWell(
//                             onTap: () {
//                               inputHiddenCalc(list1: inputs, list2: hiddens);
//                               print(inputsHiddensCarpimList);
//                               // print((weights[0][1] * weights[1][1]));
//                               // print(inputs.length);
//                               // print(hiddens.length);
//                               hiddensGirisList.clear();
//                               toplamFonksiyonu(list1: inputs, list2: hiddens);

//                               print(hiddensGirisList);
//                               hiddensCikisList.clear();
//                               sigmoidFonksiyonu(list: hiddensGirisList);
//                             },
//                             child: CircleAvatar(
//                               backgroundColor: kSecondaryColor,
//                               radius: 28,
//                               child: Container(
//                                 height: 20,
//                                 width: 20,
//                                 child: SvgPicture.asset(
//                                   'assets/images/arrow-right.svg',
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 100,
//               child: Container(
//                 // color: Colors.white.withOpacity(1),
//                 // height: 600,
//                 height: size.height,
//                 width: size.width,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     FlexListViewSmall(
//                       color: Colors.red,
//                       itemCount: 3,
//                       height: 100,
//                       function: (index) {
//                         return 'I$index\n${210.15}';
//                       },
//                     ),
//                     FlexListViewSmall(
//                       color: Colors.green,
//                       itemCount: 12,
//                       height: 110,
//                       function: (index) {
//                         return 'I$index\n${210.15}';
//                       },
//                     ),
//                     FlexListViewSmall(
//                       color: Colors.amber,
//                       itemCount: 4,
//                       height: 110,
//                       function: (index) {
//                         return 'I$index\n${210.15}';
//                       },
//                     ),
//                     FlexListViewSmall(
//                       color: Colors.orange,
//                       itemCount: 4,
//                       height: 100,
//                       function: (index) {
//                         return 'I$index\n${210.15}';
//                       },
//                     ),
//                     // FlexListViewSmall(
//                     //     color: Colors.grey, itemCount: 8, height: 100),
//                     // FlexListViewSmall(
//                     //     color: Colors.purple, itemCount: 2, height: 150),
//                     // FlexListViewSmall(
//                     //     color: Colors.pink, itemCount: 2, height: 150),
//                   ],
//                 ),
//               ),
//             ),
//             // Align(
//             //   alignment: Alignment.bottomCenter,
//             //   child:
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
