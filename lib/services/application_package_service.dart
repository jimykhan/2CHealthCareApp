import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
// import 'package:new_version/new_version.dart';
import 'package:twochealthcare/main.dart';
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

  Future<String?> compareVersionWithOld({String? currentVersion})async{
    String? newAppVersion ;
    try{
      var response = await dioServices?.dio?.get(GeneralController.GetNewAppVersion+"?key=mobileAppVersion");
      if(response?.statusCode == 200){
        return newAppVersion = response?.data["value"];
      }else{
        return null;
      }
    }catch(ex){
      return null;
    }

  }

  showAlert(){

  }
  
}