import 'package:permission_handler/permission_handler.dart';

class CameraService {
  static Future<bool> requestPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
}
