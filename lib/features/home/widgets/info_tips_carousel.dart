import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../models/info_tip.dart';

class InfoTipsCarousel extends StatelessWidget {
  final List<InfoTip> tips;
  const InfoTipsCarousel({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 133, // 117 kartu + ruang untuk bayangan
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        itemCount: tips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _InfoTipCard(tip: tips[i]),
      ),
    );
  }
}

class _InfoTipCard extends StatelessWidget {
  final InfoTip tip;
  const _InfoTipCard({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          tip.imageAsset,
          fit: BoxFit.cover,
          // placeholder bila gambar belum ditambahkan ke assets
          errorBuilder: (_, __, ___) => Container(
            color: tip.placeholderColor,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Text(
              tip.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.greenDark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}