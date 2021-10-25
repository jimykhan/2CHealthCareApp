import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/services/auth_services/login_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/blood_pressure_reading_vm.dart';
import 'package:twochealthcare/view_models/splash_vm/splash_vm.dart';

final splachVMProvider =  ChangeNotifierProvider<SplashVM>((ref)=>SplashVM(ref: ref));
final loginVMProvider =  ChangeNotifierProvider<LoginVM>((ref)=>LoginVM(ref: ref));
final bloodPressureReadingVMProvider =  ChangeNotifierProvider<BloodPressureReadingVM>((ref)=>BloodPressureReadingVM(ref: ref));
final dioServicesProvider = Provider<DioServices>((ref)=>DioServices(ref: ref));

final loginServiceProvider = Provider<LoginServices>((ref)=>LoginServices(ref: ref));


