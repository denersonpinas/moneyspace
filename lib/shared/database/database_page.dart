import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File>_getFile(String pasta) async {
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/$pasta.json");
}

Future<File> saveData(_listfinance, String pasta) async {
  String data = json.encode(_listfinance);
  final file = await _getFile(pasta);
  return file.writeAsString(data);
}

Future<String?> readData(String pasta) async {
  try {
    final file = await _getFile(pasta);
    return file.readAsString();
  } catch (e) {
    return null;
  }
}