import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/care_plan_services/care_plan_services.dart';
import 'package:twochealthcare/services/chat_services/chat_list_service.dart';
import 'package:twochealthcare/services/chat_services/chat_screen_service.dart';
import 'package:twochealthcare/services/connectivity_service.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_home_service.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_profile_service.dart';
import 'package:twochealthcare/services/facility_user_services/patient_summary_service.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/health_guides_service/health_guides_service.dart';
import 'package:twochealthcare/services/local_notification_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/services/patient_profile_service.dart';
import 'package:twochealthcare/services/reading_services/bg_reading_service.dart';
import 'package:twochealthcare/services/reading_services/blood_pressure_reading_service.dart';
import 'package:twochealthcare/services/reading_services/modalities_reading_service.dart';
import 'package:twochealthcare/services/settings_services/fu_settings_services/fu_settings_service.dart';
import 'package:twochealthcare/services/settings_services/p_settings_services/p_settings_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/view_models/app_bar_vm.dart';
import 'package:twochealthcare/view_models/application_package_vm.dart';
import 'package:twochealthcare/view_models/auth_vm/forget-password-vm.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/care_plan_vm/care_plan_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/all_patient_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/chronic_care_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_home_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_profile_view_model.dart';
import 'package:twochealthcare/view_models/health_guides_vm/health_guides_vm.dart';
import 'package:twochealthcare/view_models/home_vm.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/bg_reading_vm.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/blood_pressure_reading_vm.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/modalities_reading_vm.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/tab_and_calender_vm.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/view_models/settings_view_models/fu_settings_view_model/fu_settings_view_models.dart';
import 'package:twochealthcare/view_models/settings_view_models/p_settings_view_models/p_settings_view_model.dart';
import 'package:twochealthcare/view_models/splash_vm/splash_vm.dart';
/// ChangeNotifierProvider
final splachVMProvider =  ChangeNotifierProvider<SplashVM>((ref)=>SplashVM(ref: ref));
final loginVMProvider =  ChangeNotifierProvider<LoginVM>((ref)=>LoginVM(ref: ref));
final bloodPressureReadingVMProvider =  ChangeNotifierProvider<BloodPressureReadingVM>((ref)=>BloodPressureReadingVM(ref: ref));
final modalitiesReadingVMProvider = ChangeNotifierProvider<ModalitiesReadingVM>((ref)=>ModalitiesReadingVM(ref: ref));
final bGReadingVMProvider = ChangeNotifierProvider<BGReadingVM>((ref)=>BGReadingVM(ref: ref));
final profileVMProvider = ChangeNotifierProvider<ProfileVm>((ref)=>ProfileVm(ref: ref));
final homeVMProvider = ChangeNotifierProvider<HomeVM>((ref)=>HomeVM(ref: ref));
final applicationPackageVMProvider = ChangeNotifierProvider<ApplicationPackageVM>((ref)=>ApplicationPackageVM(ref: ref));
final chatListVMProvider = ChangeNotifierProvider<ChatListVM>((ref)=>ChatListVM(ref: ref));
final chatScreenVMProvider = ChangeNotifierProvider<ChatScreenVM>((ref)=>ChatScreenVM(ref: ref));
final tabAndCalenderVMProvider = ChangeNotifierProvider<TabAndCalenderVM>((ref)=>TabAndCalenderVM(ref: ref));
final healthGuidesVMProviders = ChangeNotifierProvider<HealthGuidesVM>((ref)=>HealthGuidesVM(ref: ref));
final appBarVMProvider = ChangeNotifierProvider<AppBarVM>((ref)=>AppBarVM(ref: ref));
final forgetPasswordVMProvider = ChangeNotifierProvider<ForgetPasswordVM>((ref)=>ForgetPasswordVM(ref: ref));
final carePlanVMProvider = ChangeNotifierProvider<CarePlanVM>((ref)=>CarePlanVM(ref: ref));
final pSettigsVMProvider = ChangeNotifierProvider<PSettingsViewModel>((ref)=>PSettingsViewModel(ref: ref));
/// ChangeNotifierProvider


/// Simple Providers
final dioServicesProvider = Provider<DioServices>((ref)=>DioServices(ref: ref));
final authServiceProvider = Provider<AuthServices>((ref)=>AuthServices(ref: ref));
final sharedPrefServiceProvider = Provider<SharedPrefServices>((ref)=>SharedPrefServices(ref: ref));
final modalitiesReadingServiceProvider = Provider<ModalitiesReadingService>((ref)=>ModalitiesReadingService(ref: ref));
final bloodPressureServiceProvider = Provider<BloodPressureReadingService>((ref)=>BloodPressureReadingService(ref: ref));
final bGReadingServiceProvider = Provider<BGReadingService>((ref)=>BGReadingService(ref: ref));
final PatientProfileServiceProvider = Provider<PatientProfileService>((ref)=>PatientProfileService(ref: ref));
final firebaseServiceProvider = Provider<FirebaseService>((ref)=>FirebaseService(ref: ref));
final signalRServiceProvider = Provider<SignalRServices>((ref)=>SignalRServices(ref: ref));
final chatScreenServiceProvider = Provider<ChatScreenService>((ref)=>ChatScreenService(ref: ref));
final chatListServiceProvider = Provider<ChatListService>((ref)=>ChatListService(ref: ref));
final connectivityServiceProvider = Provider<ConnectivityService>((ref)=>ConnectivityService(ref: ref));
final applicationRouteServiceProvider = Provider<ApplicationRouteService>((ref)=>ApplicationRouteService());
final localNotificationServiceProvider = Provider<LocalNotificationService>((ref)=>LocalNotificationService(ref: ref));
final onLaunchActivityServiceProvider = Provider<OnLaunchActivityAndRoutesService>((ref)=>OnLaunchActivityAndRoutesService(ref: ref));
final healthGuidesServiceProvider = Provider<HealthGuidesService>((ref)=>HealthGuidesService(ref: ref));
final carePlanServiceProvider = Provider<CarePlanServices>((ref)=>CarePlanServices(ref: ref));
final pSettingsServiceProvider = Provider<PSettingsService>((ref)=>PSettingsService(ref: ref));
/// Simple Providers


///Facility User ChangeNotifier Provider
final fuHomeVMProvider = ChangeNotifierProvider<FUHomeViewModel>((ref)=>FUHomeViewModel(ref: ref));
final fuProfileVMProvider = ChangeNotifierProvider<FUProfileVM>((ref)=>FUProfileVM(ref: ref));
final fUPatientSummaryVMProvider = ChangeNotifierProvider<FUPatientSummaryVM>((ref)=>FUPatientSummaryVM(ref: ref));
final fuSettingsVMProvider = ChangeNotifierProvider<FuSettingsViewModel>((ref)=>FuSettingsViewModel(ref: ref));
final fuAllPatientVM = ChangeNotifierProvider<AllPatientVM>((ref)=>AllPatientVM(ref: ref));
final fuChronicCareVMProvider = ChangeNotifierProvider<ChronicCareVM>((ref)=>ChronicCareVM(ref: ref));
///Facility User ChangeNotifier Provider
///Facility User Simple Provider
final fuHomeServiceProvider = Provider<FUHomeService>((ref)=>FUHomeService(ref: ref));
final fuProfileServiceProvider = Provider<FUProfileService>((ref)=>FUProfileService(ref: ref));
final fuSettingsServiceProvider = Provider<FuSettingsService>((ref)=>FuSettingsService(ref: ref));
final patientSummaryServiceProvider = Provider<PatientSummaryService>((ref)=>PatientSummaryService(ref: ref));
///Facility User Simple Provider