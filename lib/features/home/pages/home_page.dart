import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../providers/home_provider.dart';
import '../widgets/home_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_menu.dart';
// import '../widgets/info_tips_section.dart'; 
// import '../widgets/transaction_history_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    if (homeProvider.homeData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final data = homeProvider.homeData!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0, left: 0, right: 0,
              height: 220,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.green,
                ),
              ),
            ),
            
            // ═══ KONTEN ═══
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  bottom: false,
                  child: HomeHeader(userName: data.userName),
                ),
                
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 40,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BalanceCard(
                              balance: data.balance,
                              accountNumber: data.accountNumber,
                            ),
                            const SizedBox(height: 18),
                            const QuickMenu(), 
                          ],
                        ),
                      ),

                      Positioned(
                        bottom: -40, left: 12, right: 12,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.greenSurface, 
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info, color: AppColors.green),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  "Pantau Data Alamat & Kontak Anda. Pastikan informasi sudah benar.",
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                              const Text(
                                "Edit Data >",
                                style: TextStyle(fontSize: 10, color: AppColors.green, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 70), 

                
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Informasi & Tips:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                ),
                // const InfoTipsSection(),

                const SizedBox(height: 24),

                // 4. RIWAYAT TRANSAKSI
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Riwayat Transaksi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                ),
                const SizedBox(height: 12),
                
                
                ...data.transactions.map((trx) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Color(0xFFBDBDBD)),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.greenSurface,
                        child: Icon(Icons.recycling, color: AppColors.green),
                      ),
                      title: Text(trx.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      subtitle: Text(trx.subtitle, style: const TextStyle(fontSize: 11)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(trx.amount, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.green)),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right, size: 18),
                        ],
                      ),
                    ),
                  );
                }),
                
                const SizedBox(height: 120),
              ],
            ),
          ],
        ),
      ),
    );
  }
}