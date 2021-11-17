import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class loader extends StatefulWidget {
  double? radius;
  loader({this.radius});
  @override
  _loaderState createState() => _loaderState();
}

class _loaderState extends State<loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CupertinoActivityIndicator(
          radius: ApplicationSizing.convert(widget.radius??10),

        ),
      ),
    );
  }
}
