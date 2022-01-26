import 'package:flutter/material.dart';
import 'package:vigoplace/core/colors/colors.dart';
import 'package:vigoplace/core/constants/sizes.dart';
import 'package:vigoplace/widgets/custom_text.dart';

class TopNavigation extends StatelessWidget {
  final String title;
  final Widget widget;
  const TopNavigation({required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeFit(true, 15, context)),
                  minimumSize: Size(
                      sizeFit(true, 23, context), sizeFit(true, 23, context)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: kMainBlack,
                    ),
                   
                  ],
                ),
              ),
              SizedBox(
                width: 39,
              ),
              CustomText(
                text: title,
                fontWeight: FontWeight.w600,
                color: kDark,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: widget,
          )
        ],
      ),
    );
  }
}
