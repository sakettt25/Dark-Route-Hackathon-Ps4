import 'package:flutter/material.dart';

class AnimalListView extends StatelessWidget {
  const AnimalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 80, 16, 100),
      itemCount: 6,
      itemBuilder: (_, i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blueAccent.withOpacity(0.15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "COW-0${i + 21}",
                style: const TextStyle(color: Colors.white),
              ),
              const Text(
                "Healthy",
                style: TextStyle(color: Colors.greenAccent),
              ),
            ],
          ),
        );
      },
    );
  }
}
