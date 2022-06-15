
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/models/rpm_models/rpm_logs_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/data_format.dart';

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
      SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }

  Future<dynamic> editRpmEncounter(var body) async {

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.put(RPMController.editRpmEncounter,data: body);
      return response;

    }catch(e){
      SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }



  Future<bool> isValidUser(var body) async {

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(AccountApi.validateUser,data: body);
      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }

    }catch(e){
      // SnackBarMessage(message: e.toString(),error: true);
      return false;
    }

  }

  Future<dynamic> getRpmLogsByPatientId({int? patientId,int month = 0, int? year = 0}) async {
    try{
      List<RpmLogModel> rpmlogs = [];
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(RPMController.getRpmEncountersByPatientId+"/${patientId}/${month}/${year}");
      if(response.statusCode == 200){
        response.data.forEach((element) {
          rpmlogs.add(RpmLogModel.fromJson(element));
        });

        rpmlogs.forEach((element) {

          // Call = 0,
          // SMS = 1,
          // PhysicalInteraction = 2
          int rpmServiceType = element.rpmServiceType??0;
          if(rpmServiceType == 0) element.rpmServiceTypeString = "Call";
          if(rpmServiceType == 1) element.rpmServiceTypeString = "SMS";
          if(rpmServiceType == 2) element.rpmServiceTypeString = "Physical Interaction";
          if(element.encounterDate !=null) {
            // DateTime dateTime = DateTime.parse(element.encounterDate!.replaceAll("/", "").replaceFirst(" ", "T").replaceAll(":", "").replaceAll(" ", ""));
            String time = element.encounterDate!.split(" ")[1];
            element.encounterDate = element.encounterDate!.split(" ")[0];
            List date = element.encounterDate!.split("/");
            int i = 0;
            int month = 1;
            int day = 1;
            int year = 2022;
            int startHour = 0;
            int startMints = 0;
            date.forEach((element1) {
              if(i == 0)  month = int.parse(element1);
              if(i == 1)  day = int.parse(element1);
              if(i == 2)  year = int.parse(element1);
              i = i+1;
            });
            int j = 0;
            time.split(":").forEach((element2) {
              if(j == 0) startHour = int.parse(element2);
              if(j == 1) startMints = int.parse(element2);
              j = j+1;
            });

            element.dateTime = DateTime(year,month,day,startHour,startMints);
          }

          if(element.duration != null){
            List duration = element.duration?.split(":")??[];
            int index = 0;
            duration.forEach((element1) {
              if(index == 0){
                int totalHour = int.parse(element1);
                totalHour = totalHour * 60;
                element.durationInMints = element.durationInMints + totalHour;
              }
              if(index == 1){
                int totalMints = int.parse(element1);
                element.durationInMints = element.durationInMints + totalMints;
              }
              index = index+1;
            });
          }
        });

        return rpmlogs;
      }
      return null;

    }catch(e){
      // SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }




}