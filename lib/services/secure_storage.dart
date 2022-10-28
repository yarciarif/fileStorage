// ignore_for_file: prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';

class SecureShareStorage implements LocalStorageService {
  late final FlutterSecureStorage preferences;
  //KURUCU METOT TANIMLIYORUZ Kİ OLUSTURULAN PREFERENCES NESNESİ BİR KERE ÇALIŞSSIN
  SecureShareStorage() {
    debugPrint('Secure Storage kurucu metodu çalıştı');
    preferences = const FlutterSecureStorage();
  }
  @override
  Future<void> verileriKaydet(UserInformation userInfo) async {
    final name = userInfo.isim;
    //debugPrint(name);

    const preferences = FlutterSecureStorage();

    await preferences.write(key: 'İsim', value: name);
    await preferences.write(
        key: 'Öğrenci mi', value: userInfo.ogrenciMi.toString());
    await preferences.write(
        key: 'Cinsiyet Index', value: userInfo.cinsiyet.index.toString());
    await preferences.write(key: 'Renkler', value: jsonEncode(userInfo.renk));
  }

  @override
  Future<UserInformation> verileriOku() async {
    var isim = await preferences.read(key: 'İsim') ?? '';
    var ogrenciString = await preferences.read(key: 'Öğrenci mi') ?? 'false';
    var ogrenci = ogrenciString.toLowerCase() == 'true' ? true : false;
    var cinsiyetString = await preferences.read(key: 'Cinsiyet Index') ?? '0';
    var cinsiyet = Cinsiyet.values[int.parse(cinsiyetString)];
    var renkString = await preferences.read(key: 'Renkler');
    var renkler = renkString == null
        ? <String>[]
        : List<String>.from(jsonDecode(renkString));

    return UserInformation(isim, cinsiyet, renkler, ogrenci);
  }
}
