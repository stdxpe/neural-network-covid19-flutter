import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import '../constants.dart';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/myfile.txt');
  }

  static Future<File> saveToFile(String data) async {
    final file = await getFile;
    return file.writeAsString(data);
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }

  static Future<String> myReadFromFileMethod(String path) async {
    try {
      // final file = await getFile;
      final file = File(path);

      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }

  static Future<String> pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    PlatformFile file = result.files.first;
    if (result != null) {
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      print('File Extension: ${file.extension}');
      // print(file.path);
      // print(file.readStream);
    } else {
      // User canceled the picker
    }
    return file.path;
  }

  static myJsonMethod(String path) async {
    // List tempList = [];
    try {
      final file = File(path);

      String fileContents = await file.readAsString();

      Map<String, dynamic> myData = jsonDecode(fileContents);

      // print((myData['dataset'][2]['x']));
      // print((myData['dataset']).length);
      datasetMatrix.clear();
      // datasetMatrix.k
      datasetMatrix = [[], []];
      for (int i = 0; i < (myData['dataset']).length; i++) {
        print('$i ${(myData['dataset'][i]['x'])}');
        // print('$i ${double.parse(myData['dataset'][i]['x'])}');

        // print('$i  ${myData['dataset'][2]['bagimsiz_degisken']}');
        // // importedJson[0].add(myData['dataset'][i]['x']);
        // // importedJson[1].add(myData['dataset'][i]['y']);

        // // datasetMatrix[0].add(double.parse(myData['dataset'][i]['x']));
        // // datasetMatrix[1].add(double.parse(myData['dataset'][i]['y']));
        // datasetMatrix[0].add(num.parse(myData['dataset'][i]['x']));
        // datasetMatrix[1].add(num.parse(myData['dataset'][i]['y']));
        datasetMatrix[0].add((myData['dataset'][i]['x']));
        datasetMatrix[1].add((myData['dataset'][i]['y']));
      }

      print(datasetMatrix);
      degiskenIsimleriX.add((myData['dataset'][0]['bagimsiz_degisken']));
      degiskenIsimleriY.add((myData['dataset'][0]['bagimli_degisken']));
      // print('myData = ${myData['dataset'][0]['bagimsiz_degisken']}');
      isRegressionJSONParametersCorrect = true;

      // List myPages = myData["bagimsiz_degisken"].values.toList();
      // print('myPages Listem = $myPages');
    } catch (e) {
      isRegressionJSONParametersCorrect = false;
      return "";
    }
  }

  static myTxtReadMethod(String path) async {
    // List tempList = [];
    try {
      final file = File(path);

      // String fileContents = await file.readAsString();

      // print('TXT DATAM INSIDE: ${fileContents}');
      // List<String> resultContent = fileContents.split(' ');

      // print('TXT DATAM INSIDE SATIR 1: ${resultContent}');

      // ///
      // ///
      List<String> fileLineContents = await file.readAsLines();
      print('TXT DATA LISTEM: ${fileLineContents}');
      // List<String> resultContent = fileLineContents.map((e) => e.split(' '););
      List tempList = [];
      // List tempDatasetList = [[], [], []];

      mainDatasetMatrix = List.generate(
        (inputsCount + outputsCount),
        (i) => List<num>(),
        growable: true,
      );
      mainNormalizedMatrix = List.generate(
        (inputsCount + outputsCount),
        (i) => List<num>(),
        growable: true,
      );
      // var tempDatasetList = [];
      print('TXT DATA TLİST $mainDatasetMatrix');
      List outputList = [];
      for (int i = 0; i < fileLineContents.length; i++) {
        // print('TXT DATA ${fileLineContents[i].split(' ')}');
        tempList.add(fileLineContents[i].split(' '));
        print('TXT DATA $i ${tempList[i]}');

        for (int j = 0; j < (inputsCount + outputsCount); j++) {
          mainDatasetMatrix[j].add(num.parse(tempList[i][j]));
          print('TXT DATA $i $j ${tempList[i][j]}');
        }
      }

      print('TXT DATA TEMP DATASET ${mainDatasetMatrix}');
      print('TXT DATA DATASET MATRIX $mainDatasetMatrix');

      isParametersCorrect = true;
    } catch (e) {
      print('TXT DATA SIKINTI DATASET ${mainDatasetMatrix}');

      isParametersCorrect = false;

      return "";
    }
  }

  static myTxtReadMethodForRegresyon(String path) async {
    // List tempList = [];
    try {
      final file = File(path);

      // String fileContents = await file.readAsString();

      // print('TXT DATAM INSIDE: ${fileContents}');
      // List<String> resultContent = fileContents.split(' ');

      // print('TXT DATAM INSIDE SATIR 1: ${resultContent}');

      // ///
      // ///
      List<String> fileLineContents = await file.readAsLines();
      print('TXT DATA LISTEM: ${fileLineContents}');
      // List<String> resultContent = fileLineContents.map((e) => e.split(' '););
      List tempList = [];
      // List tempDatasetList = [[], [], []];
      datasetMatrix.clear();
      // datasetMatrix[0]//TODO
      datasetMatrix = List.generate(
        (1 + 1),
        (i) => List<num>(),
        growable: true,
      );

      print('TXT DATA TLİST $datasetMatrix');
      List outputList = [];
      for (int i = 0; i < fileLineContents.length; i++) {
        // print('TXT DATA ${fileLineContents[i].split(' ')}');
        tempList.add(fileLineContents[i].split(' '));
        print('TXT DATA $i ${tempList[i]}');

        for (int j = 0; j < (1 + 1); j++) {
          datasetMatrix[j].add(num.parse(tempList[i][j]));
          print('TXT DATA $i $j ${tempList[i][j]}');
        }
      }
      print('TXT DATA TEMP DATASET ${datasetMatrix}');
      print('TXT DATA DATASET MATRIX $datasetMatrix');

      degiskenIsimleriX.add('TXT X');
      degiskenIsimleriY.add('TXT Y');

      isRegressionTXTParametersCorrect = true;
    } catch (e) {
      print('TXT DATA SIKINTI DATASET ${datasetMatrix}');
      isRegressionTXTParametersCorrect = false;
      return "";
    }
  }
}
