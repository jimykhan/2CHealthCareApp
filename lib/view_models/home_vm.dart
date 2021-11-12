import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:new_version/new_version.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';

class HomeVM extends ChangeNotifier{
  AuthServices? _authService;
  ProviderReference? _ref;

  HomeVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
  }

  Future<void> checkForUpdate() async {
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
      // dismissButtonText: 'Custom dismiss button text',
      // dismissAction: () => Navigator.pop(context),
    );
    }
  }
}