class HomeData {
  final String userName;
  final String balance;
  final String accountNumber;
  final List<TransactionModel> transactions;

  HomeData({
    required this.userName,
    required this.balance,
    required this.accountNumber,
    required this.transactions,
  });
}

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final String amount;
  final String date;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
  });
}
