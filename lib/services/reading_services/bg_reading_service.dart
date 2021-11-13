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
  double bGMaxLimit = 100;
  ProviderReference? _ref;
  BGReadingService({ProviderReference? ref}){
    _ref = ref;
  }

  getBGReading({int? currentUserId,int? month,int? year}) async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getBloodGlucoseDeviceDatabyPatientId+"/"+"$currentUserId/$month/$year",
      );
      if(response.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<BGDataModel> bGReadings = [];
        response.data.forEach((element) {
          bGReadings.add(BGDataModel.fromJson(element));
        });
        if (bGReadings.length > 0) {
          bGReadings.sort((a, b) {
            return double.parse(a.measurementDate!
                .trim()
                .replaceAll("-", "")
                .replaceAll("T", "")
                .replaceAll(":", ""))
                .compareTo(double.parse(b.measurementDate!
                .trim()
                .replaceAll("-", "")
                .replaceAll("T", "")
                .replaceAll(":", "")));
          });
          bGReadings.forEach((element) {
            // element.datetime = DateTime.parse(element.measurementDate.trim().replaceAll("-", "").replaceAll(":", ""));
            element.measurementDate =
                Jiffy(element.measurementDate).format("dd MMM yy, h:mm a");
            // element.measurementDate = Jiffy((DateFormat("yyyy-MM-dd HH:mm:ss").parse(DateTime.parse(element.measurementDate).toString(),true)).toLocal().toString()).format("dd MMM yy, h:mm a");
            if (bGMaxLimit < element.bg!) {
              bGMaxLimit = element.bg!;
            }
          });
        }

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