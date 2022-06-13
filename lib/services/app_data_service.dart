import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/app_data_models/country_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';

class AppDataService{
  ProviderReference? _ref;
  DioServices? _dioServices;
  AppDataService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }

  initService(){
    _dioServices = _ref!.read(dioServicesProvider);
  }

  Future<dynamic>getAllCountry()async{
    List<CountryModel> countryList = [];
    try{
      Response? res = await _dioServices?.dio?.get(AppDataController.getAllCountries);
      if(res?.statusCode == 200){

        res?.data?.forEach((element) {
          countryList.add(CountryModel.fromJson(element));
        });
        return countryList;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }
}