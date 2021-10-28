import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/reading_services/modalities_reading_service.dart';

class ModalitiesReadingVM extends ChangeNotifier{
  ProviderReference? _ref;
  bool modalitiesLoading = true;
  List<ModalitiesModel> modalitiesList = [];
  AuthServices? _authService;
  ModalitiesReadingService? _modalitiesReadingService;
  ModalitiesReadingVM({ProviderReference? ref}){
    _ref = ref;
    initService();

  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _modalitiesReadingService = _ref!.read(modalitiesReadingServiceProvider);

  }

  setModalitiesLoading(bool f){
    modalitiesLoading = f;
    notifyListeners();
  }
  getModalitiesByUserId()async{
    // setModalitiesLoading(true);
    int id  = await _authService!.getCurrentUserId();
    var res = await _modalitiesReadingService?.getModalitiesByUserId(currentUserId: id);
    if(res is List){
      modalitiesList = [];
      res.forEach((element){
        modalitiesList.add(element);
      });
      // notifyListeners();
      setModalitiesLoading(false);
      print("set laoder false ${modalitiesLoading}");
    }
    setModalitiesLoading(false);
  }
}