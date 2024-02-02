import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'XR',
              style: KTextStyle.KHeaderTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                textColor: KColors.textColorLinearStart,
              )),
          TextSpan(
              text: 'eports',
              style: KTextStyle.KHeaderTextStyle(
                fontSize: 16.sp,
                textColor: KColors.textColorLinearMiddle,
              )),
          TextSpan(
            text: '+',
            style: KTextStyle.KHeaderTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              textColor: KColors.textColorLinearEnd,
            ),
          ),
        ],
      ),
    );
  }
}
