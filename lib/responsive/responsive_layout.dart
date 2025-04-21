import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

enum DisplayType {
  desktop,
  mobile,
}

const _desktopPortraitBreakpoint = 700.0;
const _desktopLandscapeBreakpoint = 1000.0;
const _ipadProBreakpoint = 1000.0;

DisplayType displayTypeOf(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final width = MediaQuery.of(context).size.width;

  if ((orientation == Orientation.landscape && width > _desktopLandscapeBreakpoint) ||
      (orientation == Orientation.portrait && width > _desktopPortraitBreakpoint)) {
    return DisplayType.desktop;
  } else {
    return DisplayType.mobile;
  }
}

bool isDisplayDesktop(BuildContext context) {
  return displayTypeOf(context) == DisplayType.desktop;
}

bool isDisplaySmallDesktop(BuildContext context) {
  return isDisplayDesktop(context) && MediaQuery.of(context).size.width < _desktopLandscapeBreakpoint;
}

bool isDisplaySmallDesktopOrIpadPro(BuildContext context) {
  return isDisplaySmallDesktop(context) ||
      (MediaQuery.of(context).size.width > _ipadProBreakpoint && MediaQuery.of(context).size.width < 1170);
}

double widthOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double heightOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double assignHeight(BuildContext context, double fraction, {double additions = 0.0, double subs = 0.0}) {
  return (heightOfScreen(context) - subs + additions) * fraction;
}

double assignWidth(BuildContext context, double fraction, {double additions = 0, double subs = 0}) {
  return (widthOfScreen(context) - subs + additions) * fraction;
}

double responsiveSize(BuildContext context, double xs, double lg, {double? sm, double? md, double? xl}) {
  return context.layout.value(
    xs: xs,
    sm: sm ?? (md ?? xs),
    md: md ?? lg,
    lg: lg,
    xl: xl ?? lg,
  );
}

int responsiveSizeInt(BuildContext context, int xs, int lg, {int? sm, int? md, int? xl}) {
  return context.layout.value(
    xs: xs,
    sm: sm ?? (md ?? xs),
    md: md ?? lg,
    lg: lg,
    xl: xl ?? lg,
  );
}

Color responsiveColor(BuildContext context, Color xs, Color lg, {Color? sm, Color? md, Color? xl}) {
  return context.layout.value(
    xs: xs,
    sm: sm ?? (md ?? xs),
    md: md ?? lg,
    lg: lg,
    xl: xl ?? lg,
  );
}

double getSidePadding(BuildContext context) {
  double sidePadding = assignWidth(context, 0.05);
  return responsiveSize(context, 30, sidePadding, md: sidePadding);
}

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
bool isTab(BuildContext context) => MediaQuery.of(context).size.width < 1300 && MediaQuery.of(context).size.width >= 650;
bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1300;

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
  });

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 400) {
          return mobileBody;
        } else if (constraints.maxWidth < 1100) {
          return tabletBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
