import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/care_plan/CarePlanModel.dart';
import 'package:twochealthcare/models/patient_summary/chronic_condition.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/care_plan_services/care_plan_services.dart';
import 'package:twochealthcare/services/diagnosis_service.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/alliergies_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/diagnosis_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/medications_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/provider_body.dart';

class CarePlanVM extends ChangeNotifier{
  ProviderReference? _ref;
  CarePlanServices? _carePlanServices;
  DiagnosisService? _diagnosisService;
  CarePlanModel? carePlanModel;
  List<ChronicConditionModel> chronicConditions = [];
  bool loadingCarePlan = false;
  List carePlanHistory =  [
    {
      "isExpand": false,
      "title": "Health Issues",
      "body": DiagnosisBody(),
    },
    {
      "isExpand": false,
      "title": "Medication Managements",
      "body": MedicationsBody(),
    },
    {
      "isExpand": false,
      "title": "Allergies",
      "body": AllergiesBody(),
    },
    {
      "isExpand": false,
      "title": "Do you know which other specialists you are visiting?",
      "body": ProviderBody(),
    },
  ];
  TextEditingController challengesController = TextEditingController();
  TextEditingController dailyLivingController = TextEditingController();
  TextEditingController instrumentalDailyLivingController = TextEditingController();
  TextEditingController helpwithTransportationController = TextEditingController();
  TextEditingController eSLController = TextEditingController();
  TextEditingController patientPhoneNo = TextEditingController();
  TextEditingController discussWithPhysicianController = TextEditingController();
  TextEditingController chronicObstructiveController = TextEditingController();
  TextEditingController asthmaController = TextEditingController();
  TextEditingController depressionController = TextEditingController();
  // TextEditingController religionController = TextEditingController();
  // TextEditingController healthCareAdvancedDirectivesController = TextEditingController();

  TextEditingController polstController = TextEditingController();
  TextEditingController powerOfAttorneyController = TextEditingController();
  TextEditingController iLearnBestByController = TextEditingController();
  TextEditingController dietIssuesController = TextEditingController();
  TextEditingController satisfactionController = TextEditingController();
  TextEditingController wantToImproveOnController = TextEditingController();
  TextEditingController concernedAboutOtherController = TextEditingController();
  TextEditingController feelingDownController = TextEditingController();
  TextEditingController utilizingCommunityController = TextEditingController();
  CarePlanVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }


  initService(){
    _carePlanServices = _ref!.read(carePlanServiceProvider);
    _diagnosisService = _ref!.read(diagnosisServiceProvider);
  }

  ChangeCollaps(bool isCollaps, int Index){
    int i = 0;
    carePlanHistory.forEach((element) {
      if(Index == i){
        element["isExpand"] = !element["isExpand"];
      }
      else{
        element["isExpand"] = false;
      }
      i++;
    });
    notifyListeners();
  }
  setLoadingCarePlan(check){
    loadingCarePlan = check;
    notifyListeners();
  }
  getChronicConditionsByPatientId({int? Id}) async {
    try{
      setLoadingCarePlan(true);
      var res = await _diagnosisService?.getChronicConditionsByPatientId(Id: Id);
      if(res is List<ChronicConditionModel>){
          chronicConditions = res;
          setChronicConditionsValue();
      }
      setLoadingCarePlan(false);
    }catch(e){
      setLoadingCarePlan(false);
    }
  }

  getCarePlanByPatientId({int? Id}) async {
    try{
      setLoadingCarePlan(true);
      var res = await _carePlanServices?.getCarePlanByPatientId(Id: Id);
      if(res is CarePlanModel){
        carePlanModel = res;
        setValueToTextArea();
      }
      setLoadingCarePlan(false);
    }catch(e){
      setLoadingCarePlan(false);
    }
  }

  setValueToTextArea(){
    challengesController.text = carePlanModel?.physicalNote??"";
    dailyLivingController.text = carePlanModel?.dailyLivingActivitiesNote??"";
    instrumentalDailyLivingController.text = carePlanModel?.instrumentalDailyActivitiesNote??"";
    helpwithTransportationController.text = carePlanModel?.helpWithTransportation??"";
    eSLController.text = carePlanModel?.esl??"";
    patientPhoneNo.text = carePlanModel?.cellPhoneNumber??"";
    discussWithPhysicianController.text = carePlanModel?.physicalNote??"";
    feelingDownController.text = carePlanModel?.psychosocialNote??"";
    // religionController.text = carePlanModel?.religionImpactOnHealthCareComments??"";
    // healthCareAdvancedDirectivesController.text = carePlanModel?.healthCareAdvancedDirectivesComments??"";

    polstController.text = carePlanModel?.polstComments??"";
    powerOfAttorneyController.text = carePlanModel?.powerOfAttorneyComments??"";
    iLearnBestByController.text = carePlanModel?.iLearnBestByComment??"";
    dietIssuesController.text = carePlanModel?.dietIssuesComments??"";
    satisfactionController.text = carePlanModel?.satisfactionComment??"";
    wantToImproveOnController.text = carePlanModel?.wantToImproveOnComment??"";
    concernedAboutOtherController.text = carePlanModel?.concernedAboutOther??"";
    utilizingCommunityController.text = carePlanModel?.utilizingCommunity??"";
  }

  setChronicConditionsValue(){
    chronicObstructiveController.text = "";
    asthmaController.text = "";
    depressionController.text = "";
    chronicConditions.forEach((element) {
      if(element.chronicConditionId == 11) chronicObstructiveController.text = element.note??"";
      if(element.chronicConditionId == 12) depressionController.text = element.note??"";
      if(element.chronicConditionId == 6) asthmaController.text = element.note??"";
    });
  }
  }
