// ignore_for_file: prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageService implements LocalStorageService {
  _getFilePath() async {
    var filePath = await getApplicationDocumentsDirectory();
    debugPrint('File kurucu metot çalıştı.');
    //debugPrint(filePath.path);
    return filePath.path;
  }

  FileStorageService() {
    _createFile();
  }

//FILE ISIMLI SINIF DART.IO ICINDE ONU IMPORT EDIYORUZ
  Future<File> _createFile() async {
    var file = File(await _getFilePath() + '/info.json');
/* DOSYAYI OLUŞTURUP ONA WRITEASSTRING ILE ICINE BI SEYLER YAZMAK ICIN KULLANILIR.
    await file.writeAsString('Deneme İçerik');*/

    return file;
  }

  @override
  Future<void> verileriKaydet(UserInformation userInfo) async {
    var file = await _createFile();
    await file.writeAsString(jsonEncode(userInfo));
  }

  @override
  Future<UserInformation> verileriOku() async {
    try {
      var file = await _createFile();
      var dosyaIcerik = await file.readAsString();
      var json = jsonDecode(dosyaIcerik);
      return UserInformation.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
    }
    return UserInformation('', Cinsiyet.Kadin, [], false);
  }
}
