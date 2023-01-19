import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:package_info/package_info.dart';
import 'package:twochealthcare/common_widgets/alerts.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_package_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationPackageVM extends ChangeNotifier{
  ProviderReference? _ref;
  String? currentVersion;
  // String? storeVersion;
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
  checkForUpdate()async{
    // _applicationPackageService?.checkForUpdate();
    String? appVersion = await _applicationPackageService?.compareVersionWithOld(currentVersion: info?.version??"");
    print(appVersion);
    if(appVersion != null){
      bool canUpdateApp = canUpdate(info!.version, appVersion);
      print(canUpdateApp);
      if(canUpdateApp){
        AlertMessage(applicationContext!.currentContext!,
            message: "Your version is ${info!.version} availabe version ${appVersion}",
            onConfirm:  (Platform.isAndroid) ? AndroidUpdateLouncher : IosUpdateLouncher,
            confirmText: "Update Now"
        );
      }

    }
  }
  bool  canUpdate (localVersion,storeVersion){
    final local = localVersion.split('.').map(int.parse).toList();
    final store = storeVersion.split('.').map(int.parse).toList();
    for (var i = 0; i < store.length; i++) {
      // The store version field is newer than the local version.
      if (store[i] > local[i]) {
        return true;
      }
      // The local version field is newer than the store version.
      if (local[i] > store[i]) {
        return false;
      }
    }
    // The local and store versions are the same.
    return false;
  }

  IosUpdateLouncher(){
    launchAppStore("https://apps.apple.com/us/app/2c-health-care/id1572782591?uo=4");
  }
  AndroidUpdateLouncher(){
    launchAppStore("https://play.google.com/store/apps/details?id=twochealthcare.io");
  }

  Future<void> launchAppStore(String appStoreLink) async {
    debugPrint(appStoreLink);
    if (await canLaunch(appStoreLink)) {
      await launch(appStoreLink);
    } else {
      throw 'Could not launch appStoreLink';
    }
  }

//   getSpot(){
//     List<FlSpot> k = [];
//     int i = 1;
//     [].forEach((element) {
//       k.length == 5 ? null : k.add(FlSpot(x: i.toDouble(), y: element.hour));
//       i++;
//     });
//
//     switch(i) {
//       case 1: {
// // statements;
//       }
//       break;
//
//       case 2: {
// //statements;
//       }
//       break;
//
//       default: {
// //statements;
//       }
//       break;
//     }
//   }
}



// class FlSpot{
//   double x;
//   double y;
//
//   FlSpot({required this.x,required this.y});
// }