// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:hooks_riverpod/all.dart';
// import 'package:twochealthcare/common_widgets/circular_svg_icon.dart';
// import 'package:twochealthcare/providers/providers.dart';
// import 'package:twochealthcare/services/chat/video_call/signaling_service.dart';
// import 'package:twochealthcare/services/chat/video_calling_view_model.dart';
// import 'package:twochealthcare/styles/styles.dart';
// class videoCallingScreen extends HookWidget {
//   String calleeName;
//    videoCallingScreen({required this.calleeName,Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // videoCallingViewModel callingViewModel = useProvider(VideoCallingService);
//     Future.microtask(() async {
//     });
//     return SafeArea(
//       child: Scaffold(
//         body: callingViewModel.CallState == callingState.onGoingCall ? onGoingCall(context,callingViewModel: callingViewModel,calleeName: calleeName) :
//         acceptCall(context,callingViewModel: callingViewModel)
//       ),
//     );
//   }
//   onGoingCall(context,{videoCallingViewModel callingViewModel,String calleeName}){
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Stack(
//         children: [
//           Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child: RTCVideoView(callingViewModel.localRenderer, mirror: true,
//               objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,),
//             ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   // width: MediaQuery.of(context).size.width,
//                   // color: Colors.pink,
//                   // alignment: Alignment.center,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//
//                         children: [
//                           SizedBox(height: size.convert(context, 50),),
//                           Container(
//                             child: Text(calleeName??"User Name",
//                             style: style.RobotoMedium(
//                               color: Colors.white,
//                               fontSize: 25
//                             ),),
//                           ),
//                           Container(
//                             child: Text("Calling...",
//                             style: style.RobotoRegular(
//                               color: Colors.white,
//                               fontSize: 14
//                             ),),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(bottom: size.convert(context, 20)),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           circularSvgIcon(
//                             iconSize: size.convert(context, 60),
//                             iconUrl: "assets/icons/call_end.svg",
//                             ontap: (){
//                               Navigator.pop(context);
//                               callingViewModel.disposeCalling();
//
//                             },
//                           )
//                         ],
//                       ),
//                       SizedBox(height: size.convert(context, 10),),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: size.convertWidth(context, 25)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             circularSvgIcon(
//                               iconSize: size.convert(context, 50),
//                               bgColor: Colors.white54,
//                               iconUrl: "assets/icons/icon_Repeat",
//                               ontap: (){
//                                 callingViewModel.disposeCalling();
//                                 Navigator.pop(context);
//                               },
//                             ),
//                             circularSvgIcon(
//                               iconSize: size.convert(context, 50),
//                               bgColor: Colors.white54,
//                               iconUrl: "assets/icons/icon_Repeat",
//                               ontap: (){
//                                 callingViewModel.disposeCalling();
//                                 Navigator.pop(context);
//                               },
//                             ),
//                             circularSvgIcon(
//                               iconSize: size.convert(context, 50),
//                               bgColor: Colors.white54,
//                               iconUrl: "assets/icons/icon_Repeat",
//                               ontap: (){
//                                 callingViewModel.disposeCalling();
//                                 Navigator.pop(context);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
//   acceptCall(context,{videoCallingViewModel callingViewModel}){
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child:  Stack(
//         children: [
//           Container(
//               width: 200,
//               height: 300,
//               child: RTCVideoView(callingViewModel.localRenderer, mirror: true)),
//           Container(
//               child: RTCVideoView(callingViewModel.remoteRenderer)),
//           GestureDetector(
//             onTap: (){
//               callingViewModel.disposeCalling();
//             },
//             child: Container(width : 30, height: 30,
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle
//               ),
//               child: Icon(Icons.cancel_outlined),),
//           )
//         ],
//       ),
//
//     );
//   }
// }
