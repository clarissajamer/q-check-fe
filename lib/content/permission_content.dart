import 'package:flutter/material.dart';

class PermissionContent extends StatefulWidget {
  const PermissionContent({super.key});

  @override
  State<PermissionContent> createState() => _PermissionContentState();
}

class _PermissionContentState extends State<PermissionContent> {
  String selectedType = 'sakit'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F4EE), // Warna background krem kehijauan
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'permintaan ijin',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Row untuk Button Sakit dan Ijin
          Row(
            children: [
              Expanded(child: _buildToggleButton('sakit')),
              const SizedBox(width: 16),
              Expanded(child: _buildToggleButton('ijin')),
            ],
          ),
          const SizedBox(height: 24),

          // Text Field Keterangan
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFDDE3D5), // Warna box keterangan
              borderRadius: BorderRadius.circular(20),
            ),
            child: const TextField(
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'keterangan....',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Tombol Kirim ke Admin
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'kirim ke admin',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  // Tambahkan fungsi kirim di sini
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D4B37), // Warna hijau gelap tombol kirim
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Helper untuk membuat button toggle
  Widget _buildToggleButton(String type) {
    bool isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7D9173) : const Color(0xFF9FB094),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            type,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
