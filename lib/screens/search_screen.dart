import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/gradient_background.dart';
import 'movie_detail_screen.dart';

// Kode ini digunakan untuk membuat halaman pencarian film yang interaktif (StatefulWidget)
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Kode ini digunakan untuk menyimpan teks kata kunci pencarian yang diketik pengguna
  String _searchQuery = "";

  // Kode ini digunakan untuk menyimpan kategori genre film yang sedang dipilih (nilai bawaan: "Semua")
  String _selectedGenre = "Semua";
  bool _isLoading = false;

  // Kode ini digunakan untuk mengumpulkan semua genre unik dari daftar film dan menambahkan opsi "Semua" di urutan pertama
  List<String> get _availableGenres {
    Set<String> genres = {"Semua"};
    for (var movie in allMovies) {
      genres.addAll(movie.genres);
    }
    return genres.toList();
  }

  // Kode ini digunakan untuk menyaring (filter) daftar film secara otomatis berdasarkan kata kunci judul dan genre yang dipilih
  List<Movie> get _filteredMovies {
    return allMovies.where((movie) {
      // Kode ini digunakan untuk mencocokkan teks pencarian dengan judul film (mengabaikan huruf besar/kecil)
      final matchesSearch = movie.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      // Kode ini digunakan untuk mencocokkan genre film dengan kategori genre yang sedang diklik
      final matchesGenre =
          _selectedGenre == "Semua" || movie.genres.contains(_selectedGenre);

      return matchesSearch && matchesGenre;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Kode ini digunakan untuk membuat kerangka dasar layar pencarian
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Kode ini digunakan agar latar belakang gradasi warna bisa menembus hingga ke belakang navigasi atas
      extendBodyBehindAppBar: true,

      // Kode ini digunakan untuk membuat bilah navigasi atas (AppBar) yang transparan
      appBar: AppBar(
        title: const Text(
          'Cari Film',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Kode ini digunakan untuk menerapkan warna latar belakang gradasi khusus
      body: GradientBackground(
        // Kode ini digunakan untuk menjaga konten agar aman dari potongan layar HP (notch/status bar)
        child: SafeArea(
          // Kode ini digunakan untuk menyusun kolom pencarian, daftar genre, dan daftar film dari atas ke bawah
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kode ini digunakan untuk memberikan ruang kosong (padding) di sekeliling kolom pencarian
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                // Kode ini digunakan untuk membuat kolom input tempat pengguna mengetikkan judul film
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  // Kode ini digunakan untuk memperbarui status pencarian (_searchQuery) setiap kali pengguna mengetik huruf baru
                  // Kode ini digunakan untuk memperbarui pencarian dengan simulasi Async (seolah-olah mencari ke server)
                  onChanged: (value) async {
                    // 1. Ubah status menjadi "sedang memuat" agar UI menampilkan animasi berputar
                    setState(() {
                      _isLoading = true;
                    });

                    // 2. Tahan proses selama 800 milidetik (simulasi proses pencarian data)
                    await Future.delayed(const Duration(milliseconds: 800));

                    // 3. Masukkan teks yang diketik ke variabel pencarian, lalu matikan status loading
                    setState(() {
                      _searchQuery = value;
                      _isLoading = false;
                    });
                  },
                  // Kode ini digunakan untuk mendesain kolom pencarian (ikon, teks bayangan, warna latar, dan lengkungan tepi)
                  decoration: InputDecoration(
                    hintText: "Ketik judul film...",
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Kode ini digunakan untuk membuat daftar tombol kategori (genre) yang bisa digeser ke samping (horizontal)
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _availableGenres.length,
                  itemBuilder: (context, index) {
                    final genre = _availableGenres[index];
                    // Kode ini digunakan untuk mengecek apakah tombol genre ini sedang dipilih oleh pengguna atau tidak
                    final isSelected = genre == _selectedGenre;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      // Kode ini digunakan untuk membuat tombol pilihan (chip) untuk tiap-tiap genre film
                      child: ChoiceChip(
                        label: Text(genre),
                        selected: isSelected,
                        // Kode ini digunakan untuk mengubah status genre yang dipilih ketika tombol ditekan
                        // Kode ini digunakan untuk memfilter genre dengan simulasi Async
                        onSelected: (selected) async {
                          // 1. Munculkan loading
                          setState(() {
                            _isLoading = true;
                          });

                          // 2. Simulasi delay 800 milidetik
                          await Future.delayed(
                            const Duration(milliseconds: 800),
                          );

                          // 3. Terapkan genre yang dipilih dan matikan loading
                          setState(() {
                            _selectedGenre = selected ? genre : "Semua";
                            _isLoading = false;
                          });
                        },
                        selectedColor: Colors.blueAccent,
                        backgroundColor: Colors.black.withOpacity(0.4),
                        // Kode ini digunakan untuk mengatur warna teks tombol (putih jika dipilih, abu-abu jika tidak)
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[300],
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        // Kode ini digunakan untuk membuat bentuk tepi tombol genre melengkung
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.blueAccent
                                : Colors.white38,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Kode ini digunakan agar daftar film mengambil seluruh sisa ruang kosong di bagian bawah layar
              // Kode ini digunakan agar daftar film mengambil seluruh sisa ruang kosong di layar
              Expanded(
                // Jika status sedang loading, tampilkan indikator berputar
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      )
                    // Jika tidak loading, cek apakah filmnya kosong
                    : _filteredMovies.isEmpty
                    ? const Center(
                        child: Text(
                          "Film tidak ditemukan",
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      )
                    // Jika filmnya ada, cetak daftar kartu filmnya
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        itemCount: _filteredMovies.length,
                        itemBuilder: (context, index) {
                          final movie = _filteredMovies[index];
                          return _buildMovieCard(movie, context);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kode ini digunakan sebagai fungsi pembantu untuk mendesain tampilan kotak (kartu) per film secara seragam
  Widget _buildMovieCard(Movie movie, BuildContext context) {
    // Kode ini digunakan untuk mendeteksi sentuhan pada kartu film
    return GestureDetector(
      // Kode ini digunakan untuk memindahkan halaman ke MovieDetailScreen saat kartu film diklik
      // 1. Tambahkan async untuk proses Asynchronous
      onTap: () async {
        // 2. Tampilkan kotak loading berputar memblokir layar
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          ),
        );

        // 3. Paksa sistem menunggu 1 detik
        await Future.delayed(const Duration(seconds: 1));

        // 4. Tutup loading
        Navigator.pop(context);

        // 5. Pindah halaman
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      // Kode ini digunakan untuk membuat desain wadah kartu film dengan warna semi-transparan dan tepian bulat
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10),
        ),
        // Kode ini digunakan untuk menyusun gambar poster dan teks deskripsi film secara berdampingan (horizontal)
        child: Row(
          children: [
            // Kode ini digunakan untuk memotong gambar poster film agar memiliki sudut yang sedikit melengkung
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                movie.imageUrl,
                width: 80,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),

            // Kode ini digunakan agar kolom teks mengambil sisa ruang yang tersedia di kanan gambar
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kode ini digunakan untuk menampilkan judul film dan memotongnya dengan titik-titik jika terlalu panjang
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
                  // Kode ini digunakan untuk menampilkan tahun rilis film
                  Text(
                    movie.releaseYear,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  // Kode ini digunakan untuk menampilkan ikon bintang berdampingan dengan angka rating film
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        movie.rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Kode ini digunakan untuk menampilkan ikon panah kecil di sisi paling kanan kartu film
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white24,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
