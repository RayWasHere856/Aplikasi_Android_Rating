import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'privacy_screen.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';
import '../widgets/gradient_background.dart';

// Kode ini digunakan untuk membuat halaman profil pengguna yang bersifat statis (StatelessWidget)
class ProfileScreen extends StatelessWidget {
  // Kode ini digunakan untuk menerima data profil pengguna dan fungsi pembaruan profil dari halaman utama
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final Function(String, String, String, String) onProfileChanged;

  const ProfileScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.onProfileChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Kode ini digunakan untuk menggabungkan nama depan dan nama belakang menjadi satu teks utuh
    String fullName = "$firstName $lastName".trim();

    return Scaffold(
      backgroundColor: Colors.transparent,
      // Kode ini digunakan agar latar belakang gradasi menyatu hingga menembus bagian belakang AppBar
      extendBodyBehindAppBar: true,

      // Kode ini digunakan untuk membuat bilah navigasi atas (AppBar) transparan dengan judul "Profil Saya"
      appBar: AppBar(
        title: const Text(
          "Profil Saya",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // Kode ini digunakan untuk menerapkan widget latar belakang gradasi khusus pada keseluruhan halaman
      body: GradientBackground(
        // Kode ini digunakan untuk menjaga konten agar tidak menabrak area notch atau status bar di atas layar
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Kode ini digunakan untuk membungkus area bagian atas profil (foto, nama, dan email)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Kode ini digunakan untuk membuat bingkai lingkaran berwarna biru di luar foto profil
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      // Kode ini digunakan untuk menampilkan foto profil (sementara menggunakan gambar placeholder internet)
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Kode ini digunakan agar kolom teks mengambil sisa ruang kosong di baris tersebut
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kode ini digunakan untuk menampilkan nama lengkap pengguna
                          Text(
                            fullName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Kode ini digunakan untuk menampilkan alamat email pengguna
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Kode ini digunakan agar daftar menu mengambil semua sisa ruang kosong di bagian bawah layar
              Expanded(
                // Kode ini digunakan untuk membuat wadah daftar menu dengan sudut melengkung di bagian atasnya
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    border: Border.all(color: Colors.white10, width: 1),
                  ),

                  // Kode ini digunakan untuk menyusun tombol-tombol menu profil dalam bentuk daftar vertikal
                  child: ListView(
                    children: [
                      // Kode ini digunakan untuk membuat tombol menu yang akan mengarahkan pengguna ke halaman "About Us"
                      _buildMenuItem(
                        context,
                        Icons.info_outline,
                        "About Us",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutUsScreen(),
                            ),
                          );
                        },
                      ),

                      // Kode ini digunakan untuk membuat tombol menu yang mengarahkan ke halaman "Kebijakan Pengguna"
                      _buildMenuItem(
                        context,
                        Icons.privacy_tip_outlined,
                        "Kebijakan Pengguna",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPolicyScreen(),
                            ),
                          );
                        },
                      ),

                      // Kode ini digunakan untuk membuat tombol menu yang akan mengarahkan ke halaman "Edit Profile" dan mengirimkan data pengguna saat ini
                      _buildMenuItem(
                        context,
                        Icons.settings_outlined,
                        "Setting Profile",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                currentFirstName: firstName,
                                currentLastName: lastName,
                                currentEmail: email,
                                currentPassword: password,
                                onSave:
                                    onProfileChanged, // Fungsi ini dikirim agar EditProfileScreen bisa mengubah data profil
                              ),
                            ),
                          );
                        },
                      ),

                      // Kode ini digunakan untuk membuat garis batas pemisah transparan sebelum tombol Sign Out
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: Colors.white24),
                      ),

                      // Kode ini digunakan untuk membuat tombol "Sign Out" berwarna merah yang akan mengembalikan pengguna ke halaman LoginScreen
                      _buildMenuItem(
                        context,
                        Icons.logout,
                        "Sign Out",
                        () async {
                          // 2. Munculkan dialog loading yang memblokir layar utama
                          showDialog(
                            context: context,
                            barrierDismissible:
                                false, // Mencegah user membatalkan proses dengan mengeklik luar kotak
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.redAccent,
                              ),
                            ),
                          );

                          // 3. Paksa sistem menunggu 1,5 detik (Simulasi menghapus token sesi dan cache lokal)
                          await Future.delayed(
                            const Duration(milliseconds: 1500),
                          );

                          // 4. Pastikan konteks UI masih valid sebelum melakukan navigasi
                          if (!context.mounted) return;

                          // 5. Tutup dialog loading
                          Navigator.pop(context);

                          // 6. Lakukan navigasi paksa ke halaman LoginScreen dan hancurkan seluruh riwayat navigasi sebelumnya
                          // Ini penting agar user tidak bisa kembali ke profil dengan menekan tombol "Back" di HP
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        color: Colors.redAccent,
                        textColor: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kode ini digunakan untuk mendefinisikan rancangan khusus (widget builder) yang seragam untuk setiap baris menu di atas
  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
    Color? textColor,
  }) {
    // Kode ini digunakan untuk merangkai ikon, teks judul, dan tombol arah panah ke dalam bentuk baris interaktif (ListTile)
    return ListTile(
      // Kode ini digunakan untuk menampilkan ikon di sisi kiri list dengan kotak bingkai agak transparan
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (color ?? Colors.blueAccent).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color ?? Colors.blueAccent),
      ),
      // Kode ini digunakan untuk menampilkan nama menu
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      // Kode ini digunakan untuk meletakkan ikon panah kecil di ujung kanan sebagai penanda bahwa menu bisa ditekan
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.white54,
      ),
      // Kode ini digunakan untuk memicu aksi/perintah (navigasi) saat baris menu ditekan
      onTap: onTap,
    );
  }
}
