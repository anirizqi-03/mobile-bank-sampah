import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_routes.dart';
import '../../../../core/app_colors.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _nikController = TextEditingController();
  final _waController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  // 1. Tambahkan variabel untuk menyimpan value dropdown
  String? _selectedAnggotaKeluarga;

  @override
  void dispose() {
    _nameController.dispose();
    _nikController.dispose();
    _waController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.green,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (authProvider.errorMessage != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              authProvider.errorMessage!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 137, 129),
                                fontSize: 12,
                              ),
                            ),
                          ),

                        CustomTextField(
                          controller: _nameController,
                          hintText: "Nama Lengkap",
                          icon: Icons.person_outline,
                          validator: (value) =>
                              value!.isEmpty ? "Nama tidak boleh kosong" : null,
                        ),
                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _nikController,
                          hintText: "NIK",
                          icon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value!.isEmpty ? "NIK tidak boleh kosong" : null,
                        ),
                        const SizedBox(height: 16),

                        // --- BARIS WHATSAPP & ANGGOTA KELUARGA ---
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5, // Sedikit dilebarkan agar text WA tidak terpotong
                              child: CustomTextField(
                                controller: _waController,
                                hintText: "WhatsApp",
                                icon: Icons.phone_outlined,
                                keyboardType: TextInputType.phone,
                                validator: (value) =>
                                    value!.isEmpty ? "Wajib diisi" : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 4, // Proporsi disesuaikan dengan gambar
                              child: CustomDropdown(
                                hintText: "Anggota Keluarga",
                                icon: Icons
                                    .group_outlined, // Tambahkan ikon orang
                                value: _selectedAnggotaKeluarga,
                                items: const [
                                  "1 Orang",
                                  "2 Orang",
                                  "3 Orang",
                                  "4 Orang",
                                  "> 4 Orang",
                                ],
                                onChanged: (newValue) {
                                  // 2. Simpan pilihan ke state
                                  setState(() {
                                    _selectedAnggotaKeluarga = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Email harus diisi!";
                            if (!value.contains('@'))
                              return "Format email salah";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _addressController,
                          hintText: "Alamat",
                          icon: Icons.location_on_outlined,
                          validator: (value) => value!.isEmpty
                              ? "Alamat tidak boleh kosong"
                              : null,
                        ),
                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          icon: Icons.lock_outline,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Password kosong";
                            if (value.length < 6) return "Minimal 6 karakter";
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        // --- TOMBOL DAFTAR ---
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      // 3. (Opsional) Validasi apakah dropdown sudah dipilih
                                      if (_selectedAnggotaKeluarga == null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Pilih jumlah anggota keluarga!",
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      final success = await authProvider
                                          .register(
                                            name: _nameController.text,
                                            nik: _nikController.text,
                                            wa: _waController.text,
                                            email: _emailController.text,
                                            address: _addressController.text,
                                            password: _passwordController.text,
                                            anggotaKeluarga:
                                                _selectedAnggotaKeluarga!,
                                          );

                                      if (success && mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Registrasi Berhasil! Silahkan Login",
                                                ),
                                              ),
                                            );
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRoutes.login,
                                        );
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: authProvider.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Daftar",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Sudah memiliki akun? ",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pop(context);
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
