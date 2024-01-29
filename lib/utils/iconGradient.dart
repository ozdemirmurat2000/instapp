import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instapp/consts/colorsUtil.dart';

class MyUtils {
  static ShaderMask maskIcon(IconData iconData, double size, {Color? color}) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: const [.5, 1],
        colors: [
          color ?? KColors.textColorLinearStart,
          color ?? KColors.textColorLinearEnd
        ],
      ).createShader(bounds),
      child: Icon(
        iconData,
        size: size.w,
      ),
    );
  }
}
