import 'dart:async';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:external_path/external_path.dart';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../API_E_B/notifications.dart';

Future SetExcel(var excel, var EXcel) async {
  final now = DateTime.now();
  var documentDiresctory;

  Directory? _appDocDirFolder;
  Directory? _appDocDirFolder1;
  if (Platform.isAndroid) {
    documentDiresctory = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  } else{
    Directory D = await getApplicationDocumentsDirectory();
    documentDiresctory = D.path;
  }

  // Directory docume ntDiresctory = await getApplicationDocumentsDirectory();

  // String documentPath = documentDiresctory.path;
  _appDocDirFolder = Directory("$documentDiresctory/");
  print(_appDocDirFolder.path);
  // var isThere = await _appDocDirFolder.exists();
  //  print(isThere ? 'exists' : 'non-existent');
  //  if(isThere != true){
  //      Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
  //      print('==================>เพิ่มสำเร็จ');
  //  }else{
  //    print('==================>มีอยู่เล้ว');
  //  }
  Directory _appDocDirNewFolder =
      await _appDocDirFolder.create(recursive: true);

  var status = await Permission.storage.request();
  if (status.isGranted) {
    try {
      File file = File(
          "$documentDiresctory/$EXcel${now.millisecond}${now.microsecond}.xlsx");
      file.writeAsBytesSync(await excel.encode());
    } catch (e) {
      print('e====> $e');
    }
  } else {
    // showNot('Download File','Failed to download');
  }
  String? fileexcel =
      "$documentDiresctory/$EXcel${now.millisecond}${now.microsecond}.xlsx";

  OpenFilex.open(fileexcel);
  var duration = Duration(seconds: 1);
  // showNot('Download File','Download Successfully');
  // DownloadExcel(fileexcel);

  print('d');
}

Future saveExcelAgeinformation(List<dynamic>? result, var EXcel) async {
  List<Map<String, Data>> Excel0_1 = [];
  List<Map<String, Data>> Excel0_2 = [];
  var excel = Excel.createExcel();
  var A_Z = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  if (result == null || result == []) {
  } else {
    Sheet sheetObject = excel['Sheet1'];
    Excel0_1 = List.generate(result[0].keys.length, (i) {
      return {
        "Excel0_1": sheetObject.cell(CellIndex.indexByString("${A_Z[i]}1"))
      };
    });
    for (int j = 0; j < result[0].keys.length; j++) {
      Excel0_1[j]['Excel0_1']!.value = "${result[0].keys.elementAt(j)}";
    }
    Excel0_2 = List.generate(result.length, (i) {
      return {
        for (int t = 0; t < result[0].keys.length; t++)
          "Excel0_2_$t":
              sheetObject.cell(CellIndex.indexByString("${A_Z[t]}${i + 2}"))
      };
    });
    for (int j = 0; j < result.length; j++) {
      for (int t = 0; t < result[0].keys.length; t++) {
        if (result[j]['${result[0].keys.elementAt(t)}'] == null) {
          Excel0_2[j]['Excel0_2_$t']!.value = '';
        } else {
          Excel0_2[j]['Excel0_2_$t']!.value =
              '${result[j]['${result[0].keys.elementAt(t)}']}';
        }
      }
    }
    initInfo();
    showNot('Download File', 'Download Successfully');
    SetExcel(excel, EXcel);
  }
}
