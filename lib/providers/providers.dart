import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/services/app_data_service.dart';
import 'package:twochealthcare/services/application_package_service.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/application_startup_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/care_plan_services/care_plan_services.dart';
import 'package:twochealthcare/services/ccm_services/ccm_services.dart';
import 'package:twochealthcare/services/chat_services/chat_list_service.dart';
import 'package:twochealthcare/services/chat_services/chat_screen_service.dart';
import 'package:twochealthcare/services/chat_services/patient_communication_service.dart';
import 'package:twochealthcare/services/connectivity_service.dart';
import 'package:twochealthcare/services/diagnosis_service.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/facility_user_services/facility_service.dart';
import 'package:twochealthcare/services/facility_user_services/patient_summary_service.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/health_guides_service/health_guides_service.dart';
import 'package:twochealthcare/services/local_notification_service.dart';
import 'package:twochealthcare/services/notification_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/services/patient_profile_service.dart';
import 'package:twochealthcare/services/permission_service.dart';
import 'package:twochealthcare/services/phdevice_service/phdevice_service.dart';
import 'package:twochealthcare/services/phs_form_service/phs_form_service.dart';
import 'package:twochealthcare/services/rpm_services/cgm_services.dart';
// import 'package:twochealthcare/services/rpm_services/bg_reading_service.dart';
// import 'package:twochealthcare/services/rpm_services/blood_pressure_reading_service.dart';
// import 'package:twochealthcare/services/rpm_services/modalities_reading_service.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';
import 'package:twochealthcare/services/s3-services/src/s3-crud-service.dart';
import 'package:twochealthcare/services/settings_services/fu_settings_services/fu_settings_service.dart';
import 'package:twochealthcare/services/settings_services/p_settings_services/p_settings_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/view_models/app_bar_vm.dart';
import 'package:twochealthcare/view_models/application_package_vm.dart';
import 'package:twochealthcare/view_models/auth_vm/forget-password-vm.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/care_plan_vm/care_plan_vm.dart';
import 'package:twochealthcare/view_models/ccm_vm/ccm_logs_vm.dart';
import 'package:twochealthcare/view_models/ccm_vm/ccm_patients_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/all_patient_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/chronic_care_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_home_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_profile_view_model.dart';
import 'package:twochealthcare/view_models/health_guides_vm/health_guides_vm.dart';
import 'package:twochealthcare/view_models/home_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/bg_reading_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/blood_pressure_reading_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/dexCom_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/modalities_reading_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/pulse_ox_reading_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_encounter_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_log_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_patients_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/tab_and_calender_vm.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/weight_reading_vm.dart';
import 'package:twochealthcare/view_models/settings_view_models/fu_settings_view_model/fu_settings_view_models.dart';
import 'package:twochealthcare/view_models/settings_view_models/p_settings_view_models/p_settings_view_model.dart';
import 'package:twochealthcare/view_models/splash_vm/splash_vm.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/barcode_view_model.dart';
import 'package:twochealthcare/views/admin_view/home_view/admin_home_view_model.dart';
import 'package:twochealthcare/views/phs_form/phs_form_view_model.dart';
import 'package:twochealthcare/views/rpm_view/issue_device/issue_device_vm.dart';
import 'package:twochealthcare/views/rpm_view/readings/Reading_view_model/ble_view_model.dart';

import '../view_models/ccm_vm/ccm_encounter_vm.dart';

/// ChangeNotifierProvider
final splachVMProvider =
    ChangeNotifierProvider<SplashVM>((ref) => SplashVM(ref: ref));
final loginVMProvider =
    ChangeNotifierProvider<LoginVM>((ref) => LoginVM(ref: ref));
final bloodPressureReadingVMProvider =
    ChangeNotifierProvider<BloodPressureReadingVM>(
        (ref) => BloodPressureReadingVM(ref: ref));
final modalitiesReadingVMProvider = ChangeNotifierProvider<ModalitiesReadingVM>(
    (ref) => ModalitiesReadingVM(ref: ref));
final bGReadingVMProvider =
    ChangeNotifierProvider<BGReadingVM>((ref) => BGReadingVM(ref: ref));
final profileVMProvider =
    ChangeNotifierProvider<ProfileVm>((ref) => ProfileVm(ref: ref));
