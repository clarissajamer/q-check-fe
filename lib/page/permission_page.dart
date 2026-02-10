import 'package:flutter/material.dart';
import 'package:q_check/content/permission_content.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  void _showPermissionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Agar border radius terlihat
      builder: (context) {
        return const PermissionContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF738A61), // Contoh warna background home
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2D4B37),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          onPressed: () => _showPermissionModal(context),
          child: const Text(
            'Buka Form Izin',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
