import 'package:flutter/cupertino.dart';

class IconSizeUtil {
  double smallIcon(BuildContext context) => MediaQuery.of(context).size.width * (16 / 430); // Size 16
  double mediumIcon(BuildContext context) => MediaQuery.of(context).size.width * (24 / 430); // Size 24
  double largeIcon(BuildContext context) => MediaQuery.of(context).size.width * (32 / 430); // Size 32
}

class SpacingUtil {
  static const double _baseWidth = 430;
  static const double _baseHeight = 932;

  static double scaleWidth(BuildContext context, double size) =>
      MediaQuery.of(context).size.width * (size / _baseWidth);

  static double scaleHeight(BuildContext context, double size) =>
      MediaQuery.of(context).size.height * (size / _baseHeight);

  // Spacing theo chiều ngang (Width)
  static double spacingWidth8(BuildContext context) => scaleWidth(context, 8);
  static double spacingWidth12(BuildContext context) => scaleWidth(context, 12);
  static double spacingWidth16(BuildContext context) => scaleWidth(context, 16);
  static double spacingWidth24(BuildContext context) => scaleWidth(context, 24);
  static double spacingWidth32(BuildContext context) => scaleWidth(context, 32);

  // Spacing theo chiều dọc (Height)
  static double spacingHeight8(BuildContext context) => scaleHeight(context, 8);
  static double spacingHeight12(BuildContext context) => scaleHeight(context, 12);
  static double spacingHeight16(BuildContext context) => scaleHeight(context, 16);
  static double spacingHeight24(BuildContext context) => scaleHeight(context, 24);
  static double spacingHeight32(BuildContext context) => scaleHeight(context, 32);
  static double spacingHeight48(BuildContext context) => scaleHeight(context, 48);
  static double spacingHeight56(BuildContext context) => scaleHeight(context, 56);
}

class LogoSizeUtil {
  static const double _baseWidth = 430;

  static double _scaleWidth(BuildContext context, double size) =>
      MediaQuery.of(context).size.width * (size / _baseWidth);

  static double small(BuildContext context) => _scaleWidth(context, 48);
  static double medium(BuildContext context) => _scaleWidth(context, 96);
  static double large(BuildContext context) => _scaleWidth(context, 160);
}