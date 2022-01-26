import 'package:flutter/material.dart';
import 'package:vigoplace/widgets/custom_text.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CustomText(text: 'Profile Screen'),),
    );
  }
}