import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class BalanceCard extends StatefulWidget {
  final String balance;
  final String accountNumber;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.accountNumber,
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.greenDeep,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saldo Tabungan',
            style: TextStyle(fontSize: 13, color: AppColors.white),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                _visible ? widget.balance : 'Rp ••••••••',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() => _visible = !_visible),
                child: Icon(
                  _visible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1.2, color: AppColors.green),
          const SizedBox(height: 10),
          Text(
            'No. rek ${widget.accountNumber}',
            style: const TextStyle(fontSize: 13, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}