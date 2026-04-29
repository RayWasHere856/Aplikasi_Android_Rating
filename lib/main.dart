import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

// fungsi utama, pertama kali dijalankan saat app dibuka
void main() {
  runApp(const MyApp());
}
// root aplikasi
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rating App',// nama aplikasi
      debugShowCheckedModeBanner: false,// menghilangkan tulisan debug di pojok
      theme: ThemeData(
        primarySwatch: Colors.blue, // warna utama
        textTheme: GoogleFonts.poppinsTextTheme( // ganti font default jadi poppins
        Theme.of(context).textTheme,
        ),
      ),
      // halaman pertama yang dibuka splash screen
      home: const SplashScreen(), 
    );
  }
}