import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigoplace/core/constants/sizes.dart';

class CustomText extends StatelessWidget {
  static String routeName = 'CustomText';
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final String? fontFamily;
  final Color? color;
  final double? wordSpacing;
  final VoidCallback? onClick;

  const CustomText({
    required this.text,
    this.textAlign,
    this.textScaleFactor,
    this.fontFamily,
    this.size,
    this.fontWeight,
    this.color,
    this.wordSpacing,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Text(
              text,
              textAlign: textAlign ?? TextAlign.left,
              textScaleFactor: mediaSize(context),
              style: GoogleFonts.poppins( textStyle:TextStyle(
                height: 1.3,
                  fontSize: size ?? 15,
                  fontWeight: fontWeight ?? FontWeight.w500,
                  color: color,
                  wordSpacing: wordSpacing,
                  fontFamily:'Poppins'),
            ))
          : TextButton(
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding:
                  EdgeInsets.symmetric(horizontal: sizeFit(true, 15, context)),
              minimumSize:
                  Size(sizeFit(true, 23, context), sizeFit(true, 23, context)),
            ),
              onPressed: () {
                onClick!.call();
              },
              child: Text(
                text,
                textAlign: textAlign,
                textScaleFactor: mediaSize(context),
                style: TextStyle(
                    fontSize: size,
                    fontWeight: fontWeight,
                    color: color,
                    wordSpacing: wordSpacing,
                    fontFamily: fontFamily),
              ),
            ),
    );
  }
}
