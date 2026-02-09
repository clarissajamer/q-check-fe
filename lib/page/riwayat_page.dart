import 'package:flutter/material.dart';
import 'package:q_check/content/riwayat_content.dart';

const Color _darkPurple = Color(0xFF3D2860);
const Color _primaryColor = Color(0xFF7243A9);

const Color _highlightColor = Color(0xFFFDD835);
const Color _cardColor = Color(0xFFF3E5F5);
const Color _scaffoldBackground = Color(0xFFFAF0E6);

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  final double _customAppBarHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, _customAppBarHeight),
      backgroundColor: _scaffoldBackground,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            //CONTAINER KECIL BAWAH APP BAR 
            child: Container(
              height: 12,
              width: 350,
              color:  _darkPurple,
            ),
          ),
          Expanded(
            child: RiwayatContent(
              primaryColor: _darkPurple,
              highlightColor: _highlightColor,
              cardColor: _cardColor,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, double height) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: AppBar(
          backgroundColor: _primaryColor,
          centerTitle: true,
          title: const Text(
            'Riwayat Quiz',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
