// Kode ini digunakan untuk mengimpor library bawaan Flutter untuk membangun antarmuka aplikasi
import 'package:flutter/material.dart';

// Kode ini digunakan untuk membuat widget kustom bernama GradientBackground yang sifatnya statis (StatelessWidget)
class GradientBackground extends StatelessWidget {
  // Kode ini digunakan untuk menyiapkan variabel 'child' yang akan menampung widget/konten lain di dalam background ini
  final Widget child;

  // Kode ini digunakan sebagai konstruktor yang mewajibkan pemanggilan widget ini disertai dengan isi kontennya (child)
  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Kode ini digunakan untuk membuat wadah utama (container) yang bertindak sebagai latar belakang
    return Container(
      // Kode ini digunakan agar lebar dan tinggi latar belakang membentang penuh menyesuaikan ukuran layar perangkat
      width: double.infinity,
      height: double.infinity,
      // Kode ini digunakan untuk mendesain tampilan wadah dengan efek gradasi warna linier
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          // Kode ini digunakan untuk mengatur arah aliran gradasi warna dimulai dari titik tengah atas menuju titik tengah bawah layar
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter, 
          // Kode ini digunakan untuk menentukan kombinasi dua warna gelap (ungu/biru tua) yang dicampur menjadi gradasi
          colors: [
            Color(0xFF0A002A), 
            Color(0xFF1F005C), 
          ],
        ),
      ),
      // Kode ini digunakan untuk meletakkan dan menampilkan konten utama aplikasi tepat di atas latar belakang gradasi ini
      child: child, 
    );
  }
}