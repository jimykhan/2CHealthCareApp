
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FuSettingsViewModel extends ChangeNotifier{
  ProviderReference? _ref;
  FuSettingsViewModel({ProviderReference? ref}){
    _ref = ref;
  }
}