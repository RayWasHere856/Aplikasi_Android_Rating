// Kode ini digunakan untuk mengimpor library Flutter bawaan dan juga file-file lain yang saling terhubung di dalam aplikasi
import 'package:flutter/material.dart';
import 'package:rating_app/widgets/gradient_background.dart'; 
import 'dart:async';
import 'onboarding_screen.dart';

// Kode ini digunakan untuk membuat kerangka halaman awal (SplashScreen) yang bersifat dinamis agar bisa menjalankan penghitung waktu (timer)
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Kode ini digunakan untuk menjalankan fungsi tertentu secara otomatis tepat saat halaman ini pertama kali dibuka
  @override
  void initState() {
    super.initState();
    
    // Kode ini digunakan untuk membuat penghitung waktu mundur (timer) yang berjalan selama 3 detik
    Timer(const Duration(seconds: 3), () {
      
      // Kode ini digunakan untuk berpindah ke halaman OnboardingScreen dan menghapus halaman Splash dari riwayat agar pengguna tidak bisa menekan tombol 'Back' ke halaman ini lagi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Kode ini digunakan untuk membuat struktur dasar halaman layar tanpa warna latar bawaan
    return Scaffold(
      backgroundColor: Colors.transparent,
      
      // Kode ini digunakan untuk menerapkan widget latar belakang gradasi warna yang sudah dibuat secara terpisah
      body: GradientBackground(
        // Kode ini digunakan untuk memposisikan seluruh isi konten tepat di tengah-tengah layar
        child: Center(
          // Kode ini digunakan untuk menyusun elemen gambar dan teks secara vertikal dari atas ke bawah
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              // Kode ini digunakan untuk memuat dan menampilkan gambar logo aplikasi dari folder lokal komputer/laptop
              Image.asset(
                'assets/logos/logo-no-title.png',
                width: 350,
                height: 350,
              ),
              
              // Kode ini digunakan untuk memberikan jarak spasi kosong setinggi 20 pixel antara gambar logo dan teks di bawahnya
              const SizedBox(height: 20),
              
              // Kode ini digunakan untuk menampilkan teks judul aplikasi dengan gaya huruf tebal, besar, dan berwarna kuning
              const Text(
                'RATING',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 253, 232, 43), // Kode ini digunakan untuk menghasilkan warna kuning yang spesifik
                  letterSpacing: 2.0, // Kode ini digunakan untuk memberi jarak renggang antar huruf agar terlihat lebih keren
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}