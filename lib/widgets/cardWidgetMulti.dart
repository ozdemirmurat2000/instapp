import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/utils/iconGradient.dart';

class CardWidgetMulti extends StatelessWidget {
  CardWidgetMulti({
    super.key,
    required this.leftIcon,
    required this.leftText,
    required this.leftValueText,
    required this.rightIcon,
    required this.rightText,
    required this.rightValueText,
    this.widget,
  });

  String leftText;
  String leftValueText;
  IconData leftIcon;
  String rightText;
  String rightValueText;
  IconData rightIcon;
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 22.w,
        right: 22.w,
        top: 9.h,
      ),
      width: 330.w,
      height: 109.h,
      decoration: BoxDecoration(
        color: KColors.cardColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT DETAIL
          Row(
            children: [
              // ICON

              Container(
                margin: EdgeInsets.only(
                  bottom: 21.h,
                  left: 12.w,
                  right: 12.w,
                  top: 21.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      KColors.textColorLinearStart.withOpacity(0.1),
                      KColors.textColorLinearMiddle.withOpacity(0.1),
                      KColors.textColorLinearEnd.withOpacity(0.1),
                    ],
                  ),
                ),
                padding: EdgeInsets.all(10.w),
                child: widget ?? MyUtils.maskIcon(leftIcon, 24),
              ),

              Padding(
                padding: EdgeInsets.only(top: 25.0.w, bottom: 25.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BASLIK
                    Text(
                      '+$leftValueText',
                      style: KTextStyle.KHeaderTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: KColors.cardPositiveColor,
                      ),
                    ),

                    // BASLIK ACIKLAMA

                    Text(leftText,
                        style: KTextStyle.KHeaderTextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                        )),
                  ],
                ),
              )
            ],
          ),
          Container(
            width: 1,
            height: 66.w,
            color: const Color(0xFF161616),
          ),
          // RIGHT DETAIL

          Row(
            children: [
              // ICON

              Container(
                margin: EdgeInsets.only(
                  bottom: 21.h,
                  right: 12.w,
                  top: 21.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      KColors.textColorLinearStart.withOpacity(0.1),
                      KColors.textColorLinearMiddle.withOpacity(0.1),
                      KColors.textColorLinearEnd.withOpacity(0.1),
                    ],
                  ),
                ),
                padding: EdgeInsets.all(10.w),
                child: MyUtils.maskIcon(rightIcon, 24),
              ),

              Padding(
                padding:
                    EdgeInsets.only(top: 25.0.w, bottom: 25.w, right: 14.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BASLIK
                    Text(
                      int.parse(rightValueText) > 0
                          ? '-$rightValueText'
                          : rightValueText,
                      style: KTextStyle.KHeaderTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: const Color(0xFFCE2828),
                      ),
                    ),

                    // BASLIK ACIKLAMA

                    Text(rightText,
                        style: KTextStyle.KHeaderTextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                        )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
