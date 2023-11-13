import 'package:flutter/material.dart';

Widget transitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final Tween<Offset> tweenEntry = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.0, 0.0),
  );

  final Tween<Offset> tweenExit = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: const Offset(0.0, 0.0),
  );

  final CurvedAnimation curvedAnimationEntry = CurvedAnimation(
    parent: animation,
    curve: const Interval(
      0.0,
      1.0,
      curve: Curves.easeInOutSine,
    ),
  );

  final CurvedAnimation curvedAnimationExit = CurvedAnimation(
    parent: secondaryAnimation,
    curve: const Interval(
      0.0,
      1.0,
      curve: Curves.easeInOutSine,
    ),
  );

  return SlideTransition(
    position: tweenExit.animate(curvedAnimationExit),
    child: SlideTransition(
      position: tweenEntry.animate(curvedAnimationEntry),
      child: child,
    ),
  );
}

Duration transitionDuration() {
  return const Duration(milliseconds: 250);
}
