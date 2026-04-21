import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 40),
          child: Column(
            children: [
              const Icon(
                Icons.security_outlined,
                size: 80,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                'Komitmen Privasi Kami',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Terakhir diperbarui: April 2026',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 30),

              _buildPrivacyCard(
                title: '1. Pengantar',
                content:
                    'Selamat datang di Ratting App. Kami dari Kelompok Tryhard sangat menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi Anda melalui teknologi enkripsi terbaru.',
              ),
              _buildPrivacyCard(
                title: '2. Pengumpulan Data',
                content:
                    'Kami hanya mengumpulkan informasi yang Anda berikan secara sukarela, seperti nama pengguna untuk personalisasi pengalaman aplikasi dan interaksi komentar pada film.',
              ),
              _buildPrivacyCard(
                title: '3. Keamanan Informasi',
                content:
                    'Tim Kelompok Tryhard menerapkan standar keamanan tinggi untuk mencegah akses tidak sah. Data Anda disimpan dalam lingkungan cloud yang terenkripsi dan dipantau secara berkala.',
              ),
              _buildPrivacyCard(
                title: '4. Penggunaan Pihak Ketiga',
                content:
                    'Aplikasi ini menggunakan layanan YouTube Player API. Dengan menggunakan fitur video, Anda juga tunduk pada Ketentuan Layanan dan Kebijakan Privasi YouTube.',
              ),
              _buildPrivacyCard(
                title: '5. Hak Pengguna',
                content:
                    'Anda berhak untuk mengubah atau menghapus data ulasan dan komentar Anda kapan saja melalui fitur manajemen akun yang kami sediakan.',
              ),

              const SizedBox(height: 30),

              const Text(
                'Dibuat dengan dedikasi tinggi oleh',
                style: TextStyle(color: Colors.white38, fontSize: 14),
              ),
              const Text(
                'KELOMPOK TRYHARD',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacyCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
