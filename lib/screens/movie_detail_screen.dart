import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/movie.dart';
import '../widgets/gradient_background.dart';

// Kode ini digunakan untuk membuat halaman detail film yang interaktif (StatefulWidget)
class MovieDetailScreen extends StatefulWidget {
  // Kode ini digunakan untuk menerima data objek 'Movie' yang dikirim dari halaman sebelumnya
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  // Kode ini digunakan untuk mengontrol teks input pada kolom komentar
  final TextEditingController _commentController = TextEditingController();
  // Kode ini digunakan untuk mengontrol pemutaran video YouTube
  late YoutubePlayerController _youtubeController;

  // Kode ini digunakan untuk menyimpan jumlah awal interaksi tombol reaksi
  int _likes = 142;
  int _neutrals = 35;
  int _dislikes = 8;
  
  // Kode ini digunakan untuk melacak tombol reaksi mana yang sedang aktif dipilih pengguna
  String _selectedReaction = "";

  // Kode ini digunakan untuk menyiapkan daftar komentar bawaan (dummy data)
  List<String> comments = [
    "Keren sih tapi masih kurang keren",
    "Gaperlu masuk kelas karna udah berkelas",
    "Kata Ryan Keren",
    "Kata Rayhan GG",
    "Kata Rava PCnya ngelag",
    "Kata Doni HomeSick",
    "Kata Maskel dah oke lek",
  ];

