import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/models/cardModelDefault.dart';
import 'package:instapp/utils/iconGradient.dart';

import '../consts/colorsUtil.dart';
import '../consts/textStyle.dart';

class CardWidgetDefault extends StatelessWidget {
  CardWidgetDefault({super.key, required this.kartDetay});

  CardModelDefault kartDetay;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.w,
      margin: EdgeInsets.only(
        top: 9.w,
        left: 23.w,
        right: 22.w,
      ),
      width: 330.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: KColors.cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // KART IKON

              Container(
                margin: EdgeInsets.all(13.w),
                padding: EdgeInsets.all(9.w),
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
                child: kartDetay.widget ??
                    MyUtils.maskIcon(kartDetay.leftIcon, 27),
              ),
              Padding(
                // BASLIK TEXT
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kartDetay.baslik,
                      style: KTextStyle.KHeaderTextStyle(
                        fontSize: 12.sp,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.w),
                    // ACIKLAMA TEXT
                    Text(
                      kartDetay.baslikAciklama,
                      style: KTextStyle.KHeaderTextStyle(
                        fontSize: 8.sp,
                        textColor: KColors.textColorMini,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // FUNC ICON
          Padding(
            padding: EdgeInsets.only(right: 12.0.w, top: 25.w, bottom: 25.w),
            child: const Icon(
              Iconsax.arrow_right_3,
              color: Color(0xFFBABABA),
            ),
          )
        ],
      ),
    );
  }
}
