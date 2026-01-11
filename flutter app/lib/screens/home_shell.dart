import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import './dashboard/dashboard_view.dart';
import './scan/scan_view.dart';
import './animals/animal_list_view.dart';
import './profile/profile_view.dart';

class HomeShell extends StatefulWidget {
  final String rollNo;
  const HomeShell({super.key, required this.rollNo});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  final pages = const [
    DashboardView(),
    ScanView(),
    AnimalListView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: FlameBottomNav(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}
