import 'dart:ui' as ui;

class SizeConfig {
  static double get pixelRatio =>
      ui.PlatformDispatcher.instance.views.first.devicePixelRatio;

  static ui.Size get size =>
      ui.PlatformDispatcher.instance.views.first.physicalSize / pixelRatio;

  static double get width => size.width;

  static double get height => size.height;

  static double get kVerticalMargin => height * 0.02;

  static double get kHorizontalMargin => width * 0.03;

  static double getResponsiveFont(double fontSize) {
    final double widthInDp = width;
    final double physicalPixelWidth = width * pixelRatio;

    final double dpi = ((physicalPixelWidth / widthInDp) * 160) - 5;

    if (dpi <= 120) {
      return 0.25 * fontSize;
    } else if (dpi <= 160) {
      return (1 / 3) * fontSize;
    } else if (dpi <= 240) {
      return 0.5 * fontSize;
    } else if (dpi <= 320) {
      return 0.8 * fontSize;
    } else if (dpi <= 480) {
      return fontSize;
    } else if (dpi <= 600) {
      return 1.2 * fontSize;
    } else if (dpi <= 640) {
      return 1.4 * fontSize;
    } else {
      return 1.6 * fontSize;
    }
  }
}
