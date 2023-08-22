// class AlertScheduleSettings {
//   String? alertScheduleName;
//   bool? isEnabled;
//   bool? isDefaultSchedule;
//   String? startTime;
//   String? endTime;
//   List<String>? daysOfWeek;

//   AlertScheduleSettings(
//       {this.alertScheduleName,
//         this.isEnabled,
//         this.isDefaultSchedule,
//         this.startTime,
//         this.endTime,
//         this.daysOfWeek});

//   AlertScheduleSettings.fromJson(Map<String, dynamic> json) {
//     alertScheduleName = json['alertScheduleName'];
//     isEnabled = json['isEnabled'];
//     isDefaultSchedule = json['isDefaultSchedule'];
//     startTime = json['startTime'];
//     endTime = json['endTime'];
//     daysOfWeek = json['daysOfWeek'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['alertScheduleName'] = this.alertScheduleName;
//     data['isEnabled'] = this.isEnabled;
//     data['isDefaultSchedule'] = this.isDefaultSchedule;
//     data['startTime'] = this.startTime;
//     data['endTime'] = this.endTime;
//     data['daysOfWeek'] = this.daysOfWeek;
//     return data;
//   }
// }