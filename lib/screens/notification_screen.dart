import 'package:flutter/material.dart';
import 'package:vigoplace/widgets/custom_text.dart';
class NotificationScreen extends StatefulWidget {

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CustomText(text: 'Notification Screen'),),
    );
  }
}