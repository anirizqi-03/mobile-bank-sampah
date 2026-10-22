import 'package:flutter/material.dart';

class InfoTip {
  final String title;

  /// Path gambar banner, mis. 'assets/images/tip_memilah.png'.
  /// Kalau file belum ada, kartu menampilkan placeholder berwarna.
  final String imageAsset;
  final Color placeholderColor;

  const InfoTip({
    required this.title,
    required this.imageAsset,
    required this.placeholderColor,
  });
}