import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';

class OnLaunchActivityService{
  ProviderReference? _ref;
  FirebaseService? firebaseMessaging;
  DioServices? dio;
  AuthServices? _authService;
  LoginVM? loginVM;

  OnLaunchActivityService({ProviderReference? ref}){
    _ref = ref;
    _initServices();
  }
  _initServices(){
    firebaseMessaging = _ref!.read(firebaseServiceProvider);
    dio = _ref!.read(dioServicesProvider);
    _authService = _ref!.read(authServiceProvider);
    loginVM = _ref!.read(loginVMProvider);
  }

  syncLastApplicationUseDateAndTime() async {
    int patientId = await _authService!.getCurrentUserId();
    loginVM!.checkLastLoggedInUser(body: {
      "id":loginVM?.currentUser?.id?.toString()??"",
      "userName": loginVM?.currentUser?.fullName??"",
      "lastLogedIn": DateTime.now().toString()
    });
    Response res = await dio!.dio!.post(ApiStrings.setLastAppLaunchDate+"/$patientId");
    print(res);
  }
}