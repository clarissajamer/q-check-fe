import 'package:flutter/material.dart';
import 'package:q_check/navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Fungsi untuk menampilkan pop-out modal sheet
  void _showAddQuizModal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Container(
          width: 55,
          height: 55,
          child: FloatingActionButton(
            // 💡 IMPLEMENTASI onPresed DI SINI
            onPressed: () {
              _showAddQuizModal(context);
            },
            backgroundColor: Color(0xFFF6DC43),
            elevation: 3,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          // 1. Background Image (Header)
          Container(
            height: screenHeight * 0.8,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Camera Icon (Top Right)
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                // Action to change photo
              },
            ),
          ),

          // 3. White Content Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 550, // Adjust height to overlap background
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 70,
                  left: 25,
                  right: 25,
                  bottom: 20,
                ),
                child: ListView(
                  // Use ListView for scrolling on small screens
                  padding: EdgeInsets.zero,
                  children: [
                    // Name
                    const Text(
                      'dafarina salsabila',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // User Name
                    _buildProfileField('user name :', 'karina'),
                    const SizedBox(height: 15),

                    // Email
                    _buildProfileField('email :', 'dafarinakarin@gmail.com'),
                    const SizedBox(height: 15),

                    // Alamat
                    _buildProfileField('alamat :', 'KH.Abdullah.Bin.Nuh'),
                    const SizedBox(height: 30),

                    // Action Buttons
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: _buildActionButton(
                    //         label: 'pusat bantuan',
                    //         color: const Color(0xFFF6DC43),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 15),
                    //     Expanded(
                    //       child: _buildActionButton(
                    //         label: 'bank soal',
                    //         color: const Color(0xFFF6DC43),
                    //         icon: Icons.account_balance_outlined,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Extra space for navbar
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top:
                (screenHeight * 0.3) -
                60, // Adjust based on background height (0.4) vs card start (0.3)
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  image: const DecorationImage(
                    image: AssetImage('images/maskot.png'), // Placeholder image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const Divider(color: Colors.grey, thickness: 1),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.black),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
