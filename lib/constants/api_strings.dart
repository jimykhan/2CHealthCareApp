class ApiStrings {
  static const String CHECK_INTERNET_CONNECTION = 'www.google.com';
  static const String test = "https://api.healthforcehub.net";
  static const String Production = "https://api.2chealthsolutions.com";
  static const String development = "https://cea4-39-45-161-120.ngrok.io";
  static const String baseUrl = test;
  static const String SIGN_IN = "/api/Account/token2";
  static const String GET_PATIENT_INFO_BY_ID =
      baseUrl + "/api/Patients/GetPatientById";
  static const String POST_CONFIGURE_API =
      baseUrl + "/api/PHDevices/ConfigurePhd";
  static const String GET_CONFIGURE_DEVICE =
      baseUrl + "/api/PHDevices/GetPHDevicesByPatientId";
  static const String REMOVE_DEVICE = baseUrl + "/api/PHDevices/RemovePhd";
  static const String PUBLISH_READING =
      baseUrl + "/api/PHDevices/PublishPhdData";
  static const String PUBLISH_READING2 =
      baseUrl + "/api/PHDevices/PublishPhdData2";
  static const String GET_PHDEVICE_DATA_BY_ID =
      baseUrl + "/api/PHDevices/GetPHDevicesDataByPatientId";
  static const String GET_DEXCOM_CODE = baseUrl + "/api/Dexcom/GetCode";
  static const String IS_SMS_OR_EMAIL_VERIFIED =
      baseUrl + "/api/Account/IsSMSOrEmailVerified";
  static const String FORGOT_PASSWORD = baseUrl + "/api/Account/ForgotPassword";
  static const String VERIFY_RESET_PASSWORD_CODE =
      baseUrl + "/api/Account/VerifyResetPasswordCode";
  static const String RESET_PASSWORD = baseUrl + "/api/Account/ResetPassword";
  static const String GET_BP_DEVICE_DATA_BY_PATIENTID =
      baseUrl + "/api/HealthCareDevices/GetBPDeviceDatabyPatientId";
  static const String GET_PATIENT_BY_ID =
      baseUrl + "/api/Patients/GetPatientById";
  static const String GET_PATIENT_CHRONIC_DISEASES =
      baseUrl + "/api/Patients/GetPatientsChronicDiseases";
  static const String GET_CAREPROVIDERS_BY_PATIENT_ID =
      baseUrl + "/api/Patients/GetCareProvidersByPatientId";
  static const String DEXCOM_GET_EGVS = baseUrl + "/api/Dexcom/GetEgvs";
  static const String DEXCOM_GET_STATISTICS =
      baseUrl + "/api/Dexcom/GetStatistics";
  static const String DEXCOM_GET_DEVICES = baseUrl + "/api/Dexcom/GetDevices";
  static const String GET_BG_DEVICE_DATA_BY_PATIENTID =
      baseUrl + "/api/HealthCareDevices/GetBloodGlucoseDeviceDatabyPatientId";
  static const String GET_CHAT_GROUPS_BY_USER_ID =
      baseUrl + "/api/Chat/GetChatGroupsByUserId";
  static const String GET_ALL_MESSAGES =
      baseUrl + "/api/Chat/GetPagedPrivateChatHistory";
  static const String SEND_MESSAGE = baseUrl + "/api/Chat";
  static const String CHANGE_PASSWORD = baseUrl + "/api/Account/ChangePassword";
  static const String ERROR_URL =
      "https://e62aa90a591644a1b3def848bcceeb57@o600993.ingest.sentry.io/5744159";
  static const String SEND_ERROR =
      baseUrl + "/api/Exceptions/PostMobileAppException";
}