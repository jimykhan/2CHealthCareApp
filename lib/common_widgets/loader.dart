import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class loader extends StatefulWidget {
  double? radius;
  double? width;
  Color? color;
  loader({this.radius,this.width,this.color});
  @override
  _loaderState createState() => _loaderState();
}

class _loaderState extends State<loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,

      child: Center(
        child: CupertinoActivityIndicator(
          radius: ApplicationSizing.convert(widget.radius??10),
          color: widget.color,
        ),
      ),
    );
  }
}
