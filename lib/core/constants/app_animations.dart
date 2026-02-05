import 'package:flutter/material.dart';

/// Animation durations and curves used throughout the app
class AppAnimations {
  // Durations
  static const Duration fastest = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 700);
  
  // Curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve smoothCurve = Curves.easeOutCubic;
  static const Curve sharpCurve = Curves.easeInOutCubic;
  
  // Page transitions
  static const Curve pageTransitionCurve = Curves.easeInOutCubic;
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);
}
