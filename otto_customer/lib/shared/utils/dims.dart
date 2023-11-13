import 'package:flutter/material.dart';

class Dims {
  Dims();

  // App was developed on an a Tab Emulator with dimension (w:h) of 1280:828
  // ? this should be replaced with the design dim.
  static Size designSize = const Size(1194.0, 834.0);
  static Size? deviceSize;

  // minimum screen size expectations
  static double minWidth = 767;
  static double minHeight = 500;

  // This is called once
  static void setSize(MediaQueryData media) {
    deviceSize = Size(
      media.size.width - (media.padding.left + media.padding.right),
      media.size.height - (media.padding.top + media.padding.bottom),
    );
  }

  static double quotient(double dim1, double dim2) {
    return dim1 > dim2 ? dim1 / dim2 : dim2 / dim1;
  }

  static double percentWidth(double p) {
    return deviceSize!.width * p / 100;
  }

  static bool isSupported() {
    return deviceSize!.width >= minWidth && deviceSize!.height >= minHeight;
  }

  static ContextDimensions Function(BuildContext) of = (BuildContext ctx) {
    return ContextDimensions(ctx);
  };

  static double dx(double x) {
    // dQuotient / designQuotient
    final double deviceRatio = quotient(deviceSize!.height, deviceSize!.width);
    final double designRatio = quotient(designSize.height, designSize.width);
    final double ratio = deviceRatio / designRatio;

    // return ratio * x * 0.89;
    return ratio * x;
  }
}

class ContextDimensions {
  const ContextDimensions(this._context);

  final BuildContext _context;

  double get width {
    return _context.size!.width;
  }

  double get height {
    return _context.size!.height;
  }

  double percentW(double p) {
    return width * p / 100;
  }

  double percentH(double p) {
    return height * p / 100;
  }
}
