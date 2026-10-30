import 'package:flutter/material.dart';
import 'data_siswa.dart';
import 'page_input.dart';
import 'page_data_siswa.dart';
import 'page_login.dart';

class PageDashboard extends StatefulWidget {
  const PageDashboard({super.key});

  @override
  State<PageDashboard> createState() => _PageDashboardState();
}

class _PageDashboardState extends State<PageDashboard> {
  static const Color ungu = Color(0xFF833AB4);
  static const Color pink = Color(0xFFE1306C);
  static const Color orange = Color(0xFFF77737);
  static const Color background = Color(0xFFFAFAFA);

  void bukaHalaman(BuildContext context, String mode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageDataSiswa(mode: mode),
      ),
    ).then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  Widget kartuMenu({
    required BuildContext context,
    required String judul,
    required String deskripsi,
    required IconData ikon,
    required Color warna,
    required VoidCallback aksi,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: aksi,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: warna.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  ikon,
                  color: warna,
                  size: 26,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF262626),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                deskripsi,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 12),
              Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: warna,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalSiswa = DataSiswa.daftar.length;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        titleSpacing: 20,
        title: Row(
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [ungu, pink, orange],
                ).createShader(bounds);
              },
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 29,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Biodata Siswa',
              style: TextStyle(
                color: Color(0xFF262626),
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Keluar',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageLogin(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: pink,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Halo, Admin! 👋',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF262626),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Selamat datang di sistem informasi siswa.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              // Kartu statistik siswa
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ungu, pink, orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: pink.withValues(alpha: 0.20),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TOTAL SISWA',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$totalSiswa',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Data siswa terdaftar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.20),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(
                        Icons.groups_rounded,
                        size: 38,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Menu Utama',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF262626),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Pilih menu untuk mengelola data siswa.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 18),

              // Menu dalam grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final double lebarKartu =
                      (constraints.maxWidth - 14) / 2;

                  return Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: [
                      SizedBox(
                        width: lebarKartu,
                        child: kartuMenu(
                          context: context,
                          judul: 'Input Siswa',
                          deskripsi: 'Tambah data baru',
                          ikon: Icons.person_add_alt_1_rounded,
                          warna: ungu,
                          aksi: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const PageInput(),
                              ),
                            );

                            if (!mounted) return;

                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(
                        width: lebarKartu,
                        child: kartuMenu(
                          context: context,
                          judul: 'Lihat Data',
                          deskripsi: 'Daftar seluruh siswa',
                          ikon: Icons.groups_rounded,
                          warna: pink,
                          aksi: () => bukaHalaman(context, 'lihat'),
                        ),
                      ),
                      SizedBox(
                        width: lebarKartu,
                        child: kartuMenu(
                          context: context,
                          judul: 'Edit Data',
                          deskripsi: 'Ubah data siswa',
                          ikon: Icons.edit_rounded,
                          warna: const Color(0xFF405DE6),
                          aksi: () => bukaHalaman(context, 'edit'),
                        ),
                      ),
                      SizedBox(
                        width: lebarKartu,
                        child: kartuMenu(
                          context: context,
                          judul: 'Hapus Data',
                          deskripsi: 'Kelola data siswa',
                          ikon: Icons.delete_outline_rounded,
                          warna: const Color(0xFFE53935),
                          aksi: () => bukaHalaman(context, 'hapus'),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 28),

              // Informasi aplikasi
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: ungu,
                      size: 25,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informasi Aplikasi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Sistem pengelolaan biodata siswa.',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Center(
                child: Text(
                  'BIODATA SISWA • Flutter App',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}