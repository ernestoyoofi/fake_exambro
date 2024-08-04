import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import './webview.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _navigateToWebView(BuildContext context, String url) {
    Navigator.pushReplacementNamed(context, '/webview', arguments: url);
  }

  Future<void> _scanQRCode() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRViewExample(
          onQRViewCreated: (controller) {
            controller.scannedDataStream.listen((scanData) {
              final scannedCode = scanData.code;
              if (scannedCode != null) {
                _navigateToWebView(context, scannedCode);
              }
              controller.dispose();
            });
          },
        ),
      ),
    );
  }

  Future<void> _scanQRCodeFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Implementasi scan QR code dari gambar
      File imageFile = File(pickedFile.path);
      // Implementasi untuk memproses gambar dan mendapatkan URL dari QR code
      // Setelah mendapatkan URL, panggil _navigateToWebView(context, url)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Masukkan IP address/alamat server",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToWebView(context, _controller.text);
              },
              child: Text("LANJUTKAN"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanQRCode,
              child: Text("SCAN QR CODE ALAMAT SERVER"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanQRCodeFromGallery,
              child: Text("SCAN QR CODE DARI GALLERY"),
            ),
            Spacer(),
            Image.asset('assets/somenote.png'), // Ganti dengan gambar Anda
          ],
        ),
      ),
    );
  }
}

class QRViewExample extends StatelessWidget {
  final Function(QRViewController) onQRViewCreated;

  QRViewExample({required this.onQRViewCreated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: GlobalKey(),
        onQRViewCreated: onQRViewCreated,
      ),
    );
  }
}
