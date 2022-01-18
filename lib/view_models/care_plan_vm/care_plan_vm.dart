import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/care_plan/CarePlanModel.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/care_plan_services/care_plan_services.dart';

class CarePlanVM extends ChangeNotifier{
  ProviderReference? _ref;
  CarePlanServices? _carePlanServices;
  CarePlanModel? carePlanModel;
  bool loadingCarePlan = false;
  TextEditingController challengesController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController healthCareAdvancedDirectivesController = TextEditingController();
  TextEditingController polstController = TextEditingController();
  TextEditingController powerOfAttorneyController = TextEditingController();
  TextEditingController iLearnBestByController = TextEditingController();
  TextEditingController dietIssuesController = TextEditingController();
  TextEditingController satisfactionController = TextEditingController();
  TextEditingController wantToImproveOnController = TextEditingController();
  TextEditingController concernedAboutOtherController = TextEditingController();
  CarePlanVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _carePlanServices = _ref!.read(carePlanServiceProvider);
  }
  setLoadingCarePlan(check){
    loadingCarePlan = check;
    notifyListeners();
  }
   getCarePlanByPatientId() async {
    try{
      setLoadingCarePlan(true);
      var res = await _carePlanServices?.getCarePlanByPatientId();
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
    challengesController.text = carePlanModel?.challengesComments??"";
    religionController.text = carePlanModel?.religionImpactOnHealthCareComments??"";
    healthCareAdvancedDirectivesController.text = carePlanModel?.healthCareAdvancedDirectivesComments??"";
    polstController.text = carePlanModel?.polstComments??"";
    powerOfAttorneyController.text = carePlanModel?.powerOfAttorneyComments??"";
    iLearnBestByController.text = carePlanModel?.iLearnBestByComment??"";
    dietIssuesController.text = carePlanModel?.dietIssuesComments??"";
    satisfactionController.text = carePlanModel?.satisfactionComment??"";
    wantToImproveOnController.text = carePlanModel?.wantToImproveOnComment??"";
    concernedAboutOtherController.text = carePlanModel?.concernedAboutOther??"";
  }
  }