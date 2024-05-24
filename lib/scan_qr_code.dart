import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_kit/constants.dart';
import 'package:flutter_starter_kit/home/components/home_header.dart';
import 'package:flutter_starter_kit/home/components/home_body.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String qrResult = "Scan qr to mark attendance";

  void showToast() {
    Fluttertoast.showToast(
        msg: qrResult,
        // The message to be shown
        toastLength: Toast.LENGTH_LONG,
        // Duration for which the toast should be visible
        gravity: ToastGravity.BOTTOM,
        // Position of the toast on the screen
        timeInSecForIosWeb: 5,
        // Duration for iOS and Web
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        // Background color of the toast
        textColor: const Color.fromARGB(255, 255, 255, 255),
        // Text color of the toast
        fontSize: 14.0 // Font size of the text
        );
  }

  Future<void> scanQR() async {
    showToast();
    try {
      final body = jsonEncode({"email": pfp?.email});
      final headers = {"Content-Type": "application/json"};
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      final url = 'http://$i:5000/${qrCode.toString()}';
      final qr = await http.post(Uri.parse(url), headers: headers, body: body);

      final res = jsonDecode(qr.body);

      qrResult = res['message'];
      showToast();
      if (!mounted) return;
      setState(() {
        //this.qrResult = qrCode.toString();
        //qrResult = 'http://$i:5000/${qrCode.toString()} -H "Content-Type: application/json" -d \'{"email": "$e"}';
      });
    } on PlatformException {
      //qrResult = "Failed to read QR code";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MSI-AMS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: ClipOval(
                child: Image.network(
                  '${pfp?.picture}',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            verticalSpaceRegular,
            Text(
              '${pfp?.givenName} ${pfp?.familyName} ',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: kHeadingTwo),
            ),
            verticalSpaceSmall,
            Text(
              'Email : ${pfp?.email}  ',
              style: const TextStyle(color: Colors.black),
            ),
            verticalSpaceLarge,
            const Text(
              'Click on mark attendance to scan QR',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: scanQR, child: const Text("Mark attendance")),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  //js.context.callMethod('open',['www.google.com']);
                  //showToast();
                  launchUrl(Uri.parse("http://$i:3000/view-attendance"));
                },
                child: const Text("View attendance"))
          ],
        ),
      ),
    );
  }
}
