import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';

class GifIconUrl extends StatefulWidget {
  String url;
   GifIconUrl({Key? key,required this.url}) : super(key: key);

  @override
  State<GifIconUrl> createState() => _GifIconUrlState();
}

class _GifIconUrlState  extends State<GifIconUrl> with SingleTickerProviderStateMixin{
  late FlutterGifController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = FlutterGifController(vsync: this);
    controller.repeat(min:0, max:5, period: Duration(milliseconds:300),reverse: true);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: GifImage(
        controller: controller,
        image: AssetImage(widget.url),
      ),
    );
  }
}
