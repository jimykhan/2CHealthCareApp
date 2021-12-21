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
