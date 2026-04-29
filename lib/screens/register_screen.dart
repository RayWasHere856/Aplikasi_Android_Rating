// Kode ini digunakan untuk mengimpor library Flutter dan halaman-halaman lain yang saling terhubung
import 'package:flutter/material.dart';
import 'main_wrapper.dart';
import 'login_screen.dart';
import '../widgets/gradient_background.dart';

// Kode ini digunakan untuk membuat kerangka halaman RegisterScreen yang bersifat dinamis (StatefulWidget)
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Kode ini digunakan untuk menyimpan teks yang diketik pengguna pada kolom Nama Awal
  final TextEditingController _firstNameController = TextEditingController();
  
  // Kode ini digunakan untuk menyimpan teks masukan pada kolom Nama Akhir
  final TextEditingController _lastNameController = TextEditingController();
  
  // Kode ini digunakan untuk menangkap inputan alamat email pengguna
  final TextEditingController _emailController = TextEditingController();
  
  // Kode ini digunakan untuk menangkap kata sandi yang diketikkan pengguna
  final TextEditingController _passwordController = TextEditingController();

  // Kode ini digunakan untuk membersihkan memory controller ketika halaman ditutup untuk mencegah kebocoran memory (memory leak)
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Kode ini digunakan untuk membuat struktur dasar halaman pendaftaran tanpa latar belakang bawaan
    return Scaffold(
      backgroundColor: Colors.transparent,

      // Kode ini digunakan untuk menerapkan warna gradasi khusus di seluruh layar belakang
      body: GradientBackground(
        // Kode ini digunakan untuk memastikan elemen di dalam aplikasi tidak tertutup oleh poni layar (notch) atau status bar HP
        child: SafeArea(
          // Kode ini digunakan untuk memposisikan seluruh area form pendaftaran tepat di tengah layar
          child: Center(
            // Kode ini digunakan untuk membungkus form agar bisa di-scroll ketika keyboard muncul menutupi layar
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25.0),
              // Kode ini digunakan untuk menyusun elemen-elemen teks dan form secara vertikal (dari atas ke bawah)
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // Kode ini digunakan agar elemen di dalam kolom melebar memenuhi ruang layar dari kiri ke kanan
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Kode ini digunakan untuk menampilkan teks judul utama halaman pendaftaran
                  const Text(
                    "Buat Akun Baru",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Kode ini digunakan untuk memberikan jarak kosong antara judul dan sub-judul
                  const SizedBox(height: 10),
                  
                  // Kode ini digunakan untuk menampilkan teks instruksi tambahan dengan warna agak pudar (white70)
                  const Text(
                    "Daftar untuk mulai merating film",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 40),

                  // Kode ini digunakan untuk membuat kolom input tempat pengguna mengetikkan Nama Awal
                  TextField(
                    controller: _firstNameController,
                    style: const TextStyle(color: Colors.white),
                    // Kode ini digunakan untuk mengatur tampilan dalam kolom seperti teks petunjuk (label), ikon, dan garis batas (border)
                    decoration: InputDecoration(
                      labelText: "Nama Awal",
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(
                        Icons.person,
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

                  // Kode ini digunakan untuk membuat kolom input opsional untuk mengetikkan Nama Akhir
                  TextField(
                    controller: _lastNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Nama Akhir (Optional)",
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(
                        Icons.person_outline,
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

                  // Kode ini digunakan untuk membuat kolom input berformat email yang akan memunculkan keyboard khusus email (ada tombol @)
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

                  // Kode ini digunakan untuk membuat kolom password yang menyembunyikan karakternya menjadi titik-titik (obscureText: true)
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

                  // Kode ini digunakan untuk membungkus tombol agar memiliki ketinggian tetap (50 pixel)
                  SizedBox(
                    height: 50,
                    // Kode ini digunakan untuk membuat tombol pendaftaran berwarna biru
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // Kode ini digunakan untuk menjalankan aksi (logika) tertentu saat tombol 'Daftar' ditekan
                      onPressed: () {
                        // Kode ini digunakan untuk menyimpan nilai "User" sebagai nama bawaan jika kolom Nama Awal dibiarkan kosong
                        String namaUser = "User";
                        if (_firstNameController.text.isNotEmpty) {
                          namaUser = _firstNameController.text;
                        }

                        // Kode ini digunakan untuk mengarahkan pengguna ke halaman MainWrapper (beranda) sekaligus mengirim data namaUser, dan menghapus layar ini dari riwayat navigasi
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MainWrapper(userName: namaUser),
                          ),
                        );
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Kode ini digunakan untuk menyusun teks pertanyaan dan tombol login berdampingan secara menyamping (horizontal)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sudah punya akun?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      // Kode ini digunakan untuk membuat tombol teks transparan yang bisa ditekan
                      TextButton(
                        // Kode ini digunakan untuk memindahkan pengguna kembali ke halaman LoginScreen jika mereka sudah memiliki akun
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login sekarang",
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