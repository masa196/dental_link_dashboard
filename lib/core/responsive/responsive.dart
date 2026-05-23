import 'package:flutter/widgets.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';

class Responsive {
  Responsive._();

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < ScreenSizes.mobile;
  }

  static bool isTablet(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return width >= ScreenSizes.mobile && width < ScreenSizes.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= ScreenSizes.tablet;
  }
}
