import 'package:flutter/material.dart';

class AppBaris extends StatelessWidget {

  Widget build (BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Flutter'),
      ),

      body: Center(
        child: Row(
          children: [
            const Text('Hallo\n\n\n'),
            const Text('Selamat Datang\n\n\n'),
            const Text('di Aplikasi flutter\n\n\n'),

            ElevatedButton(onPressed: () {},
              child: const Text('Simpan'),
            ),
            ElevatedButton(onPressed: () {
              print('Di Tekan');
            },
                child: Text('Batal')),
          ],
        ),
      ),
    );
  }
}