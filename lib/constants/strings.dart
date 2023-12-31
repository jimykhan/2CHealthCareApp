class Strings {
  static const String noConnection = 'No internet connection detected, please try again.';
  static const String unknownError = 'Unknown error occurred, please try again later.';
  static const String retry = 'Retry';
  static const String dateFormat = "dd MMM yy";
  static const String dateFormatFullYear = "dd MMM yyyy";
  static const String dateAndTimeFormat = "dd MMM yy, h:mm a";
  static const String MonthYear = "MMMM yyyy";
  static const String TimeFormat = "h:mm a";
  static const String ScanDeviceNotFound = "Scanned device is not found in the In Hand Inventory. Please make sure device is available and not issued to any other patient.";
  static const String AlertToActiveDevice = "Device status is not “Active”, do you want to activate this device. Please note that reactivation charges may apply.";
  static const String AleadyDeviceAssignText = "Patient already has Blood Glucose device assigned. Please return that device before assigning a new device for same Blood Glucose. Current device serial number is ";
  static const String DeviceIssued = "Device issue successfully";
  // Generic strings
  static const String ok = 'OK';
  static const String cancel = 'Cancel';

  // Logout
  static const String logout = 'Logout';
  static const String logoutAreYouSure =
      'Are you sure that you want to logout?';
  static const String logoutFailed = 'Logout failed';

  // Sign In Page
  static const String signIn = 'Sign in';
  static const String signInWithEmailPassword =
      'Sign in with email and password';
  static const String goAnonymous = 'Go anonymous';
  static const String or = 'or';
  static const String signInFailed = 'Sign in failed';

  // Home page
  static const String homePage = 'Home Page';

  // Jobs page
  static const String jobs = 'Jobs';

  // Entries page
  static const String entries = 'Entries';

  // Account page
  static const String account = 'Account';
  static const String accountPage = 'Account Page';

  static const List<String> relationshipList =[
    "Spouse",
    "Mother",
    "Father",
    "Siblings",
    "Son",
    "Daughter",
    "Step-Son",
    "Step-Daughter",
    "Grand Father",
    "Grand Mother",
    "Grand Son",
    "Cousin",
    "Niece",
    "Nephew",
    "Neighbor/Friend",
    "Other",
  ];
  // <ng-option [value]="'Spouse'">Spouse</ng-option>
  // <ng-option [value]="'Mother'">Mother</ng-option>
  // <ng-option [value]="'Father'">Father</ng-option>
  // <ng-option [value]="'Siblings'">Siblings</ng-option>
  // <ng-option [value]="'Son'">Son</ng-option>
  // <ng-option [value]="'Daughter'">Daughter</ng-option>
  // <ng-option [value]="'Step-Son'">Step-Son</ng-option>
  // <ng-option [value]="'Step-Daughter'">Step-Daughter</ng-option>
  // <ng-option [value]="'Grand Father'">Grand Father</ng-option>
  // <ng-option [value]="'Grand Mother'">Grand Mother</ng-option>
  // <ng-option [value]="'Grand Son'">Grand Son</ng-option>
  // <ng-option [value]="'Grand Daughter'">Grand Daughter</ng-option>
  // <ng-option [value]="'Cousin'">Cousin</ng-option>
  // <ng-option [value]="'Niece'">Niece</ng-option>
  // <ng-option [value]="'Nephew'">Nephew</ng-option>
  // <ng-option [value]="'Neighbor/Friend'">Neighbor/Friend</ng-option>
  // <ng-option [value]="'Other'">Other</ng-option>


}

class ScreenName{
  static const String chatHistory = "chatHistory";
  static const String chatList = "chatList";
}
