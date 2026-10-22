class Transaction {
  final String title;
  final int amount;

  const Transaction({required this.title, required this.amount});

  /// Contoh: "Saldo +Rp12.000"
  String get amountLabel {
    final formatted = amount
        .toString()
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.');
    return 'Saldo +Rp$formatted';
  }
}