// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../core/app_colors.dart';
// import 'models/info_tip.dart';
// import 'models/transaction.dart';
// import 'widgets/home_header.dart';
// import 'widgets/info_tips_carousel.dart';
// import 'widgets/section_header.dart';
// import 'widgets/transaction_section.dart';

// class HomeTab extends StatelessWidget {
//   const HomeTab({super.key});

//   // Data dummy. Ganti dengan data dari API nanti.
//   static const _tips = [
//     InfoTip(
//       title: 'Cara Memilah Sampah',
//       imageAsset: 'assets/images/tip_memilah.png',
//       placeholderColor: Color(0xFFCDEBFA),
//     ),
//     InfoTip(
//       title: 'Bahaya Sampah B3',
//       imageAsset: 'assets/images/tip_b3.png',
//       placeholderColor: Color(0xFFF3EFDD),
//     ),
//   ];

//   static const _transactions = [
//     Transaction(title: 'Setor Sampah Plastik', amount: 12000),
//     Transaction(title: 'Setor Sampah Kertas', amount: 6000),
//     Transaction(title: 'Setor Sampah Plastik', amount: 12000),
//     Transaction(title: 'Setor Sampah Kertas', amount: 6000),
//     Transaction(title: 'Setor Sampah Plastik', amount: 12000),
//     Transaction(title: 'Setor Sampah Kertas', amount: 6000),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       // ikon status bar putih di atas latar hijau
//       value: SystemUiOverlayStyle.light,
//       child: ColoredBox(
//         color: AppColors.white,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const HomeHeader(
//                 name: 'ERIX AGUNG WIBOWO',
//                 balance: 'Rp800.000,00',
//                 accountNumber: '8800 8181 8008',
//               ),
//               const SizedBox(height: 28),
//               SectionHeader(
//                 title: 'Informasi & Tips:',
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 onTap: () {}, // TODO
//               ),
//               const SizedBox(height: 4),
//               const InfoTipsCarousel(tips: _tips),
//               const SizedBox(height: 16),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24),
//                 child: TransactionSection(transactions: _transactions),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }