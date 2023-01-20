
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/constants/validator.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/models/rpm_models/pulse_ox_reading_model.dart';
import 'package:twochealthcare/models/rpm_models/rpm_logs_model.dart';
import 'package:twochealthcare/models/rpm_models/weight_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/data_format.dart';

class RpmService{
  PublishSubject<bool> refreshModalities = PublishSubject<bool>(sync: true);
  double bGMaxLimit = 100;
  double bloodPressureMaxLimit = 100;
  DioServices? dio;
  SharedPrefServices? _sharedPrefServices;

  ProviderReference? _ref;

  RpmService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    dio = _ref?.read(dioServicesProvider);
    _sharedPrefServices = _ref?.read(sharedPrefServiceProvider);
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
            int month = int.parse(element.lastReadingDate!.split("/")[0]);
            int year = int.parse(element.lastReadingDate!.split("/")[2].split(" ")[0]);
            element.month = month;
            element.year = year;
          }
          else{
            element.month = DateTime.now().month;
            element.year = DateTime.now().year;
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
      // final dio = _ref!.read(dioServicesProvider);
      Response? response = await dio?.dio?.get(HealthCareDevicesController.getBloodGlucoseDeviceDatabyPatientId+"/$currentUserId"+"?startDate=${startDate.toString()}&endDate=${endDate.toString()}",
      );
      if(response?.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<BGDataModel> bGReadings = [];
        response?.data.forEach((element) {
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
  getWeightReading({int? currentUserId,DateTime? startDate,DateTime? endDate}) async {
    try{
      // final dio = _ref!.read(dioServicesProvider);
      Response? response = await dio?.dio?.get(HealthCareDevicesController.GetWeightDeviceDatabyPatientId+"/$currentUserId"+"?startDate=${startDate.toString()}&endDate=${endDate.toString()}",
      );
      if(response?.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<WeightReadingModel> bGReadings = [];
        response?.data.forEach((element) {
          bGReadings.add(WeightReadingModel.fromJson(element));
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
      // final dio = _ref!.read(dioServicesProvider);
      Response? response = await dio?.dio?.get(HealthCareDevicesController.getBPDeviceDataByPatientId+"/$currentUserId"+"?startDate=${startDate.toString()}&endDate=${endDate.toString()}",
      );
      if(response?.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<BloodPressureReadingModel> bPReadings = [];
        response?.data.forEach((element) {
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

  getPulseOxReading({int? currentUserId,DateTime? startDate,DateTime? endDate}) async {
    try{
      // final dio = _ref!.read(dioServicesProvider);
      Response? response = await dio?.dio?.get(HealthCareDevicesController.getPulseDeviceDatabyPatientId+"/$currentUserId"+"?startDate=${startDate.toString()}&endDate=${endDate.toString()}",
      );
      if(response?.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<PulseOxReadingModel> bPReadings = [];
        response?.data.forEach((element) {
          bPReadings.add(PulseOxReadingModel.fromJson(element));
        });
        if (bPReadings.length > 0) {
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

            element.measurementDate =
                Jiffy(element.measurementDate).format(Strings.dateAndTimeFormat);
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
      // final dio = _ref!.read(dioServicesProvider);
      Response? response = await dio?.dio?.post(RPMController.addRPMEncounter,data: body);
      return response;

    }catch(e){
      SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }

  Future<dynamic> editRpmEncounter(var body) async {

    try{
      // final dio = _ref!.read(dioServicesProvider);
      Response? response = await dio?.dio?.put(RPMController.editRpmEncounter,data: body);
      return response;

    }catch(e){
      SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }



  Future<bool> isValidUser(var body) async {

    try{
      // final dio = _ref!.read(dioServicesProvider);
      Response? response = await dio?.dio?.post(AccountApi.validateUser,data: body);
      if(response?.statusCode == 200){
        return true;
      }
      else{
        return false;
      }

    }catch(e){
      SnackBarMessage(message: e.toString(),error: true);
      return false;
    }

  }

  Future<dynamic> getRpmLogsByPatientId({int? patientId,int month = 0, int? year = 0}) async {
    try{
      List<RpmLogModel> rpmlogs = [];
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(RPMController.getRpmEncountersByPatientId+"/$patientId/$month/$year");
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







  Future<dynamic>getRpmPatients({int filterBy = 1,required int pageNumber,int patientStatus = 1,
    int rpmStatus = -1,
    int careProviderId = 0,
    int billingProviderId = 0,
    int? careFacilitatorId,
    String? diseaseIds,
    String? sortBy,int sortOrder=0,
    String? searchParam,
    required int serviceMonth, required int serviceYear,
    bool showAll = false,
    int rpmCareCoordinatorId = 0,
    String? dateAssignedFrom,String? dateAssignedTo,
    int assigned = 0,
    int fromTransmissionDays=0,int toTransmissionDays=0, int rpmTimeRange=0,int customeListId = 0,
    String? lastReadingStartDate,
    String? lastReadingEndDate,
    String? lastLogStartDate,
    String? lastLogEndDate,

  })async{
    String filteredMonth = "$serviceYear-$serviceMonth";
    PatientsForDashboard? patientsForDashboard;
    try{
      int pageSize = 10;
      int facilityId = await _sharedPrefServices!.getFacilityId();
      int facilityUserId = await _sharedPrefServices!.getCurrentUserId();
      int _careFacilitorId = careFacilitatorId?? facilityUserId;
    String querisParam = "?PageNumber=$pageNumber&PageSize=$pageSize&CustomListId=$customeListId&FilterBy=$filterBy"
        "&PatientStatus=$patientStatus&RpmStatus=$rpmStatus"
        "&LastReadingStartDate=${lastReadingStartDate??""}&LastReadingEndDate=${lastReadingEndDate??""}"
        "&LastLogStartDate=${lastLogStartDate??""}&LastLogEndDate=${lastLogEndDate??""}&CareProviderId=$careProviderId"
        "&BillingProviderId=$billingProviderId&CareFacilitatorId=$_careFacilitorId&DiseaseIds=${diseaseIds??""}"
        "&FacilityId=$facilityId&SortBy=${sortBy??""}&SortOrder=$sortOrder"
        "&SearchParam=${searchParam??""}&ServiceMonth=$serviceMonth&ServiceYear=$serviceYear&ShowAll=$showAll"
        "&RPMCareCoordinatorId=$rpmCareCoordinatorId"
        "&FilteredMonth=$filteredMonth&Assigned=$assigned&DateAssignedFrom=${dateAssignedFrom??""}"
        "&DateAssignedTo=${dateAssignedTo??""}&FromTransmissionDays=$fromTransmissionDays"
        "&ToTransmissionDays=$toTransmissionDays&rpmTimeRange=$rpmTimeRange";

      Response? res = await dio?.dio?.get(RPMController.getRpmPatients+querisParam);
      if(res?.statusCode == 200){
        patientsForDashboard = PatientsForDashboard.fromJson(res!.data);
        patientsForDashboard.patientsList?.forEach((element) {
          if(element.dateOfBirth != null ){
            element.age = findAgeInYears(dateOfBirht: element.dateOfBirth!);
          }
          element.primaryPhoneNumber = mask.getMaskedString(element.primaryPhoneNumber??"");

          if(element.patientStatus != null){
            if(element.patientStatus == 3 || element.patientStatus == 7 || element.patientStatus == 8){
              element.isDisable = true;
            }
          }
          if(element.lastAppLaunchDate !=null){
            DateTime currentDate = DateTime.now();
            final lastLoginDate = DateTime.parse(element.lastAppLaunchDate!);
            int difference = currentDate.difference(lastLoginDate).inDays;
            if(difference<30){
              element.isMobileUser = true;
            }
          }else{
            element.isMobileUser = false;
          }

        });
        return patientsForDashboard;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }

  }


}