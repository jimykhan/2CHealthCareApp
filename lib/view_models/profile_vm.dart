import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/constants/validator.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/profile_models/current_user_info_model.dart';
import 'package:twochealthcare/models/profile_models/paitent_care_providers_model.dart';
import 'package:twochealthcare/models/profile_models/state_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/patient_profile_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:twochealthcare/views/home/profile.dart';

class ProfileVm extends ChangeNotifier{
  bool loading = true;
  PatientInfo? patientInfo;
  List<PatientCareProvider> patientCareProvider = [];
  AuthServices? _authService;
  PatientProfileService? _PatientProfileService;
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
  TextEditingController? emergencyNameEditController;
  TextEditingController? emergencyPrimaryPhoneEditController;
  TextEditingController? emergencySecondaryPhoneEditController;
  /// Edit Emergency Contact Variable
  String dropdownValue = "Spouse";

  /// Edit Emergency Contact Variable




  ProfileVm({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _PatientProfileService = _ref!.read(PatientProfileServiceProvider);
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
      var res = await _PatientProfileService!.getUserInfo(currentUserId: userId);
      var res1 = await _PatientProfileService!.getCareProvider(currentUserId: userId);
      if(res1 is List<PatientCareProvider>){
        patientCareProvider = [];
        res1.forEach((element) {
          patientCareProvider.add(element);
        });
      }
      if(res1 == null){
        patientCareProvider = [];
      }
      if(res is PatientInfo){
        patientInfo = res;
        /// Here i need phone number verification flow
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
  onPrimaryPhoneChange(String val){
    if(Validator.PhoneNumberValidator(val)){
      if(!isPrimaryPhoneFieldValid){
        primaryPhoneErrorText = "";
        isPrimaryPhoneFieldValid = true;
        notifyListeners();
      }
    }else{
      if(isPrimaryPhoneFieldValid){
        primaryPhoneErrorText = "Please Enter your primary phone number";
        isPrimaryPhoneFieldValid = false;
        notifyListeners();
      }
    }
  }
   onCurrentAddressChange(String val){
    if(Validator.AddressValidator(val)){
      if(!isCurrentAddressFieldValid){
        currentAddressErrorText = "";
        isCurrentAddressFieldValid = true;
        notifyListeners();
      }
    }else{
      if(isCurrentAddressFieldValid){
        currentAddressErrorText = "Please Enter your current address";
        isCurrentAddressFieldValid = false;
        notifyListeners();
      }
    }

  }
  oncAZipCodeChange(String val){
    if(Validator.ZipCodeValidator(val)){
      if(!isCAZipCodePhoneFieldValid){
        cAZipCodeErrorText = "";
        isCAZipCodePhoneFieldValid = true;
        notifyListeners();

      }
    }else{
      if(isCAZipCodePhoneFieldValid){
        cAZipCodeErrorText = "Please Enter your current address";
        isCAZipCodePhoneFieldValid = false;
        notifyListeners();
      }
    }
  }

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
    primaryPhoneEditController?.text = phoneNumberFormatter(phoneNum: patientInfo?.homePhone??"");
    secondaryPhoneEditController?.text = phoneNumberFormatter(phoneNum:patientInfo?.personNumber??"");
    currentAddressEditController?.text = patientInfo?.currentAddress??"";
    cACityEditController?.text = patientInfo?.city??"";
    cAStateEditController?.text = patientInfo?.state??"";
    cAZipCodeEditController?.text = patientInfo?.zip??"";
    mailingAddressEditController?.text = patientInfo?.mailingAddress??"";
    mACityEditController?.text = patientInfo?.maillingAddressCity??"";
    mAStateEditController?.text = patientInfo?.maillingAddressState??"";
    mAZipCodeEditController?.text = patientInfo?.maillingAddressZipCode??"";

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
        // "primaryPhoneNo": "923005653984",
        "primaryPhoneNo": primaryPhoneEditController?.text.replaceAll("-", "")??"",
        "secondaryContactNo": secondaryPhoneEditController?.text.replaceAll("-", "")??"",
        "currentAddress": currentAddressEditController?.text??"",
        "mailingAddress": mailingAddressEditController?.text??"",
        "city": cACityEditController?.text??"",
        "state": cAStateEditController?.text??"",
        "zip": cAZipCodeEditController?.text??"",
        "emergencyContactName": patientInfo?.emergencyContactName??"",
        "emergencyContactRelationship": patientInfo?.emergencyContactRelationship??"",
        "emergencyContactPrimaryPhoneNo": patientInfo?.emergencyContactPrimaryPhoneNo??"",
        "emergencyContactSecondaryPhoneNo": patientInfo?.emergencyContactSecondaryPhoneNo??"",
        "patientId": userId
      };
      setLoading(true);
      var res = await _PatientProfileService!.editPatientContactInfo(data: data);
      if(res){
        Navigator.pushReplacement(applicationContext!.currentContext!, PageTransition(child: Profile(), type: PageTransitionType.fade));
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

  bool checkRequireFieldValid(){
      bool primaryNo = Validator.PhoneNumberValidator(primaryPhoneEditController?.text??"");
      bool currentAddress = Validator.AddressValidator(currentAddressEditController?.text??"");
      bool currenZipCode = Validator.ZipCodeValidator(cAZipCodeEditController?.text??"");
      if(primaryNo && currentAddress && currenZipCode){
        return true;
      }else{
        SnackBarMessage(message: "Please enter require field !");
        oncAZipCodeChange(cAZipCodeEditController?.text??"");
        onCurrentAddressChange(currentAddressEditController?.text??"");
        onPrimaryPhoneChange(primaryPhoneEditController?.text??"");
        return false;
      }
  }
  Future<dynamic> getStateList() async {
    try{
      var res = await _PatientProfileService!.getStatesList();
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


  /// Edit Emergency Contact code portion
  onRelationShipChange(val){
    dropdownValue = val;
    notifyListeners();
  }
  initEditEmergencyContactInfo(){
    emergencyNameEditController = TextEditingController();
    emergencyPrimaryPhoneEditController = TextEditingController();
    emergencySecondaryPhoneEditController = TextEditingController();
    emergencyNameEditController?.text = patientInfo?.emergencyContactName??"";
    emergencyPrimaryPhoneEditController?.text = phoneNumberFormatter(phoneNum:patientInfo?.emergencyContactPrimaryPhoneNo??"");
    emergencySecondaryPhoneEditController?.text = phoneNumberFormatter(phoneNum:patientInfo?.emergencyContactSecondaryPhoneNo??"");
    Strings.relationshipList.forEach((element) {
      if(element == patientInfo?.emergencyContactRelationship){
        dropdownValue = patientInfo?.emergencyContactRelationship??"";
      }
    });
    // dropdownValue = patientInfo?.emergencyContactRelationship??"Other";
  }

  editEmergencyContactInfo()async{
    try{
      int userId = await _authService!.getCurrentUserId();
      Map data = {
        "primaryPhoneNo": patientInfo?.homePhone?.replaceAll("-", "")??"",
        "secondaryContactNo": patientInfo?.emergencyContactSecondaryPhoneNo?.replaceAll("-", "")??"",
        "currentAddress": patientInfo?.currentAddress??"",
        "mailingAddress": patientInfo?.mailingAddress??"",
        "city": patientInfo?.city??"",
        "state": patientInfo?.state??"",
        "zip": patientInfo?.zip??"",
        "emergencyContactName": emergencyNameEditController?.text??"",
        "emergencyContactRelationship": dropdownValue,
        "emergencyContactPrimaryPhoneNo": emergencyPrimaryPhoneEditController?.text.replaceAll("-", "")??"",
        "emergencyContactSecondaryPhoneNo": emergencySecondaryPhoneEditController?.text.replaceAll("-", "")??"",
        "patientId": userId
      };
      setLoading(true);
      var res = await _PatientProfileService!.editPatientContactInfo(data: data);
      if(res){
        Navigator.pushReplacement(applicationContext!.currentContext!, PageTransition(child: Profile(), type: PageTransitionType.fade));
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
  /// Edit Emergency Contact code portion
}