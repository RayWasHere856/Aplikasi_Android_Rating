import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';

// Kode ini digunakan untuk membuat struktur navigasi utama (Bottom Navigation) yang membungkus seluruh halaman aplikasi
class MainWrapper extends StatefulWidget {
  final String userName;
  const MainWrapper({Key? key, required this.userName}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // Kode ini digunakan untuk melacak halaman mana yang sedang aktif atau dipilih oleh pengguna
  int _selectedIndex = 0;

  // Kode ini digunakan untuk menyimpan status data profil pengguna agar tidak hilang saat berpindah halaman
  late String firstName;
  String lastName = "";
  String email = "user@contoh.com";
  String password = "password123";

  // Kode ini digunakan untuk mengatur nilai awal nama depan pengguna berdasarkan data yang dikirim dari halaman Login/Register
  @override
  void initState() {
    super.initState();
    firstName = widget.userName;
  }

  // Kode ini digunakan untuk memperbarui data profil secara dinamis ketika pengguna melakukan perubahan di halaman Profile
  void updateProfileData(
    String newFirst,
    String newLast,
    String newEmail,
    String newPass,
  ) {
    setState(() {
      firstName = newFirst;
      lastName = newLast;
      email = newEmail;
      password = newPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Kode ini digunakan untuk mendaftarkan semua halaman menu ke dalam sebuah daftar (list) agar mudah dipanggil
    final List<Widget> pages = [
      HomeScreen(userName: firstName),
      const SearchScreen(),
      const FavoriteScreen(),
      ProfileScreen(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        onProfileChanged: updateProfileData,
      ),
    ];

    return Scaffold(
      // Kode ini digunakan agar konten halaman dapat memanjang hingga ke belakang menu navigasi bawah (transparan)
      extendBody: true,

      // Kode ini digunakan untuk menampilkan halaman ke layar sesuai dengan urutan index menu yang sedang diklik
      body: pages[_selectedIndex],
      
      // Kode ini digunakan untuk membuat wadah (container) menu navigasi bagian bawah dengan warna dan garis tepi khusus
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F005C).withOpacity(0.9),
          border: const Border(
            top: BorderSide(color: Colors.white10, width: 1),
          ),
        ),
        
        // Kode ini digunakan untuk membangun elemen-elemen tombol navigasi beserta ikonnya
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          
          // Kode ini digunakan untuk mendeteksi klik pada menu dan mengubah tampilan halaman sesuai ikon yang dipilih
          onTap: (index) => setState(() => _selectedIndex = index),
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
          
          // Kode ini digunakan untuk mendefinisikan 4 pilihan menu navigasi (Home, Search, Favorite, Profile)
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorite"), 
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}