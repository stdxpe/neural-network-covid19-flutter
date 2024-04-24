import 'package:flutter/material.dart';

List<String> degiskenIsimleriX = [];
List<String> degiskenIsimleriY = [];

////////////////////////////////////////
///// Regresyon listesi - Alternatif01
///
List<List<num>> datasetMatrix = [
  [423, 938, 844, 802, 773, 757, 570, 535.0],
  [362, 867, 537, 577, 343, 702, 259, 511.0],
];

List tahminMatrix = [
  [],
  [],
];

List<List<double>> normalizedMatrix = [
  [],
  [],
];

////////////////////////////////////////
///// Regresyon listesi - Alternatif02
///
List datasetMatrix2 = [
  [423, 362],
  [938, 867],
  [844, 537],
  [802, 577],
  [773, 343],
  [757, 702],
  [570, 259],
  [535, 511],
];

////////////////////////////////////////
///// Regresyon listesi - Alternatif03
///
List<int> bagimsizX = [423, 938, 844, 802, 773, 757, 570, 535];
List<int> bagimliY = [362, 867, 537, 577, 343, 702, 259, 511];

List<int> tahminX = [];
List<int> denemeY = [];

List<double> normalizedXList = [];
List<double> normalizedYList = [];

/////////////////////////////////////

double circleRadius = 30;
double circleOffset = 20;
double circleInputPosition = circleRadius + circleOffset;
double circleHiddenPositionX = circleRadius + circleOffset * 2;
double circleHiddenPositionY = circleRadius + circleOffset;
double circleOutputPositionX = circleRadius * 2 + circleOffset * 3;
double circleOutputPositionY = circleRadius + circleOffset;

List<double> inputs = [];
List<double> hiddens = [];
List<double> outputs = [];
//???
//TODO
List<double> hiddens2 = [];

Map offsetsPositionsMap = {};

Map<String, String> selectedFunctions = {};
List hintTextsInputsHiddens = [
  [],
  [],
];

List hintTextsHiddensOutputs = [
  [],
  [],
];

//??
List hintTextsHiddensHiddens2 = [
  [],
  [],
];
//??
List hintTextsHiddens2Outputs = [
  [],
  [],
];

List weightsInputsHiddens = [[], []];
List weightsHiddensOutputs = [[], []];

List<num> inputsHiddensCarpimList =
    []; //inputs.length * hiddens.length sayısı kadar
List hiddensGirisList = []; //hiddens.length sayısı kadar
List hiddensCikisList = []; //hiddens.length sayısı kadar
double eSayisi = 2.7182818;

List hiddensOutputsCarpimList =
    []; //hiddens.length * outputs.length sayısı kadar
List outputsGirisList = []; //outputs.length sayısı kadar
List outputsCikisList = []; //outputs.length sayısı kadar

List importedJson = [[], []];

////////////////////////////////////

const kPrimaryColor = Color(0xFF8A56AC);
const kSecondaryColor = Color(0xFFD47FA6);
const kTertiaryColor = Color(0xFF9599B3);
const kBackgroundColor = Color(0xFF241332);
const kGreyBackgroundColor = Color(0xFFF1F0F2);
const kTextFieldBgColor = Color(0xFF352641);

const kDefaultPadding = 25.0;
const kDefaultMargin = 25.0;

var kBorderRadiusBig = new BorderRadius.circular(80.0);
var kBorderRadiusSmall = new BorderRadius.circular(50.0);
var kBorderRadiusMini = new BorderRadius.circular(20.0);

var kBorderRadiusImage = BorderRadius.only(
    topLeft: Radius.circular(35),
    topRight: Radius.circular(35),
    bottomLeft: Radius.circular(35),
    bottomRight: Radius.circular(35));

var kBorderRadiusProfile = BorderRadius.only(
  topLeft: Radius.circular(50),
  topRight: Radius.circular(50),
);

var kBorderRadiusProfileLeftGrid = BorderRadius.only(
  topLeft: Radius.circular(50),
  bottomLeft: Radius.circular(50),
);