  @override
  void initState() {
    super.initState();
    // Kode ini digunakan untuk mengubah URL video YouTube biasa menjadi ID unik yang dibutuhkan oleh pemutar video
    final videoId = YoutubePlayer.convertUrlToId(widget.movie.trailerUrl);
    
    // Kode ini digunakan untuk menginisialisasi pengaturan awal pemutar video YouTube (tidak otomatis berputar, tidak bisu)
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  // Kode ini digunakan untuk membersihkan memory saat layar ditutup agar video berhenti memutar di latar belakang
  @override
  void dispose() {
    _youtubeController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  // Kode ini digunakan untuk memproses pengiriman komentar baru
  void _addComment() {
    // Kode ini digunakan untuk memastikan komentar tidak kosong sebelum ditambahkan
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        // Kode ini digunakan untuk memasukkan komentar baru ke posisi paling atas daftar (index 0)
        comments.insert(0, _commentController.text.trim());
        // Kode ini digunakan untuk mengosongkan kolom teks setelah komentar terkirim
        _commentController.clear();
        // Kode ini digunakan untuk menyembunyikan keyboard dari layar
        FocusScope.of(context).unfocus();
      });
    }
  }

  // Kode ini digunakan untuk menangani logika saat pengguna menekan salah satu tombol reaksi (Like, Biasa, Kurang)
  void _handleReaction(String type) {
    setState(() {
      // Kode ini digunakan untuk mengurangi angka pada reaksi yang sebelumnya dipilih (membatalkan pilihan lama)
      if (_selectedReaction == "like") _likes--;
      if (_selectedReaction == "neutral") _neutrals--;
      if (_selectedReaction == "dislike") _dislikes--;

      // Kode ini digunakan untuk mengecek apakah pengguna menekan tombol reaksi yang sama dua kali (untuk membatalkan reaksi)
      if (_selectedReaction == type) {
        _selectedReaction = "";
      } else {
        // Kode ini digunakan untuk menerapkan pilihan reaksi baru dan menambahkan jumlah angkanya
        _selectedReaction = type;
        if (type == "like") _likes++;
        if (type == "neutral") _neutrals++;
        if (type == "dislike") _dislikes++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Kode ini digunakan agar latar belakang gradasi menyatu hingga menembus bagian belakang AppBar
      extendBodyBehindAppBar: true,
      
      // Kode ini digunakan untuk membuat AppBar yang berisi judul film
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      body: GradientBackground(
        // Kode ini digunakan agar seluruh isi layar bisa di-scroll ke bawah
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER GAMBAR POSTER ---
              // Kode ini digunakan untuk menumpuk gambar poster film dengan efek bayangan gradasi di atasnya
              Stack(
                children: [
                  Image.asset(
                    widget.movie.imageUrl,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      // Kode ini digunakan untuk membuat efek gradasi gelap dari bawah gambar agar teks informasi di bawahnya mudah dibaca
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [const Color(0xFF0A002A), Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),

              // --- KONTEN INFORMASI ---
              // Kode ini digunakan untuk memberikan jarak tepian (padding) di sisi kiri dan kanan pada seluruh teks konten
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // Jarak agar konten tidak terlalu mepet ke gambar atas
                    const SizedBox(height: 15),

                    // ==========================================
                    // --- ROW: JUDUL FILM & TOMBOL FAVORIT ---
                    // ==========================================
                    // Kode ini digunakan untuk menempatkan judul film dan ikon hati (favorit) agar bersebelahan
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded digunakan agar Judul memakan sisa ruang yang ada dan turun ke baris baru jika terlalu panjang
                        Expanded(
                          child: Text(
                            widget.movie.title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 10), // Spasi antara judul dan tombol

                        // Tombol Favorit di ujung kanan (diberi Padding Top sedikit)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: GestureDetector(
                            // Kode ini digunakan untuk memicu penambahan atau penghapusan film dari daftar "favoriteMovies"
                            onTap: () {
                              setState(() {
                                if (favoriteMovies.contains(widget.movie)) {
                                  favoriteMovies.remove(widget.movie);
                                } else {
                                  favoriteMovies.add(widget.movie);
                                }
                              });
                            },
                            child: Column(
                              children: [
                                // Kode ini digunakan untuk mengubah tampilan ikon dan warna tergantung apakah film ada di daftar favorit
                                Icon(
                                  favoriteMovies.contains(widget.movie)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: favoriteMovies.contains(widget.movie)
                                      ? Colors.redAccent
                                      : Colors.white54,
                                  size: 32,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Favorite",
                                  style: TextStyle(
                                    color: favoriteMovies.contains(widget.movie)
                                        ? Colors.redAccent
                                        : Colors.white54,
                                    fontSize: 12,
                                    fontWeight: favoriteMovies.contains(widget.movie) 
                                        ? FontWeight.bold 
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ==========================================
                    
                    const SizedBox(height: 15),

                    // Baris Tanggal, Durasi, dan Rating
                    // Kode ini digunakan untuk menampilkan deretan info detail film secara menyamping (horizontal)
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white54,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.movie.releaseYear,
                          style: const TextStyle(color: Colors.white54),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.access_time,
                          color: Colors.white54,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.movie.duration,
                          style: const TextStyle(color: Colors.white54),
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          widget.movie.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Chips Genre
                    // Kode ini digunakan untuk menyusun kotak-kotak kategori (genre) film, yang akan otomatis turun baris (wrap) jika ruang tidak cukup
                    Wrap(
                      spacing: 8,
                      children: widget.movie.genres
                          .map(
                            (genre) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.blueAccent.withOpacity(0.5),
                                ),
                              ),
                              child: Text(
                                genre,
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 25),
                    
                    // Sutradara dan Aktor
                    // Kode ini digunakan untuk menampilkan nama-nama kreator film tersebut
                    Text(
                      "Sutradara : ${widget.movie.director}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Aktor        : ${widget.movie.actors}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    
                    const SizedBox(height: 25),

                    // Sinopsis
                    const Text(
                      "SINOPSIS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Kode ini digunakan untuk menampilkan alur cerita dari film terkait
                    Text(
                      widget.movie.description,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Trailer YouTube
                    const Text(
                      "TRAILER",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Kode ini digunakan untuk menampilkan bingkai pemutar video YouTube yang sudutnya melengkung (rounded)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: YoutubePlayer(
                        controller: _youtubeController,
                        showVideoProgressIndicator: true,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Reaksi (Like, Neutral, Dislike)
                    const Text(
                      "REAKSI ANDA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Kode ini digunakan untuk menyusun ketiga tombol respon emosional dengan spasi yang seimbang di antaranya
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildReactionButton(
                          icon: Icons.thumb_up_alt_rounded,
                          label: "Suka",
                          count: _likes,
                          isSelected: _selectedReaction == "like",
                          activeColor: Colors.greenAccent,
                          onTap: () => _handleReaction("like"),
                        ),
                        _buildReactionButton(
                          icon: Icons.sentiment_neutral_rounded,
                          label: "Biasa",
                          count: _neutrals,
                          isSelected: _selectedReaction == "neutral",
                          activeColor: Colors.amberAccent,
                          onTap: () => _handleReaction("neutral"),
                        ),
                        _buildReactionButton(
                          icon: Icons.thumb_down_alt_rounded,
                          label: "Kurang",
                          count: _dislikes,
                          isSelected: _selectedReaction == "dislike",
                          activeColor: Colors.redAccent,
                          onTap: () => _handleReaction("dislike"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Kode ini digunakan untuk menggambar garis pembatas antar bagian
                    const Divider(color: Colors.white10, thickness: 1),
                    const SizedBox(height: 20),

                    // Input & Daftar Komentar
                    const Text(
                      "KOMENTAR",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Kode ini digunakan untuk menyusun kolom input pesan dan tombol kirim komentar
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Tulis pendapatmu...",
                              hintStyle: const TextStyle(color: Colors.white38),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.05),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Kode ini digunakan untuk membuat tombol pengiriman komentar berbentuk lingkaran biru
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                            // Kode ini digunakan untuk menjalankan fungsi menyimpan komentar
                            onPressed: _addComment,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    
                    // Kode ini digunakan untuk memproses seluruh data di daftar 'comments' dan mencetaknya menjadi bentuk kotak-kotak ulasan di layar
                    Column(
                      children: comments.map((comment) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white10),
                          ),
                          // Kode ini digunakan untuk menyusun tata letak foto profil pengguna beserta isi komentarnya
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blueAccent.withOpacity(
                                  0.2,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Guest User",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      comment,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kode ini digunakan sebagai cetakan (builder) untuk mendesain tiap tombol reaksi di atas agar kodenya tidak diulang-ulang
  Widget _buildReactionButton({
    required IconData icon,
    required String label,
    required int count,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    // Kode ini digunakan untuk mendeteksi setiap sentuhan pada tombol
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Kode ini digunakan untuk membuat bentuk lingkaran bingkai ikon yang menampilkan transisi warna animasi saat dipilih
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? activeColor.withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? activeColor : Colors.white10,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? activeColor : Colors.white54,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          // Kode ini digunakan untuk menampilkan nama label reaksi
          Text(
            label,
            style: TextStyle(
              color: isSelected ? activeColor : Colors.white54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          // Kode ini digunakan untuk menampilkan jumlah pengguna yang merespon dengan tipe reaksi yang sama
          Text(
            count.toString(),
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}