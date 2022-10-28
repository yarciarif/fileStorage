// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_storage/services/file_storage.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:flutter_storage/services/secure_storage.dart';
import 'package:flutter_storage/services/shared_pref_services.dart';
import 'package:get_it/get_it.dart';
import 'shared_pref_kullanimi.dart';


//GET IT ILE BI NESNE OLUSTURARAK O NESNEYI KURUCU METOTLARDA CALISMASINI SAGLAYABILIRIZ ABSTRACT CLASS LA BAGLANTILI OLARAK.
final locator = GetIt.instance;

void setup() {
   locator.registerSingleton<LocalStorageService>(FileStorageService()); 
  /* locator
      .registerLazySingleton<LocalStorageService>(() => FileStorageService()); */

/* // Alternatively you could write it if you don't like global variables
  GetIt.I.registerSingleton<AppModel>(AppModel()); */
}

void main() {
  //BU KOD ASYNC ISLEMLERDE ALTTAKI KODLARIN CALISMASINI BEKLEMEDEN CALISTIRIR.
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Storage Islemleri'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SharedPref()));
              },
              child: const Icon(Icons.abc_outlined),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
