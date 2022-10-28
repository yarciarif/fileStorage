// ignore_for_file: prefer_interpolation_to_compose_strings, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices implements LocalStorageService {
  late final preferences;

  //KURUCU METODU ALTTA FUTURE TURUNDEKİ İŞLEMLER KURUCU METOTTA ÇALIŞMADIGINDAN BÖYLE Bİ YOL İZLENDİ.
  SharedPrefServices() {
    debugPrint('Share Kurucu Metot Çalıştı.');
    kurucu();
  }
  Future<void> kurucu() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> verileriKaydet(UserInformation userInfo) async {
    final name = userInfo.isim;
    //debugPrint(name);

    preferences.setBool('Öğrenci mi', userInfo.ogrenciMi);
    preferences.setString('İsim', userInfo.isim);
    preferences.setInt('Cinsiyet Index', userInfo.cinsiyet.index);
    preferences.setStringList('Renkler', userInfo.renk);
  }

  @override
  Future<UserInformation> verileriOku() async {
    final preferences = await SharedPreferences.getInstance();

    var isim = preferences.getString('İsim') ?? '';
    var ogrenci = preferences.getBool('Öğrenci mi') ?? false;
    var cinsiyet = Cinsiyet.values[preferences.getInt('Cinsiyet Index') ?? 0];
    var renk = preferences.getStringList('Renkler') ?? [];
    /* debugPrint(isim +
        ' ' +
        ogrenci.toString() +
        ' ' +
        cinsiyet.index.toString() +
        '' +
        renk.toString());
 */
    return UserInformation(isim, cinsiyet, renk, ogrenci);
  }
}
