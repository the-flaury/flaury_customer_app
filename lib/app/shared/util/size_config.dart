import 'package:flutter/material.dart';

const double designScreenHeight = 812;
const double designScreenWidth = 375;

class SizeConfig {
  // this takes the height of the phone divides it by 100, and mutiplies it by the designheight in percentages, but you have to calculate percentages
  static double fromHeight(BuildContext context, double height) {
    double phoneHeight = MediaQuery.of(context).size.height;
    return (phoneHeight / 100) * height;
  }
  // this takes the width of the phone divides it by 100, and mutiplies it by the designWidth in percentages, but you have to calculate percentages

  static double fromWidth(BuildContext context, double width) {
    double phoneWidth = MediaQuery.of(context).size.width;
    return (phoneWidth / 100) * width;
  }

  static double fontSize(BuildContext context, double size) {
    double phoneHeight = MediaQuery.sizeOf(context).height;
    double phoneWidth = MediaQuery.sizeOf(context).width;

    // Reference dimensions for mobile and web
    double referenceWidth =
        phoneWidth < phoneHeight ? 375 : 1440; // Mobile vs web width
    double referenceHeight =
        phoneWidth < phoneHeight ? 812 : 900; // Mobile vs web height

    // Calculate scaling factor based on the smaller dimension
    double scalingFactor = phoneWidth < phoneHeight
        ? phoneWidth / referenceWidth
        : phoneHeight / referenceHeight;

    // Return the scaled font size
    return size * scalingFactor;
  }

// instead of mauallly calculating percentages we specifiy the design height divide it by the DesignScreenHeight and multiply it by the current Phone's height
  static double fromDesignHeight(BuildContext context, double designHeight) {
    // Get the actual height of the device's screen
    double phoneHeight = MediaQuery.sizeOf(context).height;

    // Calculate the height proportion based on the design height
    // and the design screen height, then scale it to the actual screen height
    return (designHeight / designScreenHeight) * phoneHeight;
  }

  static double fromDesignWidth(BuildContext context, double designWidth) {
    // Get the actual width of the device's screen
    double phoneWidth = MediaQuery.sizeOf(context).width;

    // Calculate the width proportion based on the design width
    // and the design screen width, then scale it to the actual screen width
    return (designWidth / designScreenWidth) * phoneWidth;
  }
}
