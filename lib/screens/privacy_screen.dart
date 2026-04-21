import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          "Kebijakan Pengguna",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Kebijakan Privasi & Syarat Penggunaan",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  "1. Pengumpulan Data\n"
                  "Kami mengumpulkan data profil dasar seperti nama dan foto profil (dummy) untuk mempersonalisasi pengalaman Anda di dalam aplikasi.\n\n"
                  "2. Penggunaan Aplikasi\n"
                  "Aplikasi ini merupakan purwarupa (prototype) front-end. Data film yang ditampilkan adalah data statis untuk keperluan demonstrasi.\n\n"
                  "3. Keamanan Privasi\n"
                  "Karena aplikasi ini belum terhubung ke database atau server (back-end), semua perubahan nama atau pengaturan yang Anda lakukan hanya tersimpan sementara di perangkat Anda saat aplikasi berjalan.\n\n"
                  "4. Aturan Komunitas\n"
                  "Pengguna diharapkan untuk selalu memberikan ulasan yang membangun dan tidak mengandung unsur SARA ketika fitur ulasan telah aktif nanti.",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
