import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';

class AnimatedBar extends StatefulWidget {
  double startPoint;
  double endPoint;
  AnimatedBar({required this.startPoint,required this.endPoint,Key? key}) : super(key: key);

  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 1))..repeat(reverse: true);
    
    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  AlignTransition(
      alignment: _alignAnimation,
      child: Container(
          decoration: BoxDecoration(
            color: errorColor
          ),
          height: 1,
          width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
