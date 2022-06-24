import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:package_info/package_info.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_package_service.dart';

class ApplicationPackageVM extends ChangeNotifier{
  ProviderReference? _ref;
  String? currentVersion;
  String? storeVersion;
  PackageInfo? info;
  ApplicationPackageService? _applicationPackageService;
  ApplicationPackageVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _applicationPackageService = _ref?.read(applicationPackageServiceProvider);
    initPackageInfo();
  }
  initPackageInfo() async {
    info = await PackageInfo.fromPlatform();
    currentVersion = info!.version;
    notifyListeners();
  }
  checkForUpdate(){
    _applicationPackageService?.checkForUpdate();
  }
}