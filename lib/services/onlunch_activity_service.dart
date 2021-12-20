import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';

class OnLaunchActivityService{
  ProviderReference? _ref;
  FirebaseService? firebaseMessaging;
  DioServices? dio;
  AuthServices? _authService;

  OnLaunchActivityService({ProviderReference? ref}){
    _ref = ref;
    _initServices();
  }
  _initServices(){
    firebaseMessaging = _ref!.read(firebaseServiceProvider);
    dio = _ref!.read(dioServicesProvider);
    _authService = _ref!.read(authServiceProvider);
  }

  syncLastApplicationUseDateAndTime() async {
    int patientId = await _authService!.getCurrentUserId();
    dio!.dio!.post(ApiStrings.setLastAppLaunchDate+"/$patientId");
  }
}