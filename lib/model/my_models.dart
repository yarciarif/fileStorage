// ignore: constant_identifier_names
// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:flutter/foundation.dart';

enum Cinsiyet { Kadin, ERKEK, DIGER }

enum Renk { SARI, KIRMIZI, MAVI, YESIL, MOR }

class UserInformation {
  final String isim;
  final Cinsiyet cinsiyet;
  final List<String> renk;
  final bool ogrenciMi;

  UserInformation(this.isim, this.cinsiyet, this.renk, this.ogrenciMi);

  Map<String, dynamic> toJson() {
    return {
      'isim': isim,
      'cinsiyet': describeEnum(
          cinsiyet), //CINSIYET.ERKEK ICINDEKI ERKEGI STRING OLARAK ALIR.
      'renkler': renk,
      'öğrenciMi': ogrenciMi,
    };
  }

  UserInformation.fromJson(Map<String, dynamic> json)
      : isim = json['isim'],
        cinsiyet = Cinsiyet.values.firstWhere(
            (element) => describeEnum(element).toString() == json['cinsiyet']),
        renk = List<String>.from(json['renkler']),
        ogrenciMi = json['öğrenciMi'];
}
