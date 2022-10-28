// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/main.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/file_storage.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:flutter_storage/services/secure_storage.dart';
import 'package:flutter_storage/services/shared_pref_services.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({super.key});

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  var _secilenCinsiyet = Cinsiyet.Kadin;
  var _secilenRenkler = <String>[];
  var _ogrenciMi = false;
  final TextEditingController _nameController = TextEditingController();

  final LocalStorageService _preferenceService = locator<LocalStorageService>();
  /* final LocalStorageService _preferenceService2 = SecureShareStorage();
  final LocalStorageService _preferenceService3 = SharedPrefServices(); */

  @override
  void initState() {
    super.initState();

    _verileriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Kullanımı'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Adınızı giriniz!'),
            ),
          ),
          for (var item in Cinsiyet.values)
            _buildRadioListTile(describeEnum(item), item),
          for (var item in Renk.values)
            _buildCheckBoxListTile(describeEnum(item), item),
          SwitchListTile(
              title: const Text('Öğrenci misin? '),
              value: _ogrenciMi,
              onChanged: (ogrenciMi) {
                setState(() {
                  _ogrenciMi = ogrenciMi;
                });
              }),
          TextButton(
              onPressed: () {
                var _userInformation = UserInformation(_nameController.text,
                    _secilenCinsiyet, _secilenRenkler, _ogrenciMi);
                _preferenceService.verileriKaydet(_userInformation);
              },
              child: const Text('Kaydet')),
        ],
      ),
    );
  }

  Widget _buildCheckBoxListTile(String title, Renk renk) {
    return CheckboxListTile(
      title: Text((title)),
      value: _secilenRenkler.contains(describeEnum(renk)),
      onChanged: (bool? deger) {
        if (deger == false) {
          _secilenRenkler.remove(describeEnum(renk));
        } else {
          _secilenRenkler.add(describeEnum(renk));
        }
        setState(() {});
        debugPrint(_secilenRenkler.toString());
      },
    );
  }

  Widget _buildRadioListTile(String title, Cinsiyet cinsiyet) {
    return RadioListTile(
        title: Text(title),
        value: cinsiyet,
        groupValue: _secilenCinsiyet,
        onChanged: (Cinsiyet? secilmisCinsiyet) {
          setState(() {
            _secilenCinsiyet = secilmisCinsiyet!;
          });
        });
  }

  void _verileriOku() async {
    var info = await _preferenceService.verileriOku();

    _nameController.text = info.isim;
    _secilenCinsiyet = info.cinsiyet;
    _secilenRenkler = info.renk;
    _ogrenciMi = info.ogrenciMi;

    setState(() {});
  }
}
