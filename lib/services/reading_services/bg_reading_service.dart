import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

class BGReadingService{
  ProviderReference? _ref;
  BGReadingService({ProviderReference? ref}){
    _ref = ref;
  }

  getBGReading({int? currentUserId,int? month,int? year}) async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.GET_BG_DEVICE_DATA_BY_PATIENTID+"/"+"$currentUserId/$month/$year",
      );
      if(response.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<BGDataModel> bGReadings = [];
        response.data.forEach((element) {
          bGReadings.add(BGDataModel.fromJson(element));
        });
        bGReadings.forEach((element) {
          element.measurementDate =
              Jiffy(element.measurementDate).format("dd MMM yy, h:mm a");
        });

        return bGReadings;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }
  }
}