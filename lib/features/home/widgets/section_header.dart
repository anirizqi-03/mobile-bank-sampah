import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

/// Judul bagian + teks hijau "semua" di kanan.
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool bold;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.onTap,
    this.bold = true,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: bold ? 15 : 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              color: AppColors.textDark,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Text(
              'semua',
              style: TextStyle(fontSize: 13, color: AppColors.green),
            ),
          ),
        ],
      ),
    );
  }
}