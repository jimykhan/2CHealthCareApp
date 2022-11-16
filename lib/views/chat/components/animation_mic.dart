// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class WhatsAppMicAnimation extends StatefulWidget {
//   @override
//   _WhatsAppMicAnimationState createState() => _WhatsAppMicAnimationState();
// }
//
// class _WhatsAppMicAnimationState extends State<WhatsAppMicAnimation>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _animationController;
//
//   //Mic
//   Animation<double>? _micTranslateTop;
//   Animation<double>? _micRotationFirst;
//   Animation<double>? _micTranslateRight;
//   Animation<double>? _micTranslateLeft;
//   Animation<double>? _micRotationSecond;
//   Animation<double>? _micTranslateDown;
//   Animation<double>? _micInsideTrashTranslateDown;
//
//
//   //Trash Can
//   Animation<double>? _trashWithCoverTranslateTop;
//   Animation<double>? _trashCoverRotationFirst;
//   Animation<double>? _trashCoverTranslateLeft;
//   Animation<double>? _trashCoverRotationSecond;
//   Animation<double>? _trashCoverTranslateRight;
//   Animation<double>? _trashWithCoverTranslateDown;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 2500),
//     );
//
//     //Mic
//
//     _micTranslateTop = Tween(begin: 0.0, end: -50.0).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.0, 0.45, curve: Curves.easeOut),
//       ),
//     );
//
//     _micRotationFirst = Tween(begin: 0.0, end: pi).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.0, 0.2),
//       ),
//     );
//
//     _micTranslateRight = Tween(begin: 0.0, end: 13.0).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.0, 0.1),
//       ),
//     );
//
//     _micTranslateLeft = Tween(begin: 0.0, end: -13.0).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.1, 0.2),
//       ),
//     );
//
//     _micRotationSecond = Tween(begin: 0.0, end: pi).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.2, 0.45),
//       ),
//     );
//
//     _micTranslateDown = Tween(begin: 0.0, end: 50.0).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.45, 0.79, curve: Curves.easeInOut),
//       ),
//     );
//
//     _micInsideTrashTranslateDown = Tween(begin: 0.0, end: 55.0).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.95, 1.0, curve: Curves.easeInOut),
//       ),
//     );
//
//     //Trash Can
//
//     _trashWithCoverTranslateTop = Tween(begin: 30.0, end: -25.0).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.45, 0.6),
//       ),
//     );
//
//     _trashCoverRotationFirst = Tween(begin: 0.0, end: -pi / 3).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.6, 0.7),
//       ),
//     );
//
//     _trashCoverTranslateLeft = Tween(begin: 0.0, end: -18.0).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.6, 0.7),
//       ),
//     );
//
//     _trashCoverRotationSecond = Tween(begin: 0.0, end: pi / 3).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.8, 0.9),
//       ),
//     );
//
//     _trashCoverTranslateRight = Tween(begin: 0.0, end: 18.0).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.8, 0.9),
//       ),
//     );
//
//     _trashWithCoverTranslateDown = Tween(begin: 0.0, end: 55.0).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Interval(0.95, 1.0, curve: Curves.easeInOut),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController?.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         _buildMicAnimation(),
//         _buildButtons(),
//       ],
//     );
//   }
//
//   Widget _buildMicAnimation() {
//     return Stack(
//       // mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         AnimatedBuilder(
//           animation: _animationController!,
//           builder: (context, child) {
//             return Transform(
//               transform: Matrix4.identity()
//                 ..translate(0.0, 10)
//                 ..translate(_micTranslateRight!.value)
//                 ..translate(_micTranslateLeft!.value)
//                 ..translate(0.0, _micTranslateTop!.value)
//                 ..translate(0.0, _micTranslateDown!.value)
//                 ..translate(0.0, _micInsideTrashTranslateDown!.value),
//               child: Transform.rotate(
//                 angle: _micRotationFirst!.value,
//                 child: Transform.rotate(
//                   angle: _micRotationSecond!.value,
//                   child: child,
//                 ),
//               ),
//             );
//           },
//           child: Icon(
//             Icons.mic,
//             color: Color(0xFFef5552),
//             size: 30,
//           ),
//         ),
//         AnimatedBuilder(
//             animation: _trashWithCoverTranslateTop!,
//             builder: (context, child) {
//               return Transform(
//                 transform: Matrix4.identity()
//                   ..translate(0.0, _trashWithCoverTranslateTop?.value??0)
//                   ..translate(0.0, _trashWithCoverTranslateDown?.value??0),
//                 child: child,
//               );
//             },
//             child: Column(
//               children: [
//                 AnimatedBuilder(
//                   animation: _trashCoverRotationFirst!,
//                   builder: (context, child) {
//                     return Transform(
//                       transform: Matrix4.identity()
//                         ..translate(_trashCoverTranslateLeft?.value??0)
//                         ..translate(_trashCoverTranslateRight?.value??0),
//                       child: Transform.rotate(
//                         angle: _trashCoverRotationSecond?.value??0,
//                         child: Transform.rotate(
//                           angle: _trashCoverRotationFirst?.value??0,
//                           child: child,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Image(
//                     image: AssetImage('assets/trash_cover.png'),
//                     width: 30,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 1.5),
//                   child: Image(
//                     image: AssetImage('assets/trash_container.png'),
//                     width: 30,
//                   ),
//                 ),
//               ],
//             )),
//       ],
//     );
//   }
//
//   Widget _buildButtons() {
//     return Align(
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           RaisedButton(
//             child: Text('Play'),
//             onPressed: () {
//               _animationController?.forward();
//             },
//           ),
//           RaisedButton(
//             child: Text('Reset'),
//             onPressed: () {
//               _animationController?.reset();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
// }