

import 'package:flutter/material.dart';




dynamic sizeFit(bool width, double value, BuildContext context) {
  if (width) {
    return MediaQuery.of(context).size.width * (value / 375.0);
  } else {
    return MediaQuery.of(context).size.height * (value / 809.0);
  }
}

size(BuildContext context) => MediaQuery.of(context).size;

mediaSize(BuildContext context) {
  double fontScale = 1;
  double deviceHeight = size(context).height;
  if (deviceHeight > 740) {
    fontScale = 1.11;
  }
  if (deviceHeight < 740) {
    fontScale = 0.99;
  }
  if (deviceHeight < 645) {
    fontScale = 0.9;
  }
  if (deviceHeight < 615) {
    fontScale = 0.83;
  }
  return fontScale;
}
