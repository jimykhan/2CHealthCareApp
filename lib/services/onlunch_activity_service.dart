import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/firebase_service.dart';

class OnLunchActivityService{
  ProviderReference? _ref;
  FirebaseService? firebaseMessaging;

  OnLunchActivityService({ProviderReference? ref}){
    _ref = ref;
    _initServices();
  }
  _initServices(){
    firebaseMessaging = _ref!.read(firebaseServiceProvider);
  }
  syncLastApplicationUseDateAndTime(){

  }
}