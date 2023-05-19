import 'package:url_launcher/url_launcher.dart';
import 'package:age_calculator/age_calculator.dart';

String convertLocalToUtc(String? dateTime){
  if(dateTime != null){
    // 2023-05-18T09:52:43+00:00
    //2023-05-18T09:56:20.8837055Z
    String newDate = "";
    if(dateTime.contains("+")){
      newDate = dateTime.split("+")[0]+".8837055";
    }else{
      newDate = dateTime;
    }
    DateTime date = DateTime.parse(newDate+"Z");
    return date.toLocal().toString();
  }else{
    return "";
  }
}
int countMonthDays({required int year, required int month}){
  return DateTime(year, month + 1, 0).day;
}

void launchURL({required String url}) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

String phoneNumberFormatter({required String phoneNum}){
  String phoneNumber = phoneNum.replaceAll("-", "").replaceAll("(", "").replaceAll(")", "")
  .replaceAll(" ", "").replaceAll("+1", "");
  String formattedNum = "";
  for(int i=0; i< phoneNumber.length; i++){
    formattedNum = formattedNum + phoneNumber.substring(i,i+1);
    if(i==2 || i == 5){
      formattedNum = formattedNum +"-";
    }
  }
  return formattedNum;
}

int findAgeInYears({required String dateOfBirht}){
  DateDuration duration;
  final dateOfBirth = DateTime.parse(dateOfBirht);
  duration = AgeCalculator.age(dateOfBirth, today: DateTime.now());
  return duration.years;

}