var kBorderRadiusProfileRightTopGrid = BorderRadius.only(
  topRight: Radius.circular(50),
);

var kBorderRadiusProfileRightBottomGrid = BorderRadius.only(
  bottomRight: Radius.circular(50),
);

List<String> myList = [];

//////////////////////////////////////////////////////////////
///NEURAL NETWORK SOLUTION
///

// List<List<num>> mainDatasetMatrix = [
//   [423, 938, 844, 802, 773, 757, 570, 535.0],
//   [362, 867, 537, 577, 343, 702, 259, 511.0],
// ];

// List datasetMatrix2 = [
//   [423, 362],
//   [938, 867],
//   [844, 537],
//   [802, 577],
//   [773, 343],
//   [757, 702],
//   [570, 259],
//   [535, 511],
// ];

// List<List<num>> mainDatasetMatrix = [
//   [
//     1,
//     0,
//     7,
//     4,
//     3,
//     0,
//     4,
//     8,
//     5,
//     8,
//     10,
//   ],
//   [
//     65000,
//     48600,
//     61300,
//     79000,
//     44000,
//     62000,
//     30000,
//     113000,
//     95000,
//     130000,
//     96000,
//   ],
//   [
//     79950,
//     86850,
//     46250,
//     59250,
//     83000,
//     71950,
//     60000,
//     41000,
//     57500,
//     44000,
//     41000
//   ], //beklenen
// ];

List<List<num>> mainDatasetMatrix = [];

// List<List<num>> mainDatasetMatrix = [
//   [
//     1,
//     0,
//     7,
//     4,
//     3,
//     0,
//     4,
//     8,
//     5,
//     8,
//   ],
//   [
//     65000,
//     48600,
//     61300,
//     79000,
//     44000,
//     62000,
//     30000,
//     113000,
//     95000,
//     130000,
//   ],
//   [
//     79950,
//     86850,
//     46250,
//     59250,
//     83000,
//     71950,
//     60000,
//     41000,
//     57500,
//     44000,
//   ], //beklenen
// ];

// List<List<num>> mainNormalizedMatrix = [
//   [],
//   [],
//   [],
// ];
List<List<num>> mainNormalizedMatrix = [];

int inputsCount = 0;
int hiddensCount = 0;
int outputsCount = 0;

List mainWeightsInputsHiddens = [];
List mainWeightsHiddensOutputs = [];

List mainBiasHiddens = [];
List mainBiasOutputs = [];

List mainInputsHiddensCarpimList = [];

List mainInputsHiddensToplamFonkList = [];
List mainInputsHiddensTransferFonkList = [];

List mainHiddensOutputsCarpimList = [];

List mainHiddensOutputsToplamFonkList = [];
List mainHiddensOutputsTransferFonkList = [];

bool isWithBias = true;

////GERİYE DOĞRU HESAPLAMA ELEMENTLERİ
double lambda = 0.6; //Öğrenme katsayısı
double alpha = 0.05; //Momentum

List mainErrorList = [];

List mainSigmaHiddens = [];
List mainSigmaOutputs = [];

List mainDeltaWInputsHiddens = [];
List mainDeltaWHiddensOutputs = [];

List mainDeltaBiasOutputs = [];
List mainDeltaBiasHiddens = [];

List mainDeltaWHistoryIH = [0];
List mainDeltaWHistoryHO = [0];

int iterationCount = 0;
int totalComputationsCount = 0;
int stepsCount = 0;

///RESULTS PAGE
///
List expectedResults = [];
String timeResult = '';
List absoluteErrorList = [];
double percentageMAPEError = 0.0;

Map absoluteErrorMap = {};

List allErrorsList = [];
List allOutputsList = [];
List allOutputsDenormalizedList = [];

// int selectedIteration = 10;

bool isParametersCorrect = false;
bool isRegressionTXTParametersCorrect = false;
bool isRegressionJSONParametersCorrect = false;
