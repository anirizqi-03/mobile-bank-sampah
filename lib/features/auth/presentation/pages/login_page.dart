import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_routes.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ambil state dari Provider
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.white, // Background dasar putih
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- BAGIAN ATAS (HIJAU) ---
            Container(
              width: double.infinity,
              height: 280,
              decoration: const BoxDecoration(
                color: AppColors.green,
                // Jika ada gambar logo daur ulang di background, gunakan kode di bawah:
                image: DecorationImage(
                  image: AssetImage('assets/images/environment.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  opacity: 0.2,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 20),
                      Text(
                        "Hello!",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Welcome Back!",
                        style: TextStyle(fontSize: 24, color: AppColors.white),
                      ),
                      SizedBox(height: 5),

                      Text(
                        "Mulai Ubah Sampah Jadi Rupiah",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- BAGIAN BAWAH (CARD PUTIH MELENGKUNG) ---
            Transform.translate(
              offset: const Offset(
                0,
                -40,
              ), // Tarik ke atas agar menumpuk background hijau
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul Login & Ikon Kecil
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.green,
                              ),
                            ),
                            // Ikon tunas/daun kecil di kanan
                            Icon(Icons.eco, color: AppColors.green, size: 30),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Tampilkan pesan error jika dari provider ada error
                        if (authProvider.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              authProvider.errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                              ),
                            ),
                          ),

                        // Input Email
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Email wajib diisi";
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Input Password
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          icon: Icons.lock_outline,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Password wajib diisi";
                            return null;
                          },
                        ),

                        // Lupa Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Lupa Password?",
                              style: TextStyle(
                                color: AppColors.green,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Tombol Login
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading
                                ? null // Matikan tombol saat loading
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      // Panggil fungsi login dari Provider
                                      final success = await authProvider.login(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );

                                      // Jika sukses, pindah ke halaman Home (Simulasi)
                                      if (success && mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text("Login Berhasil!"),
                                            backgroundColor: AppColors.green,
                                          ),
                                        );
                                        Navigator.pushReplacementNamed(context, AppRoutes.home); 
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
                                      color: AppColors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Teks Daftar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Belum memiliki akun? ",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.muted,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigasi ke halaman Register
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.register,
                                );
                              },
                              child: const Text(
                                "Daftar",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
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
