import 'dart:async';
import 'package:flutter/material.dart';
import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    // Delay sebentar lalu mulai animasi
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
    });

    // Setelah 3 detik, pindah ke halaman berikutnya
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(seconds: 2),
          child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            width: _visible ? 150 : 50,  // scaling effect
            height: _visible ? 150 : 50,
            child: Image.asset(
              "assets/images/solecode.png", // ganti dengan path gambar kamu
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}