import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CarePlanVM extends ChangeNotifier{
  ProviderReference? _ref;
  CarePlanVM({ProviderReference? ref}){
    _ref = ref;
  }
}