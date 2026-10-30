import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {

  Widget build (BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Aplikasi Flutter',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'Arial',
            ),
          ),
          backgroundColor: Colors.amberAccent,
          foregroundColor: Colors.white,
        ),

        body : const Center(
          child: Text('Hallo Selamat Datang di Aplikasi Mobile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'Arial',
              color: Colors.blue,
            ),
          ),
        )

    );
  }
}