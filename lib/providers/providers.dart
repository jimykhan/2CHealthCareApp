import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/view_models/splash_vm.dart';

final splachVMProvider =  ChangeNotifierProvider<SplashVM>((ref)=>SplashVM(ref: ref));