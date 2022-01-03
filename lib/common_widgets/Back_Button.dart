import 'package:flutter/material.dart';
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.only(right: 10,top: 10,bottom: 10),
        decoration: BoxDecoration(
        ),
        child: Icon(Icons.arrow_back_ios,
          color: Colors.black,),
      ),
    );
  }
}
