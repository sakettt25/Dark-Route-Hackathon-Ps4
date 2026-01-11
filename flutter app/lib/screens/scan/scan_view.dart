import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:why/main.dart';
import 'package:why/services/camera_service.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  CameraController? controller;
  XFile? captured;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    final granted = await CameraService.requestPermission();
    if (!granted) return;

    controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller!.initialize();
    setState(() => loading = false);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> capture() async {
    if (!controller!.value.isInitialized) return;
    final file = await controller!.takePicture();
    setState(() => captured = file);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: Stack(
        children: [
          /// CAMERA PREVIEW
          if (captured == null)
            CameraPreview(controller!)
          else
            Image.file(
              File(captured!.path),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

          /// TOP TEXT
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                captured == null
                    ? "Align animal in frame"
                    : "Captured Image",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          /// CAPTURE BUTTON
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: captured == null ? capture : () {
                  setState(() => captured = null);
                },
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.6),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Icon(
                    captured == null ? Icons.camera_alt : Icons.refresh,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
