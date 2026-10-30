import 'package:flutter/material.dart';
import 'data_siswa.dart';
import 'data_siswa.dart';

class PageDataSiswa extends StatefulWidget {
  final String mode;

  const PageDataSiswa({
    super.key,
    this.mode = 'lihat',
  });

  @override
  State<PageDataSiswa> createState() => _PageDataSiswaState();
}

class _PageDataSiswaState extends State<PageDataSiswa> {
  Future<void> editSiswa(Siswa siswa) async {
    final nama = TextEditingController(text: siswa.nama);
    final nis = TextEditingController(text: siswa.nis);
    final kelas = TextEditingController(text: siswa.kelas);
    final alamat = TextEditingController(text: siswa.alamat);

    String jenisKelamin = siswa.jenisKelamin;

    final hasil = await showDialog<Map<String, String>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Data Siswa'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nama,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                      ),
                    ),
                    TextField(
                      controller: nis,
                      decoration: const InputDecoration(
                        labelText: 'NIS',
                      ),
                    ),
                    TextField(
                      controller: kelas,
                      decoration: const InputDecoration(
                        labelText: 'Kelas',
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: jenisKelamin,
                      decoration: const InputDecoration(
                        labelText: 'Jenis Kelamin',
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
                          setDialogState(() {
                            jenisKelamin = value;
                          });
                        }
                      },
                    ),
                    TextField(
                      controller: alamat,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Alamat',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nama.text.trim().isEmpty ||
                        nis.text.trim().isEmpty ||
                        kelas.text.trim().isEmpty ||
                        alamat.text.trim().isEmpty) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text('Semua data harus diisi!'),
                        ),
                      );
                      return;
                    }

                    final nisBaru = nis.text.trim();

                    final duplikat = DataSiswa.daftar.any(
                          (item) =>
                      !identical(item, siswa) &&
                          item.nis == nisBaru,
                    );

                    if (duplikat) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'NIS sudah digunakan siswa lain!',
                          ),
                        ),
                      );
                      return;
                    }

                    Navigator.pop(
                      dialogContext,
                      {
                        'nama': nama.text.trim(),
                        'nis': nisBaru,
                        'kelas': kelas.text.trim(),
                        'jenisKelamin': jenisKelamin,
                        'alamat': alamat.text.trim(),
                      },
                    );
                  },
                  child: const Text('Simpan Perubahan'),
                ),
              ],
            );
          },
        );
      },
    );

    nama.dispose();
    nis.dispose();
    kelas.dispose();
    alamat.dispose();

    if (hasil != null && mounted) {
      setState(() {
        siswa.nama = hasil['nama']!;
        siswa.nis = hasil['nis']!;
        siswa.kelas = hasil['kelas']!;
        siswa.jenisKelamin = hasil['jenisKelamin']!;
        siswa.alamat = hasil['alamat']!;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil diperbarui!'),
        ),
      );
    }
  }

  Future<void> hapusSiswa(Siswa siswa) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Data'),
        content: Text('Yakin ingin menghapus data ${siswa.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (konfirmasi == true && mounted) {
      setState(() {
        DataSiswa.daftar.remove(siswa);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil dihapus!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final judul = switch (widget.mode) {
      'edit' => 'Edit Data Siswa',
      'hapus' => 'Hapus Data Siswa',
      _ => 'Data Siswa',
    };

    final daftar = DataSiswa.daftar;

    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: daftar.isEmpty
          ? const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_open,
              size: 70,
              color: Colors.grey,
            ),
            SizedBox(height: 12),
            Text(
              'Belum ada data siswa.',
              style: TextStyle(fontSize: 18),
            ),
            Text('Silakan input data terlebih dahulu.'),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftar.length,
        itemBuilder: (context, index) {
          final siswa = daftar[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    siswa.nama,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text('NIS: ${siswa.nis}'),
                  Text('Kelas: ${siswa.kelas}'),
                  Text('Jenis Kelamin: ${siswa.jenisKelamin}'),
                  Text('Alamat: ${siswa.alamat}'),
                  const SizedBox(height: 12),

                  if (widget.mode == 'edit')
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () => editSiswa(siswa),
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                      ),
                    ),

                  if (widget.mode == 'hapus')
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => hapusSiswa(siswa),
                        icon: const Icon(Icons.delete),
                        label: const Text('Hapus'),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}