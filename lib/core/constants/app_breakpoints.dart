class AppBreakpoints {
  // Prevent instantiation
  AppBreakpoints._();

  /// Mobile breakpoint (below 768px)
  static const double mobile = 768;

  /// Tablet breakpoint (768px to 1023px)
  static const double tablet = 1024;

  /// Desktop breakpoint (1024px and above)
  static const double desktop = 1440;

  /// Small mobile (below 360px)
  static const double smallMobile = 360;

  /// Large desktop (above 1920px)
  static const double largeDesktop = 1920;

  /// Check if width is mobile size
  static bool isMobile(double width) => width < mobile;

  /// Check if width is tablet size
  static bool isTablet(double width) => width >= mobile && width < tablet;

  /// Check if width is desktop size
  static bool isDesktop(double width) => width >= tablet;

  /// Check if width is small mobile size
  static bool isSmallMobile(double width) => width < smallMobile;

  /// Check if width is large desktop size
  static bool isLargeDesktop(double width) => width >= largeDesktop;
}
