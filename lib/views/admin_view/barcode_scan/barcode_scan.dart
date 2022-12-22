import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/barcode_view_model.dart';

class BarcodeScan extends HookWidget {
   BarcodeScan({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    BarcodeVM barcodeVM = useProvider(barcodeVMProvider);
    useEffect(
          () {
            barcodeVM.initBarcode();
        Future.microtask(() async {

        });
        return () {};
      },
      const [],
    );
    return Scaffold(
      primary: false,
      backgroundColor: Colors.white,
      // key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
        child: CustomAppBar(
          centerWigets: AppBarTextStyle(
            text: "Scan Device",
          ),
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          // trailingIcon: AddButton(
          //   onClick: () {
          //     openBottomModal(
          //         child: AddRPMEncounter(
          //           patientId: patientId,
          //         ));
          //   },),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingButton(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              // height: 80,
              child: MobileScanner(
                  fit: BoxFit.cover,
                  allowDuplicates: true,
                  controller: barcodeVM.cameraController,
                  onDetect: barcodeVM.onDetect
              ),
            ),

            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      // height: (MediaQuery.of(context).size.height/2)-100,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent.withOpacity(0.5),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        children: [
                          Container(width: 20,color: Colors.transparent.withOpacity(0.5),),
                          Expanded(
                            child: Container(
                              key: barcodeVM.focusContainer,
                              // color: Colors.amber,
                            ),
                          ),
                          Container(width: 20,color: Colors.transparent.withOpacity(0.5),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      // height: (MediaQuery.of(context).size.height/2)-100,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent.withOpacity(0.5),
                      // child: Column(
                      //   children: [
                      //     ListView.separated(
                      //         shrinkWrap: true,
                      //         itemBuilder: (context,index){
                      //           return Card(
                      //             child: Text("${barcodeVM.barcodeList[index]}"),
                      //           );
                      //         },
                      //         separatorBuilder: (context,index){
                      //           return SizedBox(height: 4,);
                      //         },
                      //         itemCount: barcodeVM.barcodeList.length),
                      //   ],
                      // ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ScannerTest extends StatefulWidget {
//   const ScannerTest({Key? key}) : super(key: key);
//
//   @override
//   State<ScannerTest> createState() => _ScannerTestState();
// }

// class _ScannerTestState extends State<ScannerTest> {
//   MobileScannerController cameraController = MobileScannerController()..stop();
//   List<String> barcodeList = [];
//   GlobalKey focusContainer = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Mobile Scanner'),
//           actions: [
//             IconButton(
//               color: Colors.white,
//               icon: ValueListenableBuilder(
//                 valueListenable: cameraController.torchState,
//                 builder: (context, state, child) {
//                   switch (state as TorchState) {
//                     case TorchState.off:
//                       return const Icon(Icons.flash_off, color: Colors.grey);
//                     case TorchState.on:
//                       return const Icon(Icons.flash_on, color: Colors.yellow);
//                   }
//                 },
//               ),
//               iconSize: 32.0,
//               onPressed: () => cameraController.toggleTorch(),
//             ),
//             IconButton(
//               color: Colors.white,
//               icon: ValueListenableBuilder(
//                 valueListenable: cameraController.cameraFacingState,
//                 builder: (context, state, child) {
//                   switch (state as CameraFacing) {
//                     case CameraFacing.front:
//                       return const Icon(Icons.camera_front);
//                     case CameraFacing.back:
//                       return const Icon(Icons.camera_rear);
//                   }
//                 },
//               ),
//               iconSize: 32.0,
//               onPressed: () {
//                 cameraController.switchCamera();
//                 // cameraController.start();
//               },
//
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             Container(
//               // height: 80,
//               child: MobileScanner(
//                   fit: BoxFit.cover,
//                   allowDuplicates: true,
//                   controller: cameraController,
//                   onDetect: (barcode, args) {
//                     if (barcode.rawValue == null) {
//                       debugPrint('Failed to scan Barcode');
//                     } else {
//                       RenderBox box = focusContainer.currentContext!.findRenderObject() as RenderBox;
//                       Offset endposition = box.localToGlobal(Offset.zero);
//                       Offset startposition = box.localToGlobal(Offset(0, -(box.constraints.maxHeight)));
//                       final String code = barcode.rawValue!;
//                       int i = 0;
//                       barcode.corners?.forEach((element) {
//                         // && element.dx >=
//                         if((element.dy >= startposition.dy && element.dy <= endposition.dy) && (element.dx >= 30 && element.dx <= MediaQuery.of(context).size.width -20)){
//                           bool isExists = barcodeList.any((element1) => element1 == barcode.rawValue);
//                           i++;
//                           print("$i $code");
//                           if(!isExists && i ==4) {
//                             barcodeList.add(code);
//                             setState(() {});
//                           }
//                           debugPrint('Barcode found! $code');
//                         }
//                       });
//
//                     }
//                   }),
//             ),
//
//             // Container(
//             //   child: ListView.separated(
//             //     shrinkWrap: true,
//             //       physics: ScrollPhysics(),
//             //       itemBuilder: (context,index){
//             //         return Container(child: Text("${barcodeList[index]}"),);
//             //       },
//             //     separatorBuilder: (context,index){
//             //       return Container(height: 5,);
//             //     },
//             //     itemCount: barcodeList.length,
//             //
//             //   ),
//             // )
//
//             Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: (MediaQuery.of(context).size.height/2)-100,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.transparent.withOpacity(0.5),
//                   ),
//                   Expanded(
//                     child: Container(
//                       child: Row(
//                         children: [
//                           Container(width: 20,color: Colors.transparent.withOpacity(0.5),),
//                           Expanded(
//                             child: Container(
//                               key: focusContainer,
//                               // color: Colors.amber,
//                             ),
//                           ),
//                           Container(width: 20,color: Colors.transparent.withOpacity(0.5),),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: (MediaQuery.of(context).size.height/2)-100,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.transparent.withOpacity(0.5),
//                     child: Column(
//                       children: [
//                         ListView.separated(
//                             shrinkWrap: true,
//                             itemBuilder: (context,index){
//                               return Card(
//                                 child: Text("${barcodeList[index]}"),
//                               );
//                             },
//                             separatorBuilder: (context,index){
//                               return SizedBox(height: 4,);
//                             },
//                             itemCount: barcodeList.length),
//                         TextButton(
//                             onPressed: cameraController.start,
//                             child: Text("Scan")
//                         )
//                       ],
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//           ],
//         )
//     );
//   }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: const Text('Mobile Scanner')),
//     body: MobileScanner(
//         allowDuplicates: false,
//         controller: MobileScannerController(
//           ratio: Ratio.ratio_4_3,
//             facing: CameraFacing.back, torchEnabled: false),
//         onDetect: (barcode, args) {
//           if (barcode.rawValue == null) {
//             debugPrint('Failed to scan Barcode');
//           } else {
//             final String code = barcode.rawValue!;
//             debugPrint('Barcode found! $code');
//           }
//         }),
//   );
// }
// }