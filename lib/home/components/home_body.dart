import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/home/components/home_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/constants.dart';
import 'package:flutter_starter_kit/scan_qr_code.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

String i = '';

class HomeBody extends StatelessWidget {
  HomeBody({super.key, required this.loggedIn});
  final bool loggedIn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loggedIn ? _loggedInContent(context) : _initialContent();
  }

  Widget _initialContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.w),
      decoration: roundedBoxRegular,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpaceMedium,
          Text(
            "MSI-AMS is an attendance management system  made  to automate attendance process using QR-code technology.",
            textAlign: TextAlign.center,
            style: kRobotoText.copyWith(
                fontWeight: kFwBlack,
                color: Colors.white,
                fontSize: kHeadingThree),
          ),
          verticalSpaceMedium,
          Text(
            "Check SDC's social handles also!",
            textAlign: TextAlign.center,
            style:
                kTitleText.copyWith(fontWeight: kFwBlack, color: Colors.white),
          ),
          verticalSpaceMedium,
          MaterialButton(
            elevation: 0,
            color: Colors.white,
            onPressed: () {
              launchUrl(Uri.parse(docsUrl));
            },
            child: Text(
              'Social Handles',
              textAlign: TextAlign.center,
              style: kRobotoText.copyWith(
                  fontWeight: kFwBlack,
                  color: Colors.black,
                  fontSize: kHeadingTwo),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loggedInContent(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "IP",
                    hintText: "Enter your IP address here...",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.cast_connected),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Don't forget to enter IP";
                    } else {
                      i = value;
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                )
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ScanQRCode()));
              }
            },
            child: const Text("Go")),
      ],
    );
  }
}
