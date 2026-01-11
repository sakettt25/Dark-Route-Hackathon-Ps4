import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:why/widgets/neo_core.dart';
import 'package:why/widgets/upload_button.dart';
import 'package:why/services/ml_api.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String? analysis;
  bool loading = false;

  Future<void> pickAndAnalyze() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    setState(() {
      loading = true;
      analysis = null;
    });

    final result = await MlApi.analyzeCattle(File(file.path));

    setState(() {
      analysis = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const NeoCore(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Farm Dashboard",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              const _StatCard("Total Animals", "128"),
              const _StatCard("Healthy", "121"),
              const _StatCard("Needs Attention", "7"),

              const SizedBox(height: 24),

              UploadButton(onTap: pickAndAnalyze),

              const SizedBox(height: 20),

              if (loading)
                const Center(child: CircularProgressIndicator()),

              if (analysis != null)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.blueAccent.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    analysis!,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text(value,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
