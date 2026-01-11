import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize cameras
  cameras = await availableCameras();

  // Initialize Supabase
  await Supabase.initialize(
    url: "https://bcdpsdtezivpvligebyq.supabase.co",
    anonKey: "sb_publishable_3ECTJzrYubXJCnN_i3gjDw_K2AXkESd",
  );

  runApp(const RecgrootApp());
}

class RecgrootApp extends StatelessWidget {
  const RecgrootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'recgroot',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
