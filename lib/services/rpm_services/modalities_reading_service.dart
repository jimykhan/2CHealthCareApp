//
// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:twochealthcare/constants/api_strings.dart';
// import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
// import 'package:twochealthcare/providers/providers.dart';
// import 'package:twochealthcare/util/conversion.dart';
//
// class ModalitiesReadingService{
//   int bPLastReadingMonth = DateTime.now().month;
//   int bPLastReadingYear = DateTime.now().year;
//   int bGLastReadingMonth = DateTime.now().month;
//   int bGLastReadingYear = DateTime.now().year;
//   ProviderReference? _ref;
//   ModalitiesReadingService({ProviderReference? ref}){
//     _ref = ref;
//   }
//
//   Future<dynamic> getModalitiesByUserId({int? currentUserId}) async {
//     // SharedPrefServices sharePrf = _ref!.read(sharedPrefServiceProvider);
//
//     try{
//       final dio = _ref!.read(dioServicesProvider);
//       Response response = await dio.dio!.get(ApiStrings.getPhdDeviceDataById+"/"+"$currentUserId",
//       );
//       if(response.statusCode == 200){
//         // sharePrf.setCurrentUser(response.data);
//         List<ModalitiesModel> modalities = [];
//          response.data.forEach((element) {
//            modalities.add(ModalitiesModel.fromJson(element));
//          });
//         modalities.forEach((element) {
//           if(element.lastReadingDate != null){
//
//             //   element.lastReadingDate = convertLocalToUtc(element.lastReadingDate!.replaceAll("Z", "")
//             //   .replaceAll("/", "-").replaceAll("A", "").replaceAll("P", "").replaceAll("M", "")
//             //       .replaceFirst(" ", "T").replaceAll(" ", ""),);
//             // print(element.lastReading);
//
//             int month = int.parse(element.lastReadingDate!.split("/")[0]);
//             int year = int.parse(element.lastReadingDate!.split("/")[2].split(" ")[0]);
//             if(element.modality == "BG") {
//               bGLastReadingMonth = month;
//               bGLastReadingYear = year;
//               print("last month of BG = ${month}");
//               print("last year of BG = ${year}");
//             }
//             if(element.modality == "BP") {
//               bPLastReadingMonth = month;
//               bPLastReadingYear = year;
//               print("last month of BP = ${month}");
//               print("last year of BP = ${year}");
//             }
//           }
//
//         });
//
//         return modalities;
//
//       }else{
//         return null;
//       }
//     }
//     catch(e){
//       print(e.toString());
//     }
//
//   }
//
// }