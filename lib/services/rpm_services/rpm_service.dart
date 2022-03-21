
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/conversion.dart';

class RpmService{
  int bPLastReadingMonth = DateTime.now().month;
  int bPLastReadingYear = DateTime.now().year;
  int bGLastReadingMonth = DateTime.now().month;
  int bGLastReadingYear = DateTime.now().year;
  double bGMaxLimit = 100;
  double bloodPressureMaxLimit = 100;
  ProviderReference? _ref;
  RpmService({ProviderReference? ref}){
    _ref = ref;
  }

  Future<dynamic> getModalitiesByUserId({int? currentUserId}) async {
    // SharedPrefServices sharePrf = _ref!.read(sharedPrefServiceProvider);

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getPhdDeviceDataById+"/"+"$currentUserId",
      );
      if(response.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<ModalitiesModel> modalities = [];
        response.data.forEach((element) {
          modalities.add(ModalitiesModel.fromJson(element));
        });
        modalities.forEach((element) {
          if(element.lastReadingDate != null){

            //   element.lastReadingDate = convertLocalToUtc(element.lastReadingDate!.replaceAll("Z", "")
            //   .replaceAll("/", "-").replaceAll("A", "").replaceAll("P", "").replaceAll("M", "")
            //       .replaceFirst(" ", "T").replaceAll(" ", ""),);
            // print(element.lastReading);

            int month = int.parse(element.lastReadingDate!.split("/")[0]);
            int year = int.parse(element.lastReadingDate!.split("/")[2].split(" ")[0]);
            if(element.modality == "BG") {
              bGLastReadingMonth = month;
              bGLastReadingYear = year;
              print("last month of BG = ${month}");
              print("last year of BG = ${year}");
            }
            if(element.modality == "BP") {
              bPLastReadingMonth = month;
              bPLastReadingYear = year;
              print("last month of BP = ${month}");
              print("last year of BP = ${year}");
            }
          }

        });

        return modalities;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }

  }



  getBGReading({int? currentUserId,DateTime? startDate,DateTime? endDate}) async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getBloodGlucoseDeviceDatabyPatientId+"/$currentUserId"+"?startDate=${startDate.toString()}&endDate=${endDate.toString()}",
      );
      if(response.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<BGDataModel> bGReadings = [];
        response.data.forEach((element) {
          bGReadings.add(BGDataModel.fromJson(element));
        });
        if (bGReadings.length > 0) {
          // bGReadings.forEach((element) {
          //   element.measurementDate = convertLocalToUtc(element.measurementDate!.replaceAll("Z", ""));
          // });
          bGReadings.sort((a, b) {
            return double.parse(a.measurementDate!
                .trim()
                .replaceAll("-", "")
                .replaceAll("T", "")
                .replaceAll(":", "")
                .replaceAll("Z", "")
                .replaceAll(" ", "")
            )
                .compareTo(double.parse(b.measurementDate!
                .trim()
                .replaceAll("-", "")
                .replaceAll("T", "")
                .replaceAll(":", "")
                .replaceAll("Z", "")
                .replaceAll(" ", "")
            ));
          });
          bGReadings.forEach((element) {
            // element.datetime = DateTime.parse(element.measurementDate.trim().replaceAll("-", "").replaceAll(":", ""));
            element.measurementDate =
                Jiffy(element.measurementDate).format(Strings.dateAndTimeFormat);
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



  getBloodPressureReading({int? currentUserId,DateTime? startDate,DateTime? endDate}) async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getBPDeviceDataByPatientId+"/$currentUserId"+"?startDate=${startDate.toString()}&endDate=${endDate.toString()}",
      );
      if(response.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<BloodPressureReadingModel> bPReadings = [];
        response.data.forEach((element) {
          bPReadings.add(BloodPressureReadingModel.fromJson(element));
        });
        if (bPReadings.length > 0) {
          // bPReadings.forEach((element) {
          //   element.measurementDate = convertLocalToUtc(element.measurementDate!.replaceAll("Z", ""));
          // });
          bPReadings.sort((a, b) {
            return double.parse(a.measurementDate!
                .trim()
                .replaceAll("-", "")
                .replaceAll("T", "")
                .replaceAll(":", "")
                .replaceAll("Z", "")
                .replaceAll(" ", "")
            )
                .compareTo(double.parse(b.measurementDate!
                .trim()
                .replaceAll("-", "")
                .replaceAll("T", "")
                .replaceAll(":", "")
                .replaceAll("Z", "")
                .replaceAll(" ", "")
            ));
          });
          bPReadings.forEach((element) {
            // element.dat = DateTime.parse(element.measurementDate!
            //     .trim()
            //     .replaceAll("-", "")
            //     .replaceAll(":", ""));

            element.measurementDate =
                Jiffy(element.measurementDate).format(Strings.dateAndTimeFormat);
            // element.measurementDate = Jiffy((DateFormat("yyyy-MM-dd HH:mm:ss").parse(DateTime.parse(element.measurementDate).toString(),true)).toLocal().toString()).format("dd MMM yy, h:mm a");
            if (bloodPressureMaxLimit < element.highPressure!) {
              bloodPressureMaxLimit = element.highPressure!;
            }
          });
        }

        return bPReadings;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  Future<dynamic> addRpmEncounter(var body) async {

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(RPMController.addRPMEncounter,data: body);
      return response;

    }catch(e){
      return null;
    }

  }

}