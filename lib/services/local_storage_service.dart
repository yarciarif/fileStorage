import 'package:flutter_storage/model/my_models.dart';

abstract class LocalStorageService {
  Future<void> verileriKaydet(UserInformation userInfo);
  Future<UserInformation> verileriOku();
}
