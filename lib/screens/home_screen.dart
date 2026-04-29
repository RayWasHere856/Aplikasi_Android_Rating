import 'package:flutter/material.dart';
import 'dart:async';
import 'movie_detail_screen.dart';
import '../models/movie.dart';
import '../widgets/gradient_background.dart';

// Kode ini digunakan untuk membuat halaman utama (Home) yang bersifat dinamis dan menerima data nama pengguna
class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({Key? key, required this.userName}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Kode ini digunakan untuk menyimpan daftar film hasil pencarian agar tampilan bisa diperbarui
  List<Movie> _foundMovies = [];
  // Kode ini digunakan untuk mengontrol pergeseran halaman pada banner carousel
  final PageController _pageController = PageController();
  // Kode ini digunakan untuk melacak urutan halaman banner yang sedang aktif
  int _currentPage = 0;
  // Kode ini digunakan untuk mengatur waktu geser otomatis pada banner
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Kode ini digunakan untuk mengisi daftar pencarian awal dengan seluruh film yang ada
    _foundMovies = allMovies;
    
    // Kode ini digunakan untuk membuat banner carousel bergeser otomatis ke halaman berikutnya setiap 5 detik
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      // Kode ini digunakan untuk menjalankan animasi pergeseran halaman secara halus
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Kode ini digunakan untuk menghentikan timer dan membersihkan memori controller saat halaman ditutup
  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Kode ini digunakan untuk menyaring daftar film berdasarkan teks atau kata kunci yang diketik oleh pengguna
  void _runFilter(String enteredKeyword) {
    List<Movie> results = [];
    if (enteredKeyword.isEmpty) {
      // Kode ini digunakan untuk mengembalikan seluruh daftar film jika kolom pencarian kosong
      results = allMovies;
    } else {
      // Kode ini digunakan untuk mencari film yang judulnya mengandung huruf yang diketikkan (mengabaikan huruf besar/kecil)
      results = allMovies
          .where(
            (movie) => movie.title.toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
          )
          .toList();
    }
    // Kode ini digunakan untuk memperbarui tampilan layar dengan hasil pencarian terbaru
    setState(() {
      _foundMovies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Kode ini digunakan untuk membangun kerangka dasar layar aplikasi
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Kode ini digunakan agar latar belakang gradasi menyatu hingga menembus bagian belakang AppBar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Kode ini digunakan untuk menampilkan sapaan beserta nama pengguna yang login di bagian atas layar
        title: Text(
          'Selamat Datang, ${widget.userName}!',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // Kode ini digunakan untuk menerapkan widget latar belakang gradasi khusus yang telah dibuat
      body: GradientBackground(
        // Kode ini digunakan untuk menjaga konten agar tidak menabrak area notch atau status bar di HP
        child: SafeArea(
          // Kode ini digunakan agar seluruh isi halaman dapat di-scroll ke bawah
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  
                  // Kode ini digunakan untuk membuat kolom input pencarian film
                  TextField(
                    // Kode ini digunakan untuk memicu fungsi penyaringan data setiap kali huruf baru diketik
                    onChanged: (value) => _runFilter(value),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Cari film favoritmu...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white54,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Kode ini digunakan untuk membuat area banner film (carousel) yang dapat digeser
                  SizedBox(
                    height: 180,
                    child: PageView.builder(
                      controller: _pageController,
                      // Kode ini digunakan untuk mendeteksi perubahan halaman dan memperbarui posisi titik indikator
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final movie = allMovies[index];
                        return GestureDetector(
                          // Kode ini digunakan untuk berpindah ke halaman detail film saat gambar banner ditekan
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(movie: movie),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                image: AssetImage(movie.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              // Kode ini digunakan untuk memberikan efek bayangan gelap di bagian bawah gambar agar judul film lebih terbaca
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Kode ini digunakan untuk membuat titik-titik indikator halaman persis di bawah banner carousel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        // Kode ini digunakan untuk melebarkan titik indikator jika halaman tersebut sedang aktif
                        width: _currentPage == index ? 20.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          // Kode ini digunakan untuk memberi warna biru pada titik aktif dan warna pudar pada titik tidak aktif
                          color: _currentPage == index
                              ? Colors.blueAccent
                              : Colors.white38,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'TRENDING NOW',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Kode ini digunakan untuk menampilkan daftar film dalam bentuk susunan vertikal ke bawah
                  _foundMovies.isNotEmpty
                      ? ListView.builder(
                          // Kode ini digunakan agar ListView tidak mengambil ruang layar secara penuh melainkan menyesuaikan isi kontennya
                          shrinkWrap: true,
                          // Kode ini digunakan untuk mematikan scroll bawaan ListView karena sudah dibungkus oleh SingleChildScrollView
                          physics: const NeverScrollableScrollPhysics(),
                          // Kode ini digunakan untuk membatasi jumlah film yang tampil maksimal hanya 4 film teratas
                          itemCount: _foundMovies.length > 4
                              ? 4
                              : _foundMovies.length,
                          itemBuilder: (context, index) {
                            final movie = _foundMovies[index];

                            return GestureDetector(
                              // Kode ini digunakan untuk berpindah ke halaman detail film saat kartu film ditekan
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetailScreen(movie: movie),
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 15),
                                color: Colors.white.withOpacity(0.05),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(color: Colors.white10),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      // Kode ini digunakan untuk menampilkan gambar poster film di dalam kartu
                                      child: Image.asset(
                                        movie.imageUrl,
                                        width: 100,
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            movie.title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          // Kode ini digunakan untuk memotong teks sinopsis maksimal 2 baris dan menambahkan titik-titik (ellipsis) di ujungnya
                                          Text(
                                            movie.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.thumb_up,
                                                color: Colors.blueAccent,
                                                size: 18,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                movie.rating.toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      
                      // Kode ini digunakan untuk menampilkan peringatan ketika film yang dicari pengguna tidak ditemukan
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.0),
                          child: Center(
                            child: Text(
                              'Film tidak ditemukan',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ),

                  const SizedBox(height: 20),
                  const Text(
                    'TEMUKAN FILM YANG KAMU CARI',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Kode ini digunakan untuk membuat katalog seluruh film dalam bentuk grid (tata letak kotak-kotak)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // Kode ini digunakan untuk mengatur struktur grid menjadi 2 kolom dengan jarak pemisah 10 piksel dan rasio ukuran tertentu
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: allMovies.length,
                    itemBuilder: (context, index) {
                      final movie = allMovies[index];
                      return GestureDetector(
                        // Kode ini digunakan untuk berpindah ke layar detail saat salah satu poster grid disentuh
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailScreen(movie: movie),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(movie.imageUrl), 
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            // Kode ini digunakan untuk menambahkan bayangan gradasi dari bawah ke atas pada tiap kotak poster agar teks mudah dibaca
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.9),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.thumb_up_alt_sharp,
                                      color: Colors.lightGreenAccent,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.rating.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}