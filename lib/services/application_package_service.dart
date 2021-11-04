import 'package:hooks_riverpod/hooks_riverpod.dart';

class ApplicationPackageService{
  ProviderReference? _ref;
  String? currentVersion;
  String? storeVersion;
  ApplicationPackageService({ProviderReference? ref}){
    _ref = ref;
  }
  chechVersion(){

  }
}