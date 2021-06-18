import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File>_getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/test20.json");
}

Future<File> saveData(_listfinance) async {
  String data = json.encode(_listfinance[0]["carteira"]);
  final file = await _getFile();
  return file.writeAsString(data);
}

Future<String?> readData() async {
  try {
    final file = await _getFile();
    return file.readAsString();
  } catch (e) {
    return null;
  }
}