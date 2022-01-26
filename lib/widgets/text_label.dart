import 'package:flutter/material.dart';
import 'package:vigoplace/core/colors/colors.dart';

import 'custom_text.dart';


class TextLabel extends StatelessWidget {
  final String text;
  const TextLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: CustomText(
        text: text,
       
        color: kDark,
      ),
    );
  }
}
