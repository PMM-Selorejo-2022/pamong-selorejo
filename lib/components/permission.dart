import 'package:permission_handler/permission_handler.dart';

class PermissionRequest {
  Future<bool> permissionCamera() async {
    var permission = await Permission.camera.request();
    if (permission.isDenied || permission.isPermanentlyDenied) {
      return false;
    } else {
      return true;
    }
  }
}
