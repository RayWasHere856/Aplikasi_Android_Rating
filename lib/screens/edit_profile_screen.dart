import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

// Kode ini digunakan untuk membuat halaman edit profil yang bersifat dinamis (StatefulWidget)
class EditProfileScreen extends StatefulWidget {
  // Kode ini digunakan untuk menerima data profil pengguna saat ini beserta fungsi penyimpanannya dari halaman sebelumnya
  final String currentFirstName;
  final String currentLastName;
  final String currentEmail;
  final String currentPassword;
  final Function(String, String, String, String) onSave;

  const EditProfileScreen({
    Key? key,
    required this.currentFirstName,
    required this.currentLastName,
    required this.currentEmail,
    required this.currentPassword,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Kode ini digunakan untuk membuat controller yang akan menangani perubahan teks pada masing-masing kolom input
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Kode ini digunakan untuk mengisi nilai awal pada kolom teks sesuai dengan data profil pengguna yang sudah ada
    _firstNameController = TextEditingController(text: widget.currentFirstName);
    _lastNameController = TextEditingController(text: widget.currentLastName);
    _emailController = TextEditingController(text: widget.currentEmail);
    _passwordController = TextEditingController(text: widget.currentPassword);
  }

  @override
  void dispose() {
    // Kode ini digunakan untuk membersihkan memory controller ketika halaman ditutup untuk mencegah kebocoran memory (memory leak)
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Kode ini digunakan untuk membuat struktur dasar halaman edit profil
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Kode ini digunakan agar latar belakang gradasi menyatu hingga menembus bagian belakang AppBar
      extendBodyBehindAppBar: true,

      // Kode ini digunakan untuk membuat bilah navigasi atas (AppBar) yang transparan
      appBar: AppBar(
        title: const Text(
          "Edit Profil",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Kode ini digunakan untuk menerapkan latar belakang warna gradasi
      body: GradientBackground(
        // Kode ini digunakan untuk memastikan konten aman dan tidak tertutup oleh status bar atau poni layar (notch)
        child: SafeArea(
          // Kode ini digunakan untuk membungkus form agar bisa di-scroll ketika keyboard muncul menutupi layar
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            // Kode ini digunakan untuk menyusun elemen-elemen form secara vertikal (atas ke bawah)
            child: Column(
              children: [
                // Kode ini digunakan untuk membuat bingkai lingkaran berwarna biru di luar foto profil
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueAccent, width: 2),
                  ),
                  // Kode ini digunakan untuk menampilkan foto profil (sementara menggunakan gambar placeholder)
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                ),
                // Kode ini digunakan untuk membuat tombol teks yang nantinya bisa difungsikan untuk mengganti foto profil
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Ganti Foto Profil",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Kode ini digunakan untuk membuat kolom input teks untuk mengubah Nama Awal
                _buildTextField(
                  controller: _firstNameController,
                  label: "Nama Awal",
                  icon: Icons.person,
                ),
                const SizedBox(height: 15),

                // Kode ini digunakan untuk membuat kolom input teks untuk mengubah Nama Akhir
                _buildTextField(
                  controller: _lastNameController,
                  label: "Nama Akhir",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 15),

                // Kode ini digunakan untuk membuat kolom input untuk mengubah Email dengan format keyboard khusus email
                _buildTextField(
                  controller: _emailController,
                  label: "Email",
                  icon: Icons.email,
                  isEmail: true,
                ),
                const SizedBox(height: 15),

                // Kode ini digunakan untuk membuat kolom input untuk mengubah Password dengan karakter yang disembunyikan
                _buildTextField(
                  controller: _passwordController,
                  label: "Password",
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 40),

                // Kode ini digunakan untuk mengatur agar tombol ambil panjang layar secara penuh (full width)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  // Kode ini digunakan untuk membuat tombol eksekusi penyimpanan profil berwarna biru
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    //penambahan code untuk async dan exception handling
                    onPressed: () async {
                      // Buka blok Try untuk memantau error
                      try {
                        if (_firstNameController.text.trim().isEmpty) {
                          throw Exception("Nama Awal tidak boleh kosong!");
                        }
                        if (_emailController.text.trim().isEmpty) {
                          throw Exception("Email tidak boleh kosong!");
                        }
                        if (!_emailController.text.contains("@")) {
                          throw const FormatException(
                            "Format email tidak valid (wajib menggunakan '@')!",
                          );
                        }
                        if (_passwordController.text.trim().length < 6) {
                          throw Exception("Password minimal harus 6 karakter!");
                        }
                        // Munculkan kotak loading berputar
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Mencegah user menutup loading dengan klik sembarangan
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          ),
                        );

                        // Paksa sistem menunggu 1,5 detik
                        await Future.delayed(
                          const Duration(milliseconds: 1500),
                        );

                        // Tutup kotak loading
                        Navigator.pop(context);

                        widget.onSave(
                          _firstNameController.text.trim(),
                          _lastNameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );

                        // Tutup halaman Edit Profil
                        Navigator.pop(context);

                        // Tampilkan pesan sukses hijau
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Profil berhasil diperbarui!',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        // Jika ada data tidak lolos validasi, kodenya akan melompat ke sini

                        String errorMessage = "Terjadi kesalahan.";
                        if (e is FormatException) {
                          errorMessage =
                              e.message; // Ambil pesan dari FormatException
                        } else if (e is Exception) {
                          errorMessage = e.toString().replaceAll(
                            "Exception: ",
                            "",
                          ); // Ambil pesan dari Exception biasa
                        }

                        // Tampilkan pesan error merah
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Simpan Perubahan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Kode ini digunakan sebagai fungsi pembantu (helper) untuk mendesain kolom input secara seragam agar kodenya tidak ditulis berulang-ulang
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool isEmail = false,
  }) {
    return TextField(
      controller: controller,
      // Kode ini digunakan untuk menyembunyikan teks masukan menjadi titik-titik jika kolom tersebut adalah kolom password
      obscureText: isPassword,
      // Kode ini digunakan untuk memunculkan keyboard dengan simbol '@' jika kolom tersebut adalah kolom email
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      // Kode ini digunakan untuk mengatur gaya visual kolom input seperti teks label, ikon, warna latar, dan garis batas
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
