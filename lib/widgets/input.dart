import 'package:flutter/material.dart';
import 'package:vigoplace/core/colors/colors.dart';


class InputField extends StatelessWidget {
  static String routeName = 'InputField';
  const InputField({
    Key? key,
    required this.hintText,
    this.labelText,
    required this.inputType,
    required this.obscureText,
    this.onSaved,

    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.controller, required this.borderSideColor,
  }) : super(key: key);
  final String hintText;
  final String? labelText;
  final TextInputType inputType;
  final bool obscureText;
  final ValueChanged? onSaved;
  final FormFieldValidator? validator;
  final ValueChanged? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final BorderSide borderSideColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        cursorColor: kLightGray,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: kDark,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: hintText,
          labelText: labelText,
          hintStyle: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500, color: kInputTextColor),
          fillColor: kWhite,
          filled: true,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRed),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRed),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPurple),
          ),
          errorStyle: TextStyle(color: kRed),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
            borderSide: borderSideColor,
          ),
          labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kInputTextColor),
        ),
        keyboardType: inputType,
        obscureText: obscureText,
        onSaved: onSaved,
        validator: validator,
        textAlign: TextAlign.left,
      ),
    );
  }
}
