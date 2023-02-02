import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService{
  ProviderReference? _ref;

  PermissionService({ProviderReference? ref}){
    _ref = ref;
  }

  Future<bool> locationPermissionRequest()async{
    PermissionStatus  permissionStatus = await Permission.location.request();
    return permissionStatus.isGranted;
  }

  Future<bool> bluetoothPermissionRequest()async{
    PermissionStatus  permissionStatus = await Permission.bluetooth.request();

    return permissionStatus.isGranted;
  }

   turnOnBlue()async{
    try{
      await FlutterBluePlus.instance.turnOn();
      // int i = (1/0) as int;
    }catch(ex){
        print("error");
    }
  }
}