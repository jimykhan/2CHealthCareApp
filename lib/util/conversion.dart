import 'package:url_launcher/url_launcher.dart';

String convertLocalToUtc(String? dateTime){
  if(dateTime != null){
    DateTime date = DateTime.parse(dateTime+"Z");
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
  String phoneNumber = phoneNum.replaceAll("-", "");
  String formattedNum = "";
  for(int i=0; i< phoneNumber.length; i++){
    formattedNum = formattedNum + phoneNumber.substring(i,i+1);
    if(i==2 || i == 5){
      formattedNum = formattedNum +"-";
    }
  }
  return formattedNum;
}
