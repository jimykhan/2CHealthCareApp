import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/aler_dialogue.dart';
import 'package:twochealthcare/common_widgets/alerts.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/models/rpm_models/rpm_inventory_device_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/patient_profile_service.dart';
import 'package:twochealthcare/services/phdevice_service/phdevice_service.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';
import 'package:twochealthcare/views/rpm_view/issue_device/enum.dart';

class IssuedDeviceVM extends ChangeNotifier{

  List<RpmInventoryDeviceModel> rpmInventoryDeviceList = [];
  // List<ModalitiesModel>? patientModalities; /// remove because now we check device from api
  RpmInventoryDeviceModel? issuedDevice;
  RpmService? rpmService;
  PatientProfileService? patientProfileService;
  bool cpt99453 = false;
  String cpt99453Message = "";
  bool isIssuedValid = false;
  bool modalityAleadyAssign = false;
  TextEditingController scanBarcode = TextEditingController();
  PhDeviceService? _phDeviceService;
  ProviderReference? _ref;
  bool loading = false;
  bool ActiveDeviceAlertLoading = false;

  IssuedDeviceVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }

  setLaoding(check){
    loading = check;
    notifyListeners();
  }
  initService(){
    _phDeviceService = _ref!.read(phDeviceServiceProvider);
    patientProfileService = _ref!.read(PatientProfileServiceProvider);
    rpmService = _ref!.read(rpmServiceProvider);
    _phDeviceService?.scanBarcode.listen((value) {
      scanBarcode.text = value;
      isIssuedValidDevice();
    });
  }

  initIssuedDeviceScreen({List<ModalitiesModel>? modalities}){
    scanBarcode.text = "";
    cpt99453 = false;
    cpt99453Message = "";
    issuedDevice = null;
    isIssuedValid = false;
    loading = false;
    modalityAleadyAssign = false;
    ActiveDeviceAlertLoading = false;
    // patientModalities = modalities;
  }

  onClickCPT994553(){
    cpt99453 = !cpt99453;
    notifyListeners();
  }
  issuedDeviceAlert(){
    if(!(ActiveDeviceAlertLoading)){
      AlertMessageCustomDesign(
          title: "The device ${issuedDevice?.serialNo} will be issued to ${patientProfileService?.patientInfo.fullName??""}. Do you want proceed?",
          onConfirm: (){
            Navigator.pop(applicationContext!.currentContext!);
            onIssuedDevice();
          }
      );
    }
  }
  onIssuedDevice()async{
    setLaoding(true);
    var res = await _phDeviceService?.assignDeviceToPatient(cpt99453, issuedDevice!.id!);
    if(res){
      rpmService?.refreshModalities.add(RefreshModalityData(-1, true));
    }

    setLaoding(false);
  }

  getRpmInventoryDeviceByFacilityId()async{
    var res = await _phDeviceService?.getPhInventoryDevicesByFacilityId();
    if(res is List){
      rpmInventoryDeviceList = [];
      res.forEach((element){
        rpmInventoryDeviceList.add(element);
      });
    }
  }

  checkUnbilledDeviceConfigClaimByPatientId()async{
     cpt99453Message = await _phDeviceService?.checkUnbilledDeviceConfigClaimByPatientId()??"";
    if(cpt99453Message ==""){
     cpt99453 = true;
    }
     notifyListeners();
  }

  activeDevice()async{
    try{
      ActiveDeviceAlertLoading = true;
      Navigator.pop(applicationContext!.currentContext!);
      bool isActive = await _phDeviceService?.ActiveDevice(issuedDevice!.id!)??false;
      if(isActive){
        issuedDevice?.status = PHDeviceStatus.Active.index;
        ActiveDeviceAlertLoading = false;
      }else{
        issuedDevice?.status = PHDeviceStatus.InActive.index;
        ActiveDeviceAlertLoading = false;
      }
      notifyListeners();
    }catch(ex){
      ActiveDeviceAlertLoading = false;
    }

  }
  Future<bool> isIssuedValidDevice() async {
    isIssuedValid = false;
    // modalityAleadyAssign = false;
    issuedDevice = rpmInventoryDeviceList.firstWhereOrNull((element) => element.serialNo?.trim().toLowerCase() == scanBarcode.text.trim().toLowerCase(),);
    if(issuedDevice != null){
      // var checkModality = patientModalities?.firstWhereOrNull((element)=> element.modality?.trim() == issuedDevice!.modality?.trim() && element.id != 0);
      // if(checkModality != null){
      //   modalityAleadyAssign = true;
      // }
      isIssuedValid = true;
    }
    notifyListeners();
    if(issuedDevice != null && issuedDevice?.status == PHDeviceStatus.InActive.index){
      ActiveDeviceAlert();
    }
    if(issuedDevice != null){
      await checkPatientDeviceExists(issuedDevice?.modality??"");
    }
    return isIssuedValid;
  }
  ActiveDeviceAlert(){
    if(!(ActiveDeviceAlertLoading)){
      AlertMessageCustomDesign(
          title: "${Strings.AlertToActiveDevice}",
          onConfirm: activeDevice
      );
    }
  }

  // issuedDeviceVM.issuedDevice != null ? (issuedDeviceVM.issuedDevice!.status == PHDeviceStatus.Active.index) ? Container() :
  //       Container(
  //           padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  // color: errorColor.withOpacity(0.3),
  // borderRadius: BorderRadius.circular(10)
  // ),
  // child: Text(Strings.AlertToActiveDevice
  // ,style: Styles.PoppinsRegular(fontSize: ApplicationSizing.fontScale(14),color: errorColor),)
  // )
  //     : Container(),
  bool onBarcodechange(String serialNumber){
    bool isIssuedValid = false;
    isIssuedValid = rpmInventoryDeviceList.firstWhereOrNull((element) => element.serialNo?.trim().toLowerCase() == scanBarcode.text.trim().toLowerCase(),) as bool;
    return isIssuedValid;
  }

  Future<dynamic> checkPatientDeviceExists(String modality) async {
    modalityAleadyAssign = false;
    bool response = await _phDeviceService?.checkPatientDeviceExists(modality: modality)??false;
    if(response){
      modalityAleadyAssign = true;
    }
    notifyListeners();
  }




}