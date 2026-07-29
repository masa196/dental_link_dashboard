import 'package:flutter/widgets.dart';

class ScreenSizes {
  ScreenSizes._();

  static const double mobile = 600;
  static const double tablet = 1024;
}

class AppSizes {
  AppSizes._();


  static const double dashboardMinWidth = 650;
  static const double dashboardMinHeight = 500;

  static const EdgeInsets cardPadding = EdgeInsets.all(24);
  static const double cardRadius = 24;
  static const double buttonHeight = 52;
  static const double buttonRadius = 14;
  static const double buttonElevation = 2;

  static const double borderWidthThin = 1;
  static const double borderWidthSm = 1.2;
  static const double borderWidthMd = 1.4;
  static const double borderWidthLg = 1.5;
  static const double dividerThickness = 1;

  static const double menuButtonMinSize = 32;
  static const double sideNavWidthCompact = 84;
  static const double sideNavWidth = 240;
  static const double sideNavDrawerWidth = 280;
  static const double sideNavShortHeight = 620;
  static const double sideNavIconBox = 38;
  static const double sideNavItemHeight = 42;
  static const double sideNavIconSize = 20;

  static const double statsCardWidth = 400;
  static const double statsCardHeight = 78;
  static const double statsIconSize = 30;
  static const double statsShadowBlur = 8;
  static const double statsShadowOffsetY = 2;

  static const double tableRowHeight = 68;
  static const double tableActionsWidth = 120;
  static const double tableMinDataColumnWidth = 160;
  static const double tableTabsHeight = 50;
  static const double tablePagerDotSize = 24;

  static const double loginCardShadowBlurLg = 70;
  static const double loginCardShadowSpreadLg = 14;
  static const double loginCardShadowOffsetYLg = 36;
  static const double loginCardShadowBlurSm = 18;
  static const double loginCardShadowSpreadSm = 0;
  static const double loginCardShadowOffsetYSm = 8;

  static const double widgetCardValueHeight = 0.95;
  static const double skeletonCardHeight = 100;
  static const double skeletonTableRowHeight = 44;

  static const double alpha08 = 0.08;
  static const double alpha10 = 0.10;
  static const double alpha22 = 0.22;
  static const double alpha25 = 0.25;
  static const double alpha28 = 0.28;
  static const double alpha35 = 0.35;
  static const double alpha4 = 0.4;
  static const double alpha5 = 0.5;
  static const double alpha55 = 0.55;
  static const double alpha56 = 0.56;
  static const double alpha6 = 0.6;
  static const double alpha62 = 0.62;
  static const double alpha64 = 0.64;
  static const double alpha7 = 0.7;
  static const double alpha72 = 0.72;
  static const double alpha85 = 0.85;
  static const double alpha98 = 0.98;

  static double cardWidth(Size size) {
    if (size.width >= ScreenSizes.tablet) {
      return 480;
    }
    if (size.width >= ScreenSizes.mobile) {
      return 460;
    }
    return size.width;
  }

  static EdgeInsets screenPadding(Size size) {
    if (size.width >= ScreenSizes.tablet) {
      return const EdgeInsets.symmetric(horizontal: 48, vertical: 24);
    }
    if (size.width >= ScreenSizes.mobile) {
      return const EdgeInsets.symmetric(horizontal: 28, vertical: 20);
    }
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  }
}
