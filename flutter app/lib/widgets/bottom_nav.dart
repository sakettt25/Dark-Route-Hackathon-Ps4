import 'package:flutter/material.dart';

class FlameBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FlameBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      padding: EdgeInsets.fromLTRB(14, 12, 14, 12 + bottomInset),
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.25),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.blueAccent.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _navItem(
              icon: Icons.home,
              label: "",
              active: currentIndex == 0,
              onTap: () => onTap(0),
            ),
          ),
          Expanded(
            child: _navItem(
              icon: Icons.camera_alt_outlined,
              label: "",
              active: currentIndex == 1,
              onTap: () => onTap(1),
            ),
          ),
          Expanded(
            child: _navItem(
              icon: Icons.list_alt_sharp,
              label: "",
              active: currentIndex == 2,
              onTap: () => onTap(2),
            ),
          ),
          Expanded(
            child: _navItem(
              icon: Icons.person_2_rounded,
              label: "",
              active: currentIndex == 3,
              onTap: () => onTap(3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF0F172A) : Colors.transparent,
          borderRadius: BorderRadius.circular(active ? 22 : 18),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
          border: active
              ? Border.all(
                  color: Colors.blueAccent.withOpacity(0.4),
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: active ? Colors.blueAccent : Colors.white70,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color:
                      active ? Colors.blueAccent : Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
