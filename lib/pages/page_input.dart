import 'package:flutter/material.dart';
import 'data_siswa.dart';
import 'data_siswa.dart';

class PageInput extends StatefulWidget {
  const PageInput({super.key});

  @override
  State<PageInput> createState() => _PageInputState();
}

class _PageInputState extends State<PageInput> {
  final namaController = TextEditingController();
  final nisController = TextEditingController();
  final kelasController = TextEditingController();
  final alamatController = TextEditingController();

  String jenisKelamin = 'Laki-laki';

  void simpanData() {
    final nama = namaController.text.trim();
    final nis = nisController.text.trim();
    final kelas = kelasController.text.trim();
    final alamat = alamatController.text.trim();

    if (nama.isEmpty ||
        nis.isEmpty ||
        kelas.isEmpty ||
        alamat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua data harus diisi!'),
        ),
      );
      return;
    }

    final duplikat = DataSiswa.daftar.any(
          (siswa) => siswa.nis == nis,
    );

    if (duplikat) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('NIS sudah terdaftar!'),
        ),
      );
      return;
    }

    DataSiswa.daftar.add(
      Siswa(
        nama: nama,
        nis: nis,
        kelas: kelas,
        jenisKelamin: jenisKelamin,
        alamat: alamat,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data siswa berhasil disimpan!'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    namaController.dispose();
    nisController.dispose();
    kelasController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Biodata Siswa'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.assignment_ind,
                  size: 70,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: nisController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'NIS',
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: kelasController,
                  decoration: const InputDecoration(
                    labelText: 'Kelas',
                    prefixIcon: Icon(Icons.school),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  initialValue: jenisKelamin,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Kelamin',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Laki-laki',
                      child: Text('Laki-laki'),
                    ),
                    DropdownMenuItem(
                      value: 'Perempuan',
                      child: Text('Perempuan'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        jenisKelamin = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: alamatController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    prefixIcon: Icon(Icons.home),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton.icon(
                  onPressed: simpanData,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan Data'),
                ),

                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}