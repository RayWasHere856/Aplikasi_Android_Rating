import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'login_screen.dart'; 

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                  ),
                  child: const Icon(
                    Icons.gavel_rounded, 
                    size: 50, 
                    color: Colors.blueAccent
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'PROTOKOL PRIVASI',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'KEBIJAKAN PENGGUNA & DATA',
                  style: TextStyle(
                    color: Colors.blueAccent, 
                    fontSize: 12, 
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                  ),
                ),
                
                const SizedBox(height: 30),
                
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPoint(
                            'KOMITMEN KELOMPOK TRYHARD',
                            'Kami membangun Ratting App dengan standar enkripsi militer untuk memastikan setiap data ulasan dan identitas Anda tetap anonim dan aman.',
                          ),
                          _buildPoint(
                            'OTORISASI YOUTUBE',
                            'Layanan cuplikan video didukung oleh YouTube API. Penggunaan fitur ini berarti Anda menyetujui kebijakan privasi Google terkait streaming data.',
                          ),
                          _buildPoint(
                            'KEDAULATAN DATA',
                            'Kelompok Tryhard tidak membagikan data kepada pihak ketiga. Informasi Anda digunakan secara eksklusif untuk personalisasi algoritma film Anda.',
                          ),
                          _buildPoint(
                            'INTEGRITAS KOMUNITAS',
                            'Anda bertanggung jawab atas setiap komentar yang dipublikasikan. Kami berhak menghapus konten yang melanggar norma komunitas.',
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              'END OF DOCUMENT',
                              style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 15,
                      shadowColor: Colors.blueAccent.withOpacity(0.4),
                    ),
                    child: const Text(
                      'SETUJU & MASUK KE SISTEM',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 25),
                const Text(
                  'VERSION 1.0.0 // BY KELOMPOK TRYHARD',
                  style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 1),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPoint(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.blueAccent, size: 18),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}