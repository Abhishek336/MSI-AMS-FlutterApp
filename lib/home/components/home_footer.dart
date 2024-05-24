import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MSI-AMS',
            style: kTitleText.copyWith(fontSize: kBodyRegular),
          ),
          verticalSpaceSmall,
          RichText(
            text: TextSpan(
                text: 'Made By: ',
                style: kTitleText.copyWith(fontSize: kBodySmall),
                children: [
                  TextSpan(
                      text: 'Software Development Cell',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(helpUrl));
                        })
                ]),
          ),
          verticalSpaceSmall,
          Text(
            '© 2024 SDC, Inc. All rights reserved',
            style: kRobotoText.copyWith(
                fontWeight: kFwMedium, color: kColorGrey, fontSize: kCaption),
          ),
        ],
      ),
    );
  }
}
