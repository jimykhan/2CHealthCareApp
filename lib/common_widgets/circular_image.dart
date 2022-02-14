import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_colors.dart';

class CircularImage extends StatelessWidget {
  String? imageUrl;
  double? h;
  double? w;
  bool assetImage;
  bool fileImage;
  File? file;
  Color? color;
  Function()? ontap;

  CircularImage(
      {this.file,
      this.imageUrl,
      this.fileImage = false,
      this.h,
      this.w,
      this.assetImage = true,
      this.color,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: h ?? 24,
        width: w ?? 24 ,
        decoration: BoxDecoration(
            color: color ?? appColor,
            shape: BoxShape.circle,
            image: imageUrl == null
                ? null
                : DecorationImage(
                    image: checkImageType() ?? AssetImage(imageUrl??""),
                    fit: BoxFit.cover)),
      ),
    );
  }
  ImageProvider? checkImageType(){
    if(fileImage){
      return FileImage(file!);
    }
    else if(assetImage){
      return AssetImage(imageUrl ?? "assets/icons/personIcon.png");
    }
    else{
      return NetworkImage(imageUrl ?? "");
    }
  }
}

// class circularCenterImage extends StatelessWidget {
//   String imageUrl;
//   double h;
//   double w;
//   bool assetImage;
//   bool fileImage;
//   File file;
//   Color color;
//
//   circularCenterImage(
//       {this.file,
//       this.imageUrl,
//       this.fileImage,
//       this.h,
//       this.w,
//       this.assetImage = false,
//       this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(
//         size.convert(context, 12),
//       ),
//       // height: h == null ? 24 : h,
//       // width: w == null ? 24 : w,
//       decoration: BoxDecoration(
//         // border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.grey.shade200,
//       ),
//       child: imageUrl == null
//           ? Container()
//           : fileImage ?? false
//               ? FileImage(file)
//               : assetImage
//                   ? Image.asset(
//                       imageUrl,
//                       width: size.convert(context, h ?? 5),
//                       height: size.convert(context, w ?? 5),
//                     )
//                   : NetworkImage(imageUrl),
//     );
//   }
// }
