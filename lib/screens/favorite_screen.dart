import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/gradient_background.dart';
import 'movie_detail_screen.dart';

// Kode ini digunakan untuk membuat halaman Daftar Favorit yang bersifat dinamis (StatefulWidget)
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Kode ini digunakan untuk membangun antarmuka utama halaman Daftar Favorit
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Kode ini digunakan agar latar belakang gradasi menyatu hingga menembus bagian belakang AppBar
      extendBodyBehindAppBar: true,
      
      // Kode ini digunakan untuk membuat bilah navigasi atas (AppBar) yang transparan
      appBar: AppBar(
        title: const Text(
          "Daftar Favorit",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      // Kode ini digunakan untuk menerapkan widget latar belakang gradasi khusus yang telah dibuat
      body: GradientBackground(
        // Kode ini digunakan untuk memastikan konten aman dan tidak tertutup oleh status bar atau poni layar (notch)
        child: SafeArea(
          // Kode ini digunakan untuk mengecek apakah daftar film favorit di memori kosong atau tidak
          child: favoriteMovies.isEmpty
              // Kode ini digunakan untuk menampilkan ikon dan pesan jika belum ada film favorit yang ditambahkan
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star_border, size: 80, color: Colors.white24),
                      SizedBox(height: 15),
                      Text(
                        "Belum ada film favorit",
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    ],
                  ),
                )
              // Kode ini digunakan untuk menampilkan daftar film favorit dalam bentuk susunan vertikal ke bawah yang bisa di-scroll
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: favoriteMovies.length,
                  itemBuilder: (context, index) {
                    final movie = favoriteMovies[index];
                    // Kode ini digunakan untuk memanggil fungsi pembuat kartu film
                    return _buildFavoriteCard(movie, context);
                  },
                ),
        ),
      ),
    );
  }

  // Kode ini digunakan untuk membuat desain kartu (UI) per item film yang ada di dalam daftar favorit
  Widget _buildFavoriteCard(Movie movie, BuildContext context) {
    // Kode ini digunakan untuk mendeteksi sentuhan agar pengguna bisa menekan keseluruhan kartu film
    return GestureDetector(
      onTap: () {
        // Kode ini digunakan untuk berpindah ke halaman detail film saat kartu ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        ).then((value) => setState(() {})); // Kode ini digunakan untuk menyegarkan (refresh) halaman favorit jika ada perubahan setelah kembali dari halaman detail
      },
      // Kode ini digunakan untuk membuat kotak kartu agak transparan dengan garis tepi yang tipis
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10),
        ),
        // Kode ini digunakan untuk menyusun isi kartu (gambar, teks, tombol hapus) secara berdampingan (horizontal)
        child: Row(
          children: [
            // Kode ini digunakan untuk menampilkan gambar poster film dengan sudut yang melengkung
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                movie.imageUrl,
                width: 70,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            // Kode ini digunakan agar teks informasi film mengambil sisa ruang kosong yang tersedia pada baris
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kode ini digunakan untuk menampilkan judul film dan memotongnya dengan titik-titik jika lebih dari 2 baris
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.genres.join(", "),
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Kode ini digunakan untuk menampilkan ikon bintang dan angka rating film
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        movie.rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Kode ini digunakan untuk membuat tombol hapus (ikon silang) di sisi paling kanan kartu
            IconButton(
              icon: Icon(Icons.close, color: Colors.redAccent),
              onPressed: () {
                // Kode ini digunakan untuk menghapus film yang dipilih dari variabel daftar favorit dan menyegarkan tampilan
                setState(() {
                  favoriteMovies.remove(movie);
                });

                // Kode ini digunakan untuk memunculkan pesan pop-up singkat (notifikasi) di bawah layar setelah film dihapus
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${movie.title} dihapus dari Favorit"),
                    backgroundColor: Colors.redAccent,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}