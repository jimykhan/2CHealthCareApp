import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/rpm_services/modalities_reading_service.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';

class ModalitiesReadingVM extends ChangeNotifier{
  // int bPLastReadingMonth = DateTime.now().month;
  // int bPLastReadingYear = DateTime.now().year;
  // int bGLastReadingMonth = DateTime.now().month;
  // int bGLastReadingYear = DateTime.now().year;
  ProviderReference? _ref;
  bool modalitiesLoading = true;
  bool isActiveModality = false;
  List<ModalitiesModel> modalitiesList = [];
  AuthServices? _authService;
  // ModalitiesReadingService? _modalitiesReadingService;
  RpmService? _rpmService;
  ModalitiesReadingVM({ProviderReference? ref}){
    _ref = ref;
    initService();

  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _rpmService = _ref!.read(rpmServiceProvider);

  }

  setModalitiesLoading(bool f){
    modalitiesLoading = f;
    notifyListeners();
  }

  getModalitiesByUserId()async{
    // setModalitiesLoading(true);
    int id  = await _authService!.getCurrentUserId();
    var res = await _rpmService?.getModalitiesByUserId(currentUserId: id);
    if(res is List){
      modalitiesList = [];
      res.forEach((element){
        modalitiesList.add(element);
      });
       // bPLastReadingMonth = _rpmService!.bPLastReadingMonth;
       // bPLastReadingYear = _rpmService!.bPLastReadingYear;
       // bGLastReadingMonth = _rpmService!.bGLastReadingMonth;
       // bGLastReadingYear = _rpmService!.bGLastReadingYear;
      modalitiesList.forEach((element) {
        if(element.id != 0 || element.lastReading != null) isActiveModality = true;
        // if(element.id != 0) isActiveModality = true;
      });
      // notifyListeners();
      setModalitiesLoading(false);
    }
    setModalitiesLoading(false);
  }
}