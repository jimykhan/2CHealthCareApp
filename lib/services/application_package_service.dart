import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
// import 'package:new_version/new_version.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/new_version_pk/new_vesion_pk.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';

class ApplicationPackageService{
  DioServices? dioServices;
  ProviderReference? _ref;
  String? currentVersion;
  String? storeVersion;
  ApplicationPackageService({ProviderReference? ref}){
    _ref = ref;
    dioServices = _ref?.read(dioServicesProvider);
  }
  Future<void> checkForUpdate({String? currentVersion}) async {
    try{
      final newVersion = NewVersion(
        iOSId: "twochealthcare.io",
        androidId: "twochealthcare.io",
      );
      VersionStatus? status = await newVersion.getVersionStatus();
      if (status?.canUpdate is bool && status!.canUpdate) {
        newVersion.showUpdateDialog(
          context: applicationContext!.currentContext!,
          versionStatus: status,
          dialogTitle: "Update App",
          dialogText:
          "Your version is ${status.localVersion} availabe version ${status.storeVersion}",
          updateButtonText: "Update",
        );
      }
    }
    catch(e){
      return;
    }
  }

  compareVersionWithOld({String? currentVersion})async{
    String? newAppVersion ;
    var response = await dioServices?.dio?.get(GeneralController.GetNewAppVersion+"?key=mobileAppVersion");
    if(response?.statusCode == 200){
      newAppVersion = response?.data["value"];
    }
  }

  showAlert(){

  }
  
}