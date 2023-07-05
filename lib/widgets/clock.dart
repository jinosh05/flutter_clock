import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class Clock extends StatelessWidget {
  const Clock({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 35.w,
        height: 35.w,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 8.sp,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(6.0, 6.0),
              blurRadius: 8.sp,
            ),
          ],
          color: const Color(0xFF292D32),
        ),
        child: child);
  }
}
