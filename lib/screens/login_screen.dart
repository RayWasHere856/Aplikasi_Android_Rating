import 'package:flutter/material.dart';
import 'main_wrapper.dart';
import 'register_screen.dart';
import '../widgets/gradient_background.dart';

// Kode ini digunakan untuk membuat kerangka halaman LoginScreen yang sifatnya dinamis (StatefulWidget)
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Kode ini digunakan untuk membuat controller yang akan menangkap teks inputan pada kolom Email dan Password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Kode ini digunakan untuk membersihkan memory controller ketika halaman ditutup untuk mencegah memory leak
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            // Kode ini digunakan untuk membungkus form agar bisa di-scroll ketika keyboard muncul menutupi layar
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Selamat Datang",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Silakan login untuk melanjutkan",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 40),

                  // Kode ini digunakan untuk membuat input form tempat user mengetikkan Email
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white70,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Kode ini digunakan untuk membuat input form Password dengan karakter tersembunyi (obscureText: true)
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Kode ini digunakan untuk membuat tombol eksekusi Login
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      //penambahan kode async dan exception
                      onPressed: () async {
                        // 2. Buka blok Try untuk memantau potensi error inputan
                        try {
                          if (_emailController.text.trim().isEmpty) {
                            throw Exception("Email tidak boleh kosong!");
                          }
                          if (!_emailController.text.contains("@")) {
                            throw const FormatException(
                              "Format email salah! Harus menggunakan karakter '@'.",
                            );
                          }
                          if (_passwordController.text.trim().isEmpty) {
                            throw Exception("Password tidak boleh kosong!");
                          }
                          // Tampilkan kotak loading berputar untuk memblokir layar sementara
                          showDialog(
                            context: context,
                            barrierDismissible:
                                false, // Tidak bisa ditutup dengan asal klik layar
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blueAccent,
                              ),
                            ),
                          );

                          // Paksa sistem menunggu 2 detik (Simulasi cek database server)
                          await Future.delayed(const Duration(seconds: 2));

                          // Tutup kotak loading
                          Navigator.pop(context);

                          // Ekstrak teks sebelum tanda '@' untuk dijadikan nama pengguna
                          String namaUser = _emailController.text.split('@')[0];

                          // Pindah ke halaman Beranda secara permanen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MainWrapper(userName: namaUser),
                            ),
                          );
                        } catch (e) {
                          // Jika validasi di Fase 1 gagal, sistem akan melompat ke sini

                          String errorMessage = "Terjadi kesalahan saat login.";
                          if (e is FormatException) {
                            errorMessage = e.message;
                          } else if (e is Exception) {
                            errorMessage = e.toString().replaceAll(
                              "Exception: ",
                              "",
                            );
                          }

                          // Tampilkan pesan error berwarna merah di layar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                errorMessage,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.redAccent,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Kode ini digunakan untuk menyusun teks dan tombol "Daftar di sini" secara horizontal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum punya akun?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          // Kode ini digunakan untuk berpindah ke halaman RegisterScreen ketika diklik
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Daftar di sini",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
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
    );
  }
}
