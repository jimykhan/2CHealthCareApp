// import 'package:dio/dio.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:twochealthcare/constants/api_strings.dart';
// import 'package:twochealthcare/constants/strings.dart';
// import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
// import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
// import 'package:twochealthcare/providers/providers.dart';
// import 'package:twochealthcare/services/shared_pref_services.dart';
// import 'package:twochealthcare/util/data_format.dart';
//
// class BloodPressureReadingService{
//   double bloodPressureMaxLimit = 100;
//   ProviderReference? _ref;
//   BloodPressureReadingService({ProviderReference? ref}){
//     _ref = ref;
//   }
//
//   getBloodPressureReading({int? currentUserId,DateTime? startDate,DateTime? endDate}) async {
//     try{
//       final dio = _ref!.read(dioServicesProvider);
//       Response response = await dio.dio!.get(ApiStrings.getBPDeviceDataByPatientId+"/$currentUserId"+"?startDate=${startDate.toString()}&endDate=${endDate.toString()}",
//       );
//       if(response.statusCode == 200){
//         // sharePrf.setCurrentUser(response.data);
//         List<BloodPressureReadingModel> bPReadings = [];
//         response.data.forEach((element) {
//           bPReadings.add(BloodPressureReadingModel.fromJson(element));
//         });
//         if (bPReadings.length > 0) {
//           // bPReadings.forEach((element) {
//           //   element.measurementDate = convertLocalToUtc(element.measurementDate!.replaceAll("Z", ""));
//           // });
//           bPReadings.sort((a, b) {
//             return double.parse(a.measurementDate!
//                 .trim()
//                 .replaceAll("-", "")
//                 .replaceAll("T", "")
//                 .replaceAll(":", "")
//                 .replaceAll("Z", "")
//                 .replaceAll(" ", "")
//             )
//                 .compareTo(double.parse(b.measurementDate!
//                 .trim()
//                 .replaceAll("-", "")
//                 .replaceAll("T", "")
//                 .replaceAll(":", "")
//                 .replaceAll("Z", "")
//                 .replaceAll(" ", "")
//             ));
//           });
//           bPReadings.forEach((element) {
//             // element.dat = DateTime.parse(element.measurementDate!
//             //     .trim()
//             //     .replaceAll("-", "")
//             //     .replaceAll(":", ""));
//
//             element.measurementDate =
//                 Jiffy(element.measurementDate).format(Strings.dateAndTimeFormat);
//             // element.measurementDate = Jiffy((DateFormat("yyyy-MM-dd HH:mm:ss").parse(DateTime.parse(element.measurementDate).toString(),true)).toLocal().toString()).format("dd MMM yy, h:mm a");
//             if (bloodPressureMaxLimit < element.highPressure!) {
//               bloodPressureMaxLimit = element.highPressure!;
//             }
//           });
//         }
//
//         return bPReadings;
//
//       }else{
//         return null;
//       }
//     }
//     catch(e){
//       print(e.toString());
//     }
//   }
// }