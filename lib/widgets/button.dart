import 'package:flutter/material.dart';
import 'package:vigoplace/core/constants/sizes.dart';
import 'package:vigoplace/widgets/custom_text.dart';

class Button extends StatelessWidget {
  static String routeName = 'Button';
  const Button(
      {required this.buttonText,
      required this.color,
      required this.textColor,
      required this.onPressed,
      required this.width,
      required this.fontSize});

  final String buttonText;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: sizeFit(false, 50, context),
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: CustomText(
          text: buttonText,
          textScaleFactor: mediaSize(context),
          color: textColor,
          size: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
