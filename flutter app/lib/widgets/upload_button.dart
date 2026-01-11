import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final VoidCallback onTap;

  const UploadButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.5),
              blurRadius: 20,
            )
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          "UPLOAD PHOTO / VIDEO",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
