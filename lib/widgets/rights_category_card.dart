
import 'package:flutter/material.dart';

// Reusable category button for the Dashboard.
// The parent screen decides what happens when tapped.
class RightsCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  const RightsCategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),

      // InkWell makes the whole card clickable.
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 125,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 23),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11),
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_outward,
                  size: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
