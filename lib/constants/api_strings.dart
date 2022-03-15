import 'package:flutter/foundation.dart' as Foundation;
 const String checkInternetConnection = 'www.google.com';
 const String test = "https://api.healthforcehub.link";
 const String staging = "https://apistaging.healthforcehub.link";
 const String production = "https://api.2chealthsolutions.com";
 const String baseUrl = test;
class ApiStrings {
  static const String signIn = baseUrl +"/api/Account/token2";
  static const String getPatientInfoById =
      baseUrl + "/api/Patients/GetPatientById";
  static const String postConfigureApi =
      baseUrl + "/api/PHDevices/ConfigurePhd";
  static const String getConfigureDevice =
      baseUrl + "/api/PHDevices/GetPHDevicesByPatientId";
  static const String removeDevice = baseUrl + "/api/PHDevices/RemovePhd";
  static const String publishReading =
      baseUrl + "/api/PHDevices/PublishPhdData";
  static const String publishReading2 =
      baseUrl + "/api/PHDevices/PublishPhdData2";
  static const String getPhdDeviceDataById =
      baseUrl + "/api/PHDevices/GetPHDevicesDataByPatientId";
  static const String getDexcomeCode = baseUrl + "/api/Dexcom/GetCode";
  static const String isSmsOrEmailVerified =
      baseUrl + "/api/Account/IsSMSOrEmailVerified";
  static const String forgotPassword = baseUrl + "/api/Account/ForgotPassword";
  static const String verifyResetPasswordCode =
      baseUrl + "/api/Account/VerifyResetPasswordCode";
  static const String resetPassword = baseUrl + "/api/Account/ResetPassword";
  static const String getBPDeviceDataByPatientId =
      baseUrl + "/api/HealthCareDevices/GetBPDeviceDataByPatientId";
  static const String getPatientById =
      baseUrl + "/api/Patients/GetPatientById";
  static const String getPatientsChronicDiseases =
      baseUrl + "/api/Patients/GetPatientsChronicDiseases";
  static const String getCareProvidersByPatientId =
      baseUrl + "/api/Patients/GetCareProvidersByPatientId";
  static const String getDexcomEgvs = baseUrl + "/api/Dexcom/GetEgvs";
  static const String getStatistics = baseUrl + "/api/Dexcom/GetStatistics";
  static const String getDexcomDevices = baseUrl + "/api/Dexcom/GetDevices";
  static const String getBloodGlucoseDeviceDatabyPatientId =
      baseUrl + "/api/HealthCareDevices/GetBloodGlucoseDeviceDatabyPatientId";
  static const String getChatGroupsByUserId =
      baseUrl + "/api/Chat/GetChatGroupsByUserId";
  static const String getPagedPrivateChatHistory =
      baseUrl + "/api/Chat/GetPagedPrivateChatHistory";
  static const String sendMessage = baseUrl + "/api/Chat";
  static const String markChatViewed = baseUrl + "/api/Chat/MarkChatViewed";
  static const String changePassword = baseUrl + "/api/Account/ChangePassword";
  static const String errorUrl =
      "https://e62aa90a591644a1b3def848bcceeb57@o600993.ingest.sentry.io/5744159";
  static const String sendError = baseUrl + "/api/Exceptions/PostMobileAppException";
  static const String checkChatStatus = baseUrl + "/api/Facility/IsChatServiceEnabled";
  static const String setLastAppLaunchDate = baseUrl + "/api/Patients/SetLastAppLaunchDate";
  static const String healthGuideLines = baseUrl + "/api/HealthGuideLines";
  static const String editPatientProfile = baseUrl + "/api/Patients/EditPatientProfile";
  static const String getStatesList = baseUrl + "/api/AppData/GetStatesList";
  static const String sendPhoneNoVerificationToken = baseUrl + "/api/Account/SendPhoneNoVerificationToken";
  static const String verifyPhoneNumber = baseUrl + "/api/Account/VerifyPhoneNumber";
  static const String sendVerificationEmail = baseUrl + "/api/Account/SendVerificationEmail";
  static const String getCarePlanMasterByPatientId = baseUrl + "/api/CarePlanMaster/GetCarePlanMasterByPatientId";
}
class PatientsController{
  static const String getPatientsForDashboard = baseUrl + "/api/Patients/GetPatientsForDashboard";
  static const String patientServiceSummary = baseUrl + "/api/Patients/PatientServicesSummary";
  static const String getPatients2 = baseUrl + "/api/Patients/GetPatients2";
}
class FacilityController{
  static const String getFacilityUser = baseUrl + "/api/Facility/GetFacilityUser";
  static const String facilityServiceConfigByFacilityId = baseUrl + "/api/FacilityServiceConfig/GetByFacilityId";
  static const String getFacilitiesByFacilityUserId = baseUrl + "/api/Facility/GetFacilitiesByFacilityUserId";
  static const String switchFacility = baseUrl + "/api/Facility/SwitchFacility";
}
class AccountApi{
  static const String refreshToken = baseUrl + "/api/Account/RefreshToken";
  static const String hangfireToken = baseUrl + "/api/Account/hangfireToken";
}
class BlueButton{
  static const String checkBlueButton = baseUrl + "/api/BlueButton/IsConnected";
  static const String getBlueButtonUrl = baseUrl + "/api/BlueButton/GetCode";
}

class MedicationsController{
  static const String getMedicationsByPatientId = baseUrl + "/api/Medications/GetMedicationsByPatientId";
  static const String getBlueButtonUrl = baseUrl + "/api/BlueButton/GetCode";
}
class AllergyController{
  static const String getPatientAllergy = baseUrl + "/api/allergy/GetPatientAllergy";

}

class DiagnoseController{
  static const String getDiagnosesByPatientId = baseUrl + "/api/Diagnosis/GetDiagnosesByPatientId";

}

class ImmunizationsController{
  static const String getImmunizationsOfPatient = baseUrl + "/api/Immunizations/GetImmunizationsOfPatient";

}

class FamilyHistoryController{
  static const String getFamilyHistory = baseUrl + "/api/FamilyHistory/GetFamilyHistory";

}