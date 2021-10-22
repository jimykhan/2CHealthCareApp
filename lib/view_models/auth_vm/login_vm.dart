import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginVM extends ChangeNotifier{
  ProviderReference? _ref;
  LoginVM({ProviderReference? ref}){
    _ref = ref;
  }
}