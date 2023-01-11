import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/rpm_models/rpm_inventory_device_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/phdevice_service/phdevice_service.dart';

class IssuedDeviceVM extends ChangeNotifier{

  List<RpmInventoryDeviceModel> rpmInventoryDeviceList = [];
  RpmInventoryDeviceModel? issuedDevice;
  bool cpt99453 = false;
  String cpt99453Message = "";
  bool isIssuedValid = false;
  TextEditingController scanBarcode = TextEditingController();
  PhDeviceService? _phDeviceService;
  ProviderReference? _ref;
  bool loading = false;

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
    _phDeviceService?.scanBarcode.listen((value) {
      scanBarcode.text = value;
      isIssuedValidDevice();
    });
  }

  initIssuedDeviceScreen(){
    scanBarcode.text = "";
    cpt99453 = false;
    cpt99453Message = "";
    issuedDevice = null;
    isIssuedValid = false;
    loading = false;
  }

  onClickCPT994553(){
    cpt99453 = !cpt99453;
    notifyListeners();
  }

  onIssuedDevice()async{
    setLaoding(true);
    var res = await _phDeviceService?.assignDeviceToPatient(cpt99453, issuedDevice!.id!);
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
  bool isIssuedValidDevice(){
    isIssuedValid = false;
    issuedDevice = rpmInventoryDeviceList.firstWhereOrNull((element) => element.serialNo?.trim().toLowerCase() == scanBarcode.text.trim().toLowerCase(),);
    if(issuedDevice != null){
      isIssuedValid = true;
    }
    notifyListeners();
    return isIssuedValid;

  }
  bool onBarcodechange(String serialNumber){
    bool isIssuedValid = false;
    isIssuedValid = rpmInventoryDeviceList.firstWhereOrNull((element) => element.serialNo?.trim().toLowerCase() == scanBarcode.text.trim().toLowerCase(),) as bool;
    return isIssuedValid;

  }


}