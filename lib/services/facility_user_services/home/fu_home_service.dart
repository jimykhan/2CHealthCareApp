import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';

class FUHomeService{
  // String api = "https://api.healthforcehub.link/api/Patients/GetPatientsForDashboard
  //     ?PageNumber=1&
  // PageSize=10&
  // FacilityId=1&
  // SortBy=&
  // SortOrder=0&
  // SearchParam=&
  // PayerIds=&
  // FilterBy=1&
  // PatientStatus="
  ProviderReference? _ref;
  DioServices? dio;
  ChatListService({ProviderReference? ref}){
    _ref = ref;
  }
  initService(){
    dio = _ref!.read(dioServicesProvider);
  }

    getPatientsForDashboard(){

    }

}