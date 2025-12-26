import 'package:flutter/material.dart';
import '../constants/app_breakpoints.dart';

class ResponsiveHelper {
  /// Check if the current screen is mobile size
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppBreakpoints.mobile;
  }

  /// Check if the current screen is tablet size
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppBreakpoints.mobile && width < AppBreakpoints.tablet;
  }

  /// Check if the current screen is desktop size
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppBreakpoints.tablet;
  }

  /// Get responsive value based on screen size
  /// If tablet value is not provided, it defaults to mobile value
  static double getResponsiveValue(
    BuildContext context, {
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return desktop;
  }

  /// Get responsive integer value based on screen size
  static int getResponsiveIntValue(BuildContext context, {required int mobile, int? tablet, required int desktop}) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return desktop;
  }

  /// Get cross axis count for grids based on screen size
  /// Returns 1 for mobile, 2 for tablet, 3 for desktop
  static int getCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }

  /// Get custom cross axis count for grids
  static int getCustomCrossAxisCount(
    BuildContext context, {
    required int mobile,
    required int tablet,
    required int desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  /// Get horizontal padding based on screen size
  static double getHorizontalPadding(BuildContext context) {
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 32.0;
    return 64.0;
  }

  /// Get vertical padding based on screen size
  static double getVerticalPadding(BuildContext context) {
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 24.0;
    return 32.0;
  }

  /// Get custom horizontal padding
  static double getCustomHorizontalPadding(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  /// Get custom vertical padding
  static double getCustomVerticalPadding(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  /// Get font size based on screen size
  static double getFontSize(BuildContext context, {required double mobile, double? tablet, required double desktop}) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return desktop;
  }

  /// Get icon size based on screen size
  static double getIconSize(BuildContext context) {
    if (isMobile(context)) return 20.0;
    if (isTablet(context)) return 24.0;
    return 28.0;
  }

  /// Get custom icon size
  static double getCustomIconSize(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  /// Get button height based on screen size
  static double getButtonHeight(BuildContext context) {
    if (isMobile(context)) return 48.0;
    if (isTablet(context)) return 52.0;
    return 56.0;
  }

  /// Get app bar height based on screen size
  static double getAppBarHeight(BuildContext context) {
    if (isMobile(context)) return 56.0;
    if (isTablet(context)) return 64.0;
    return 72.0;
  }

  /// Get border radius based on screen size
  static double getBorderRadius(BuildContext context) {
    if (isMobile(context)) return 8.0;
    if (isTablet(context)) return 12.0;
    return 16.0;
  }

  /// Get card elevation based on screen size
  static double getCardElevation(BuildContext context) {
    if (isMobile(context)) return 2.0;
    if (isTablet(context)) return 4.0;
    return 6.0;
  }

  /// Get maximum content width for centered layouts
  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 900.0;
    return 1200.0;
  }

  /// Get spacing between elements
  static double getSpacing(BuildContext context) {
    if (isMobile(context)) return 8.0;
    if (isTablet(context)) return 12.0;
    return 16.0;
  }

  /// Get custom spacing
  static double getCustomSpacing(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  /// Check if screen is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if screen is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  /// Get responsive EdgeInsets
  static EdgeInsets getResponsiveEdgeInsets(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    required EdgeInsets desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return desktop;
  }

  /// Get responsive symmetric padding
  static EdgeInsets getResponsiveSymmetricPadding(BuildContext context, {double? horizontal, double? vertical}) {
    final h = horizontal ?? getHorizontalPadding(context);
    final v = vertical ?? getVerticalPadding(context);
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  /// Get responsive only padding
  static EdgeInsets getResponsiveOnlyPadding(
    BuildContext context, {
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: left ?? getHorizontalPadding(context),
      top: top ?? getVerticalPadding(context),
      right: right ?? getHorizontalPadding(context),
      bottom: bottom ?? getVerticalPadding(context),
    );
  }

  /// Get aspect ratio for images based on screen size
  static double getImageAspectRatio(BuildContext context) {
    if (isMobile(context)) return 16 / 9;
    if (isTablet(context)) return 16 / 10;
    return 21 / 9;
  }

  /// Build responsive widget based on screen size
  static Widget responsiveBuilder({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    required Widget desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return desktop;
  }

  /// Get number of columns for masonry/staggered grid
  static int getMasonryColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }

  /// Get dialog width based on screen size
  static double getDialogWidth(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    if (isMobile(context)) return screenWidth * 0.9;
    if (isTablet(context)) return screenWidth * 0.7;
    return screenWidth * 0.5;
  }

  /// Get bottom sheet max height
  static double getBottomSheetMaxHeight(BuildContext context) {
    final screenHeight = getScreenHeight(context);
    return screenHeight * 0.9;
  }

  /// Responsive SizedBox height
  static SizedBox responsiveHeight(
    BuildContext context, {
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    return SizedBox(
      height: getResponsiveValue(context, mobile: mobile, tablet: tablet, desktop: desktop),
    );
  }

  /// Responsive SizedBox width
  static SizedBox responsiveWidth(
    BuildContext context, {
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    return SizedBox(
      width: getResponsiveValue(context, mobile: mobile, tablet: tablet, desktop: desktop),
    );
  }

  /// Get text scale factor (for accessibility)
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  /// Check if device is small (less than 360px width)
  static bool isSmallDevice(BuildContext context) {
    return getScreenWidth(context) < 360;
  }

  /// Check if device is extra large (more than 1920px width)
  static bool isExtraLargeDevice(BuildContext context) {
    return getScreenWidth(context) > 1920;
  }

  /// Get grid child aspect ratio
  static double getGridChildAspectRatio(BuildContext context) {
    if (isMobile(context)) return 0.75;
    if (isTablet(context)) return 0.8;
    return 0.85;
  }

  /// Get custom grid child aspect ratio
  static double getCustomGridChildAspectRatio(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
}
