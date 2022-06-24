import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:new_version/new_version.dart';
import 'package:twochealthcare/main.dart';

class ApplicationPackageService{
  ProviderReference? _ref;
  String? currentVersion;
  String? storeVersion;
  ApplicationPackageService({ProviderReference? ref}){
    _ref = ref;
  }
  Future<void> checkForUpdate() async {


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
}