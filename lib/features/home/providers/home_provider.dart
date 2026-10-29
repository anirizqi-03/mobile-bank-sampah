import 'package:flutter/material.dart';
import '../models/home_model.dart';

class HomeProvider with ChangeNotifier {
  // Simulasi data dari database
  HomeData? _homeData;

  HomeData? get homeData => _homeData;

  // Fungsi ini nanti dipanggil saat halaman Home dibuka (initState)
  Future<void> fetchHomeData() async {
    
    await Future.delayed(const Duration(seconds: 1));

    _homeData = HomeData(
      userName: "ERIX AGUNG WIBOWO",
      balance: "Rp 800.000,00",
      accountNumber: "8800 8181 8008",
      transactions: [
        TransactionModel(id: '1', title: "Setoran Sampah Plastik", subtitle: "Selasa - 12/05/2024", amount: "+Rp 12.000", date: "12 Mei"),
        TransactionModel(id: '2', title: "Setoran Sampah Kertas", subtitle: "Senin - 11/05/2024", amount: "+Rp 8.000", date: "11 Mei"),
        TransactionModel(id: '3', title: "Setoran Sampah Plastik", subtitle: "Minggu - 10/05/2024", amount: "+Rp 15.000", date: "10 Mei"),
      ],
    );
    notifyListeners();
  }
}