final homeVMProvider =
    ChangeNotifierProvider<HomeVM>((ref) => HomeVM(ref: ref));
final applicationPackageVMProvider =
    ChangeNotifierProvider<ApplicationPackageVM>(
        (ref) => ApplicationPackageVM(ref: ref));
final chatListVMProvider =
    ChangeNotifierProvider<ChatListVM>((ref) => ChatListVM(ref: ref));
final chatScreenVMProvider =
    ChangeNotifierProvider<ChatScreenVM>((ref) => ChatScreenVM(ref: ref));
final tabAndCalenderVMProvider = ChangeNotifierProvider<TabAndCalenderVM>(
    (ref) => TabAndCalenderVM(ref: ref));
final healthGuidesVMProviders =
    ChangeNotifierProvider<HealthGuidesVM>((ref) => HealthGuidesVM(ref: ref));
final appBarVMProvider =
    ChangeNotifierProvider<AppBarVM>((ref) => AppBarVM(ref: ref));
final forgetPasswordVMProvider = ChangeNotifierProvider<ForgetPasswordVM>(
    (ref) => ForgetPasswordVM(ref: ref));
final carePlanVMProvider =
    ChangeNotifierProvider<CarePlanVM>((ref) => CarePlanVM(ref: ref));
final pSettigsVMProvider = ChangeNotifierProvider<PSettingsViewModel>(
    (ref) => PSettingsViewModel(ref: ref));
final fuHomeVMProvider =
    ChangeNotifierProvider<FUHomeViewModel>((ref) => FUHomeViewModel(ref: ref));
final fuProfileVMProvider =
    ChangeNotifierProvider<FUProfileVM>((ref) => FUProfileVM(ref: ref));
final fUPatientSummaryVMProvider = ChangeNotifierProvider<FUPatientSummaryVM>(
    (ref) => FUPatientSummaryVM(ref: ref));
final fuSettingsVMProvider = ChangeNotifierProvider<FuSettingsViewModel>(
    (ref) => FuSettingsViewModel(ref: ref));
final fuAllPatientVM =
    ChangeNotifierProvider<AllPatientVM>((ref) => AllPatientVM(ref: ref));
final fuChronicCareVMProvider =
    ChangeNotifierProvider<ChronicCareVM>((ref) => ChronicCareVM(ref: ref));
final rpmEncounterVMProvider =
    ChangeNotifierProvider<RpmEncounterVM>((ref) => RpmEncounterVM(ref: ref));
final ccmEncounterVMProvider =
    ChangeNotifierProvider<CcmEncounterVM>((ref) => CcmEncounterVM(ref: ref));
final ccmLogsVMProvider =
    ChangeNotifierProvider<CcmLogsVM>((ref) => CcmLogsVM(ref: ref));
final rpmLogsVMProvider =
    ChangeNotifierProvider<RpmLogsVM>((ref) => RpmLogsVM(ref: ref));
final ccmPatientsVMProvider =
    ChangeNotifierProvider<CcmPatientsVM>((ref) => CcmPatientsVM(ref: ref));
final rpmPatientsVMProvider =
    ChangeNotifierProvider<RpmPatientsVM>((ref) => RpmPatientsVM(ref: ref));
final dexComVMProvider =
    ChangeNotifierProvider<DexComVM>((ref) => DexComVM(ref: ref));
final weightReadingVMProvider =
    ChangeNotifierProvider<WeightReadingVM>((ref) => WeightReadingVM(ref: ref));
final pulseOxReadingVMProvider = ChangeNotifierProvider<PulseOxReadingVM>(
    (ref) => PulseOxReadingVM(ref: ref));
final adminHomeVMProvider =
    ChangeNotifierProvider<AdminHomeVM>((ref) => AdminHomeVM(ref: ref));
final barcodeVMProvider =
    ChangeNotifierProvider<BarcodeVM>((ref) => BarcodeVM(ref: ref));
final issuedDeviceVMProvider =
    ChangeNotifierProvider<IssuedDeviceVM>((ref) => IssuedDeviceVM(ref: ref));
