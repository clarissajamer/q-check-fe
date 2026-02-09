import 'package:flutter/material.dart';
import 'package:q_check/content/home_content.dart';
import 'package:q_check/navbar.dart';
import 'package:q_check/page/scan_qr_page.dart';
import 'package:q_check/page/sidebar_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna background krem sesuai gambar
    const Color secondaryColor = Color(0xFFFAF0E6);

    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: secondaryColor,
      body: const HomeContent(),

      // Tombol QR Kuning di Tengah
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: SizedBox(
          width: 55,
          height: 55,
          child: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ScanQrPage()),
              );

              if (result != null) {
                debugPrint('Hasil QR: $result');
              }
            },
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFFF6DC43),
            elevation: 4,
            child: const Icon(
              Icons.qr_code_scanner,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 30,
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
