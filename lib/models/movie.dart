class Movie {
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final String trailerUrl;

  Movie({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.trailerUrl,
  });
}

List<Movie> allMovies = [
  Movie(
    title: "Agak Laen",
    description: "Empat sekawan penjaga wahana rumah hantu di pasar malam mencari cara agar wahana mereka tidak bangkrut. Namun, sebuah insiden mengubah segalanya menjadi sangat lucu sekaligus menegangkan.",
    imageUrl: "assets/images/AgakLaen.jpg",
    rating: 8.9,
    trailerUrl: "https://youtu.be/0YLSPyGA4h0",
  ),
  Movie(
    title: "KKN di Desa Penari",
    description: "Enam mahasiswa yang melakukan Kuliah Kerja Nyata (KKN) di sebuah desa terpencil mengalami serangkaian kejadian mistis yang mengancam nyawa mereka.",
    imageUrl: "assets/images/KKN.jpg",
    rating: 7.5,
    trailerUrl: "https://youtu.be/PAMx9m4Z2V4", 
  ),
  Movie(
    title: "Grave of the Fireflies (Hotaru no Haka)",
    description: "Serangan bom pesawat Amerika Serikat menghancurkan kota tersebut. Seita (remaja laki-laki) dan Setsuko (adik perempuannya yang masih kecil) kehilangan ibu mereka yang tewas akibat luka bakar parah saat pengeboman. Karena ayah mereka sedang bertugas di Angkatan Laut, mereka menjadi yatim piatu dalam semalam.",
    imageUrl: "assets/images/FireFlies.jpeg",
    rating: 8.2,
    trailerUrl: "https://youtu.be/lhlh7JVcTt8", 
  ),
  Movie(
    title: "500 Days of Summer",
    description: "Kisah komedi romantis non-linear tentang seorang pria yang jatuh cinta pada pandangan pertama dengan seorang wanita yang sama sekali tidak percaya pada cinta sejati.",
    imageUrl: "assets/images/500days.jpg",
    rating: 7.7,
    trailerUrl: "https://youtu.be/PsD0NpFSADM", 
  ),
  Movie(
    title: "Avengers: Endgame",
    description: "Setelah jentikan jari Thanos yang melenyapkan separuh populasi semesta, sisa-sisa Avengers berkumpul sekali lagi untuk mengembalikan keseimbangan alam semesta.",
    imageUrl: "assets/images/Avenger.jpg",
    rating: 8.4,
    trailerUrl: "https://www.youtube.com/watch?v=TcMBFSGVi1c", 
  ),
  Movie(
    title: "Breaking Bad",
    description: "Seorang guru kimia SMA yang didiagnosis menderita kanker paru-paru beralih menjadi produsen methamphetamine demi mengamankan masa depan finansial keluarganya.",
    imageUrl: "assets/images/BreakinBad.jpg",
    rating: 9.5,
    trailerUrl: "https://www.youtube.com/watch?v=HhesaQXLuRY", 
  ),
  Movie(
    title: "Miracle In Cell 7 Korean Version",
    description: "Seorang ayah dengan keterbelakangan mental yang sangat mencintai putrinya, Ye-sung. Hidup mereka berubah tragis ketika Yong-gu dituduh secara tidak sah atas kasus pembunuhan dan pemerkosaan terhadap anak seorang komisaris polisi",
    imageUrl: "assets/images/Miracle.jpg",
    rating: 8.6,
    trailerUrl: "https://youtu.be/h9MGZFy-gog", 
  ),
  Movie(
    title: "You Are the Apple of My Eye",
    description: "Sekelompok sahabat sekolah yang semuanya menyukai siswi teladan bernama Shen Chia-yi. Fokus utamanya adalah hubungan antara si pembuat onar, Ko-teng, dengan Shen Chia-yi yang perlahan tumbuh menjadi cinta yang membekas seumur hidup.",
    imageUrl: "assets/images/Apple.jpg",
    rating: 8.5,
    trailerUrl: "https://youtu.be/gQylx2S9yrM", 
  ),
  Movie(
    title: "The Walking Dead",
    description: "Deputi sheriff Rick Grimes terbangun dari koma dan menemukan peradaban telah runtuh. Ia kemudian memimpin sekelompok penyintas untuk mencari tempat aman. Namun, seiring berjalannya waktu, mereka menyadari bahwa ancaman dari sesama manusia yang haus kekuasaan dan kehilangan moral seringkali jauh lebih mematikan daripada ancaman zombie itu sendiri.",
    imageUrl: "assets/images/TWD.jpg",
    rating: 8.7,
    trailerUrl: "https://youtu.be/cu2ApTImBKc", 
  ),
  Movie(
    title: "One Piece",
    description: "One Piece adalah serial manga dan anime populer karya Eiichiro Oda yang mengisahkan petualangan Monkey D. Luffy, seorang pemuda berkekuatan karet, bersama krunya, Bajak Laut Topi Jerami. Mereka mengarungi lautan untuk menemukan harta karun legendaris One Piece, agar Luffy bisa menjadi Raja Bajak Laut berikutnya. ",
    imageUrl: "assets/images/OP.jpg",
    rating: 9.9,
    trailerUrl: "https://youtu.be/lgAwlnGLTUg",
  ),
];