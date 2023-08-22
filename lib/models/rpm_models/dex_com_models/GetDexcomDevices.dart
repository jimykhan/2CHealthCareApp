// import 'package:twochealthcare/models/rpm_models/dex_com_models/AlertScheduleList.dart';

// class GetDexcomDeivice {
//   List<Devices>? devices;

//   GetDexcomDeivice({this.devices});

//   GetDexcomDeivice.fromJson(Map<String, dynamic> json) {
//     if (json['devices'] != null) {
//       devices = [];
//       json['devices'].forEach((v) {
//         devices!.add(new Devices.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.devices != null) {
//       data['devices'] = this.devices!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Devices {
//   String? transmitterGeneration;
//   String? displayDevice;
//   String? lastUploadDate;
//   List<AlertScheduleList>? alertScheduleList;

//   Devices(
//       {this.transmitterGeneration,
//       this.displayDevice,
//       this.lastUploadDate,
//       this.alertScheduleList});

//   Devices.fromJson(Map<String, dynamic> json) {
//     transmitterGeneration = json['transmitterGeneration'];
//     displayDevice = json['displayDevice'];
//     lastUploadDate = json['lastUploadDate'];
//     if (json['alertScheduleList'] != null) {
//       alertScheduleList = [];
//       json['alertScheduleList'].forEach((v) {
//         alertScheduleList!.add(new AlertScheduleList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['transmitterGeneration'] = this.transmitterGeneration;
//     data['displayDevice'] = this.displayDevice;
//     data['lastUploadDate'] = this.lastUploadDate;
//     if (this.alertScheduleList != null) {
//       data['alertScheduleList'] =
//           this.alertScheduleList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
