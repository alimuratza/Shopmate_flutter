import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Premium UI Polish - Animations, effects, and modern touches
class PremiumUIPolish {
  // ✨ Bounce animation for buttons
  static Curve get bounceCurve => Curves.elasticOut;

  // 🌊 Wave animation for cards
  static Curve get waveCurve => Curves.easeInOutQuad;

  // 🎯 Smooth easing
  static Curve get smoothCurve => Curves.easeOutCubic;

  // 💫 Fade transition
  static Duration get fadeDuration => const Duration(milliseconds: 300);

  // 🚀 Quick animation
  static Duration get quickDuration => const Duration(milliseconds: 200);

  // ⚡ Ultra quick
  static Duration get ultraQuickDuration => const Duration(milliseconds: 100);

  // 🎬 Slow animation for emphasis
  static Duration get slowDuration => const Duration(milliseconds: 600);

  /// 🎨 Premium Box Shadow
  static List<BoxShadow> get premiumShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// ✨ Glassmorphism effect
  static BoxDecoration glassEffect({Color? backgroundColor}) {
    return BoxDecoration(
      color: (backgroundColor ?? Colors.white).withOpacity(0.7),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.white.withOpacity(0.2),
        width: 1.5,
      ),
    );
  }

  /// 🌈 Shimmer gradient
  static List<Color> get shimmerGradient => [
    Colors.grey.shade300,
    Colors.grey.shade200,
    Colors.grey.shade300,
  ];

  /// 📱 Mobile-first responsive breakpoints
  static const double mobileWidth = 600;
  static const double tabletWidth = 900;

  /// 🎯 Safe area padding for notches
  static EdgeInsets get safePadding => const EdgeInsets.all(16);

  /// 💎 Premium border radius
  static const double radiusExtraSmall = 8;
  static const double radiusSmall = 12;
  static const double radiusMedium = 16;
  static const double radiusLarge = 20;
  static const double radiusExtraLarge = 28;
}

/// 🎬 Animated Transition Delegate
class PremiumTransitionDelegate {
  static Widget fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  static Widget slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero);
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget scaleTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(scale: animation, child: child);
  }
}

// ✨ Example: Use in any Material Route
class PremiumPageRoute<T> extends MaterialPageRoute<T> {
  PremiumPageRoute({required WidgetBuilder builder})
      : super(builder: builder);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .chain(CurveTween(curve: PremiumUIPolish.smoothCurve)),
      ),
      child: child,
    );
  }
}
