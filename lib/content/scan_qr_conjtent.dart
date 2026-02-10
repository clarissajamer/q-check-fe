import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrContent extends StatelessWidget {
  final MobileScannerController controller;
  final ValueChanged<String> onScanned;

  const ScanQrContent({
    super.key,
    required this.controller,
    required this.onScanned,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: (capture) {
            final barcode = capture.barcodes.first;
            final code = barcode.rawValue;

            if (code != null) {
              onScanned(code);
            }
          },
        ),

        // Overlay kotak scan
        Center(
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Text(
            'Arahkan QR ke dalam kotak',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
