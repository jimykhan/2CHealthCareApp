import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

class BloodPressureReadingService{
  ProviderReference? _ref;
  BloodPressureReadingService({ProviderReference? ref}){
    _ref = ref;
  }

  getBloodPressureReading({int? currentUserId,int? month,int? year}) async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.GET_BP_DEVICE_DATA_BY_PATIENTID+"/"+"$currentUserId/$month/$year",
      );
      if(response.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<BloodPressureReadingModel> bPReadings = [];
        response.data.forEach((element) {
          bPReadings.add(BloodPressureReadingModel.fromJson(element));
        });
        bPReadings.forEach((element) {
          element.measurementDate =
              Jiffy(element.measurementDate).format("dd MMM yy, h:mm a");
        });

        return bPReadings;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }
  }
}