final bleVMProvider = ChangeNotifierProvider<BleVM>((ref) => BleVM(ref: ref));
final phsFormVMProvider = ChangeNotifierProvider<PhsFormVeiwModel>(
    (ref) => PhsFormVeiwModel(ref: ref));

/// ChangeNotifierProvider

/// Simple Providers
final dioServicesProvider =
    Provider<DioServices>((ref) => DioServices(ref: ref));
final authServiceProvider =
    Provider<AuthServices>((ref) => AuthServices(ref: ref));
final sharedPrefServiceProvider =
    Provider<SharedPrefServices>((ref) => SharedPrefServices(ref: ref));
// final modalitiesReadingServiceProvider = Provider<ModalitiesReadingService>((ref)=>ModalitiesReadingService(ref: ref));
// final bloodPressureServiceProvider = Provider<BloodPressureReadingService>((ref)=>BloodPressureReadingService(ref: ref));
// final bGReadingServiceProvider = Provider<BGReadingService>((ref)=>BGReadingService(ref: ref));
final PatientProfileServiceProvider =
    Provider<PatientProfileService>((ref) => PatientProfileService(ref: ref));
final firebaseServiceProvider =
    Provider<FirebaseService>((ref) => FirebaseService(ref: ref));
final signalRServiceProvider =
    Provider<SignalRServices>((ref) => SignalRServices(ref: ref));
final chatScreenServiceProvider =
    Provider<ChatScreenService>((ref) => ChatScreenService(ref: ref));
final chatListServiceProvider =
    Provider<ChatListService>((ref) => ChatListService(ref: ref));
final connectivityServiceProvider =
    Provider<ConnectivityService>((ref) => ConnectivityService(ref: ref));
final applicationRouteServiceProvider =
    Provider<ApplicationRouteService>((ref) => ApplicationRouteService());
final localNotificationServiceProvider = Provider<LocalNotificationService>(
    (ref) => LocalNotificationService(ref: ref));
final notificationServiceProvider =
    Provider<NotificationService>((ref) => NotificationService(ref: ref));
final onLaunchActivityServiceProvider =
    Provider<OnLaunchActivityAndRoutesService>(
        (ref) => OnLaunchActivityAndRoutesService(ref: ref));
final healthGuidesServiceProvider =
    Provider<HealthGuidesService>((ref) => HealthGuidesService(ref: ref));
final carePlanServiceProvider =
    Provider<CarePlanServices>((ref) => CarePlanServices(ref: ref));
final pSettingsServiceProvider =
    Provider<PSettingsService>((ref) => PSettingsService(ref: ref));
final facilityServiceProvider =
    Provider<FacilityService>((ref) => FacilityService(ref: ref));
final fuSettingsServiceProvider =
    Provider<FuSettingsService>((ref) => FuSettingsService(ref: ref));
final patientSummaryServiceProvider =
    Provider<PatientSummaryService>((ref) => PatientSummaryService(ref: ref));
final rpmServiceProvider = Provider<RpmService>((ref) => RpmService(ref: ref));
final ccmServiceProvider = Provider<CcmService>((ref) => CcmService(ref: ref));
final diagnosisServiceProvider =
    Provider<DiagnosisService>((ref) => DiagnosisService(ref: ref));
final appDataServiceProvider =
    Provider<AppDataService>((ref) => AppDataService(ref: ref));
final applicationPackageServiceProvider = Provider<ApplicationPackageService>(
    (ref) => ApplicationPackageService(ref: ref));
final applicationStartupServiceProvider = Provider<ApplicationStartupService>(
    (ref) => ApplicationStartupService(ref: ref));
final cgmServiceProvider = Provider<CGMService>((ref) => CGMService(ref: ref));
final s3CrudServiceProvider =
    Provider<S3CrudService>((ref) => S3CrudService(ref: ref));
final phDeviceServiceProvider =
    Provider<PhDeviceService>((ref) => PhDeviceService(ref: ref));
final permissionServiceProvider =
    Provider<PermissionService>((ref) => PermissionService(ref: ref));
final patientCommunicationServiceProvider =
    Provider<PatientCommunicationService>(
        (ref) => PatientCommunicationService(ref: ref));

final phsFormServiceProvider = Provider<PhsFormService>((ref) => PhsFormService(ref: ref));
/// Simple Providers
