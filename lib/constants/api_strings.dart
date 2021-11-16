class ApiStrings {
  static const String checkInternetConnection = 'www.google.com';
  static const String test = "https://api.healthforcehub.net";
  static const String production = "https://api.2chealthsolutions.com";
  static const String development = "https://cea4-39-45-161-120.ngrok.io";
  static const String baseUrl = production;
  static const String signIn = "/api/Account/token2";
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
  static const String changePassword = baseUrl + "/api/Account/ChangePassword";
  static const String errorUrl =
      "https://e62aa90a591644a1b3def848bcceeb57@o600993.ingest.sentry.io/5744159";
  static const String sendError =
      baseUrl + "/api/Exceptions/PostMobileAppException";
}