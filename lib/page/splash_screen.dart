import 'package:flutter/material.dart';
import 'package:q_check/page/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Durasi animasi 5 detik sesuai request
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Efek Zoom In
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // Efek Fade In
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // Navigasi ke LoginPage setelah 5 detik
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mengganti Container dengan Stack untuk menumpuk Background dan Konten
      body: Stack(
        children: [
          // 1. Background Image (bg1.png)
          // Pastikan path aset Anda benar (misalnya: 'assets/images/bg1.png')
          Image.asset(
            'assets/images/bg1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Optional: Overlay untuk memastikan teks/logo tetap terbaca
          Container(
            color: Colors.black.withOpacity(
              0.1,
            ), // Tambahkan sedikit overlay gelap
          ),

          // 2. Konten Tengah (Logo dan Nama Aplikasi)
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo (logo.png)
                        // Pastikan path aset Anda benar (misalnya: 'assets/images/logo.png')
                        // Atur ukuran sesuai kebutuhan
                        Image.asset('images/logo.png', width: 150, height: 150),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
