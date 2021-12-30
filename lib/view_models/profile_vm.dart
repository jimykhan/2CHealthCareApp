import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/profile_models/current_user_info_model.dart';
import 'package:twochealthcare/models/profile_models/paitent_care_providers_model.dart';
import 'package:twochealthcare/models/profile_models/state_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/profile_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

class ProfileVm extends ChangeNotifier{
  bool loading = true;
  CurrentUserInfo? currentUserInfo;
  List<PatientCareProvider> patientCareProvider = [];
  AuthServices? _authService;
  ProfileService? _profileService;
  SharedPrefServices? _sharedPrefServices;
  ProviderReference? _ref;

  /// Edit Contact Info Variable
  String primaryPhoneErrorText = "";
  bool isPrimaryPhoneFieldValid = true;
  String currentAddressErrorText = "";
  bool isCurrentAddressFieldValid = true;
  String cAZipCodeErrorText = "";
  bool isCAZipCodePhoneFieldValid = true;
  bool isMailingSame = false;
  TextEditingController? primaryPhoneEditController;
  TextEditingController? secondaryPhoneEditController;
  TextEditingController? currentAddressEditController;
  TextEditingController? cAZipCodeEditController;
  TextEditingController? cACityEditController;
  TextEditingController? cAStateEditController;
  TextEditingController? mailingAddressEditController;
  TextEditingController? mAZipCodeEditController;
  TextEditingController? mACityEditController;
  TextEditingController? mAStateEditController;
  List<StateModel> stateList = [];
  List<StateModel> filterStateList = [];
  /// Edit Contact Info Variable




  ProfileVm({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _profileService = _ref!.read(profileServiceProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);

  }
  setLoading(bool f){
    loading = f;
    notifyListeners();
  }

  Future<dynamic> getUserInfo() async {
    try{
      int userId = await _authService!.getCurrentUserId();
      setLoading(true);
      var res = await _profileService!.getUserInfo(currentUserId: userId);
      var res1 = await _profileService!.getCareProvider(currentUserId: userId);
      if(res1 is List<PatientCareProvider>){
        patientCareProvider = [];
        res1.forEach((element) {
          patientCareProvider.add(element);
        });
      }
      if(res is CurrentUserInfo){
        currentUserInfo = res;
        _sharedPrefServices!.setPatientInfo(res);
        setLoading(false);
      }else{
        setLoading(false);
      }
    }
    catch(e){
      setLoading(false);
      print(e.toString());
    }

  }


  /// Edit Contact Information Code portion
  onPrimaryPhoneChange(String val){}
  onCurrentAddressChange(String val){}
  oncAZipCodeChange(String val){}

  isFieldEmpty({required String text,required String fieldType}){
    if(text.isEmpty){
      if(fieldType.toUpperCase() == "PH"){
        notifyListeners();
        return;
      }
      else if(fieldType.toUpperCase() == "CA"){
        notifyListeners();
        return;
      }
      else if(fieldType.toUpperCase() == "CAZC"){
        notifyListeners();
        return;
      }
    }
  }
  onClickCheckButton(){
    isMailingSame = !isMailingSame;
    notifyListeners();
  }

  initEditContactInfo(){
    primaryPhoneEditController = TextEditingController();
    secondaryPhoneEditController = TextEditingController();
    currentAddressEditController = TextEditingController();
    cAZipCodeEditController = TextEditingController();
    cACityEditController = TextEditingController();
    cAStateEditController = TextEditingController();
    mailingAddressEditController = TextEditingController();
    mAZipCodeEditController = TextEditingController();
    mACityEditController = TextEditingController();
    mAStateEditController = TextEditingController();
    isMailingSame = false;
    setExistingValue();
    getStateList();
  }
  setExistingValue(){
    primaryPhoneEditController?.text = currentUserInfo?.homePhone??"";
    secondaryPhoneEditController?.text = currentUserInfo?.personNumber??"";
    currentAddressEditController?.text = currentUserInfo?.currentAddress??"";
    cACityEditController?.text = currentUserInfo?.city??"";
    cAStateEditController?.text = currentUserInfo?.state??"";
    cAZipCodeEditController?.text = currentUserInfo?.zip??"";
    mailingAddressEditController?.text = currentUserInfo?.mailingAddress??"";
    mACityEditController?.text = currentUserInfo?.maillingAddressCity??"";
    mAStateEditController?.text = currentUserInfo?.maillingAddressState??"";
    mAZipCodeEditController?.text = currentUserInfo?.maillingAddressZipCode??"";

    cAStateEditController?.addListener(() {
      if (cAStateEditController!.text == "") {
        filterStateList = [];
        filterStateList.addAll(stateList);
      } else {
        filterStateList = [];
        stateList.forEach((element) {
          if (element.name!.toLowerCase().contains(cAStateEditController!.text.toLowerCase())
          || element.code!.toLowerCase().contains(cAStateEditController!.text.toLowerCase())) {
            filterStateList.add(element);
          }
        });
      }
      notifyListeners();
    });
  }
  disposeEditContactInfo(){
    primaryPhoneEditController?.dispose();
    secondaryPhoneEditController?.dispose();
    currentAddressEditController?.dispose();
    cAZipCodeEditController?.dispose();
    cACityEditController?.dispose();
    cAStateEditController?.dispose();
    mailingAddressEditController?.dispose();
    mAZipCodeEditController?.dispose();
    mACityEditController?.dispose();
    mAStateEditController?.dispose();
  }

  editPatientContactInfo()async{

    try{
      int userId = await _authService!.getCurrentUserId();
      Map data = {
        "primaryPhoneNo": primaryPhoneEditController?.text??"",
        "secondaryContactNo": secondaryPhoneEditController?.text??"",
        "currentAddress": currentAddressEditController?.text??"",
        "mailingAddress": mailingAddressEditController?.text??"",
        "city": mACityEditController?.text??"",
        "state": mAStateEditController?.text??"",
        "zip": mAZipCodeEditController?.text??"",
        "emergencyContactName": "string",
        "emergencyContactRelationship": "string",
        "emergencyContactPrimaryPhoneNo": "string",
        "emergencyContactSecondaryPhoneNo": "string",
        "patientId": userId
      };
      setLoading(true);
      var res = await _profileService!.editPatientContactInfo(data: data);
      if(res){
        setLoading(false);
      }
      else{
        setLoading(false);
      }
    }
    catch(e){
      setLoading(false);
      print(e.toString());
    }
  }

  Future<dynamic> getStateList() async {
    try{
      var res = await _profileService!.getStatesList();
      if(res is List<StateModel>){
        stateList = [];
        res.forEach((element) {
          stateList.add(element);
        });
      }
    }
    catch(e){
      print(e.toString());
    }

  }
  /// Edit Contact Information Code portion
}