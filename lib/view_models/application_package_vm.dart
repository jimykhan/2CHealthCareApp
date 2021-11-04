import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:package_info/package_info.dart';

class ApplicationPackageVM extends ChangeNotifier{
  ProviderReference? _ref;
  String? currentVersion;
  String? storeVersion;
  PackageInfo? info;
  ApplicationPackageVM({ProviderReference? ref}){
    _ref = ref;
    initPackageInfo();
  }
  initPackageInfo() async {
    info = await PackageInfo.fromPlatform();
    currentVersion = info!.version;
  }
}