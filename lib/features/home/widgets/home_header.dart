import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import 'balance_card.dart';
import 'quick_menu.dart';
import 'reminder_banner.dart';

/// Area hijau paling atas: sapaan, kartu saldo, menu cepat, dan banner.
class HomeHeader extends StatelessWidget {
  final String name;
  final String balance;
  final String accountNumber;

  const HomeHeader({
    super.key,
    required this.name,
    required this.balance,
    required this.accountNumber,
  });

  static const double _bannerHeight = 62;
  static const double _bannerOverlap = 12; // bagian banner di balik kartu

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;

    return Stack(
      fit: StackFit.passthrough,
      children: [
        // latar hijau melengkung
        Container(
          width: double.infinity,
          height: top + 250,
          decoration: const BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: top + 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _Greeting(name: name),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    // banner di lapisan bawah
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: _bannerHeight,
                      child: ReminderBanner(),
                    ),
                    // kartu putih di lapisan atas
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: _bannerHeight - _bannerOverlap,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            BalanceCard(
                              balance: balance,
                              accountNumber: accountNumber,
                            ),
                            const SizedBox(height: 14),
                            const QuickMenu(),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Greeting extends StatelessWidget {
  final String name;
  const _Greeting({required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Halo,',
                style: TextStyle(fontSize: 12, color: AppColors.white),
              ),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        _CircleIconButton(
          icon: Icons.emoji_events_outlined,
          onTap: () {}, // TODO: peringkat / reward
        ),
        const SizedBox(width: 8),
        _CircleIconButton(
          icon: Icons.headset_mic_outlined,
          onTap: () {}, // TODO: bantuan
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          color: AppColors.greenDeep,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.white, size: 18),
      ),
    );
  }
}